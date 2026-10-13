// servidor estático do build web do passeio (:5052) — no-cache em tudo (Q-F155)
const http = require('http')
const fs = require('fs')
const path = require('path')

const root = path.resolve(process.argv[2])
const types = { '.html': 'text/html', '.js': 'application/javascript', '.mjs': 'application/javascript', '.json': 'application/json',
  '.css': 'text/css', '.png': 'image/png', '.svg': 'image/svg+xml', '.wasm': 'application/wasm', '.otf': 'font/otf', '.ttf': 'font/ttf',
  '.ico': 'image/x-icon' }

http.createServer((req, res) => {
  let p = decodeURIComponent(req.url.split('?')[0])
  if (p.endsWith('/')) p += 'index.html'
  let f = path.resolve(root, '.' + path.posix.normalize(p))
  if (!f.startsWith(root) || !fs.existsSync(f) || fs.statSync(f).isDirectory()) f = path.join(root, 'index.html')
  res.writeHead(200, { 'Content-Type': types[path.extname(f)] || 'application/octet-stream', 'Cache-Control': 'no-cache, no-store' })
  fs.createReadStream(f).pipe(res)
}).listen(5052, '127.0.0.1', () => console.log('[static] :5052 ->', root))
