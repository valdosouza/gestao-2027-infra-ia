// Proxy de FALHAS do passeio (D-F181/D-F185/D-F188): imita o nginx na frente de cada API. Controle por arquivo
// (proxy-mode.json, relido a cada requisição):
//   { "api":  { "mode": "pass" },
//     "nfse": { "mode": "502", "match": "^POST /v1/", "times": 1 } }
// mode: pass | 502 | 503 | 504 | hang (segura 70 s e devolve 504) | reset (derruba o socket)
// match: regex sobre "MÉTODO /caminho" (omitido = tudo, inclusive o preflight OPTIONS); times: falha N vezes e volta a pass.
// A página de erro sai SEM cabeçalho CORS — como a do nginx/Plesk — para ver o que o navegador entrega ao app.
'use strict'
const http = require('http')
const fs = require('fs')
const path = require('path')

const MODE_FILE = path.join(__dirname, 'proxy-mode.json')
const ROUTES = [
  { name: 'api', listen: 3011, upstream: 3010 },
  { name: 'nfse', listen: 3013, upstream: 3012 },
]
const used = {}

function modeFor(name, line) {
  let cfg = {}
  try { cfg = JSON.parse(fs.readFileSync(MODE_FILE, 'utf8'))[name] || {} } catch { cfg = {} }
  const mode = cfg.mode || 'pass'
  if (mode === 'pass') return 'pass'
  if (cfg.match && !new RegExp(cfg.match).test(line)) return 'pass'
  if (cfg.times) {
    const key = `${name}:${JSON.stringify(cfg)}`
    used[key] = (used[key] || 0) + 1
    if (used[key] > cfg.times) return 'pass'
  }
  return mode
}

const TITLES = { 502: '502 Bad Gateway', 503: '503 Service Temporarily Unavailable', 504: '504 Gateway Time-out' }
function nginxError(res, code) {
  const t = TITLES[code]
  res.writeHead(code, { 'Content-Type': 'text/html', Server: 'nginx' })
  res.end(`<html>\r\n<head><title>${t}</title></head>\r\n<body>\r\n<center><h1>${t}</h1></center>\r\n<hr><center>nginx</center>\r\n</body>\r\n</html>\r\n`)
}

for (const r of ROUTES) {
  http.createServer((req, res) => {
    const line = `${req.method} ${req.url}`
    const mode = modeFor(r.name, line)
    const stamp = new Date().toISOString().slice(11, 19)
    if (mode !== 'pass') console.log(`${stamp} [${r.name}] ${line} -> ${mode}`)
    if (mode === '502' || mode === '503' || mode === '504') return nginxError(res, Number(mode))
    if (mode === 'reset') return req.socket.destroy()
    if (mode === 'hang') { setTimeout(() => nginxError(res, 504), 70000); return }
    const up = http.request({ host: '127.0.0.1', port: r.upstream, method: req.method, path: req.url, headers: req.headers }, (ur) => {
      res.writeHead(ur.statusCode, ur.headers)
      ur.pipe(res)
    })
    up.on('error', () => nginxError(res, 502))   // upstream fora = o 502 do nginx
    req.pipe(up)
  }).listen(r.listen, '127.0.0.1', () => console.log(`[proxy] ${r.name} :${r.listen} -> :${r.upstream}`))
}
