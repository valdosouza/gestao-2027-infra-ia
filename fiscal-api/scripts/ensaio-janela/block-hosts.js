// Preload do PASSEIO (node --require block-hosts.js): recusa DNS/TCP/TLS para os hosts de PRODUÇÃO listados em
// PASSEIO_BLOCK_HOSTS (vírgulas; casa o nome exato ou sufixo ".nome"). A cópia descartável tem notas autorizadas em P e o A1
// real — nada que saia deste processo pode chegar ao fisco/banco de produção. Fora do repositório; só o processo do passeio.
'use strict'
const dns = require('dns')
const net = require('net')
const tls = require('tls')

const blocked = String(process.env.PASSEIO_BLOCK_HOSTS || '').split(',').map(s => s.trim().toLowerCase()).filter(Boolean)
if (blocked.length === 0) { throw new Error('PASSEIO: PASSEIO_BLOCK_HOSTS vazio — recuso subir sem o bloqueio') }

function isBlocked(host) {
  if (!host || typeof host !== 'string') return false
  const h = host.toLowerCase().replace(/\.$/, '')
  return blocked.some(b => h === b || h.endsWith('.' + b))
}
function refusal(host) {
  const e = new Error(`PASSEIO: conexão a ${host} BLOQUEADA (host de produção)`)
  e.code = 'ECONNREFUSED'
  return e
}
function hostOf(args) {
  const a = args[0]
  if (a && typeof a === 'object') return a.host || a.servername || a.hostname
  if (typeof args[1] === 'string') return args[1]
  if (args[1] && typeof args[1] === 'object') return args[1].host || args[1].servername
  return undefined
}

const origLookup = dns.lookup
dns.lookup = function (hostname, ...rest) {
  if (isBlocked(hostname)) {
    const cb = rest.find(r => typeof r === 'function')
    process.nextTick(() => cb && cb(refusal(hostname)))
    return {}
  }
  return origLookup.call(this, hostname, ...rest)
}
const origPLookup = dns.promises.lookup
dns.promises.lookup = function (hostname, ...rest) {
  if (isBlocked(hostname)) return Promise.reject(refusal(hostname))
  return origPLookup.call(this, hostname, ...rest)
}

for (const [mod, names] of [[net, ['connect', 'createConnection']], [tls, ['connect']]]) {
  for (const name of names) {
    const orig = mod[name]
    mod[name] = function (...args) {
      const host = hostOf(args)
      if (isBlocked(host)) throw refusal(host)
      return orig.apply(this, args)
    }
  }
}
process.stderr.write(`[passeio] bloqueados: ${blocked.join(', ')}\n`)
