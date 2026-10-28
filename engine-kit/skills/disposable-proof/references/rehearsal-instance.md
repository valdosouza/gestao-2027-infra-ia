# The rehearsal instance - recipe and the risks it closes

**Scope**: method

Companion of [the disposable-proof skill](../SKILL.md), part B. A second instance of the
database, with the same names as production, and the services started against it with the
outside world cut off. It serves the cutover rehearsal and, when real data must not
change, the owner's walk ([`delivery-gates`](../../delivery-gates/SKILL.md), G4).

## Why a second instance and not a throwaway schema

When the code or the scripts fix schema names (qualified table names in many files, a
schema name per tenant), a copy under another name is a copy the code never touches. The
rehearsal needs **the same names** - therefore another server: the same engine binary and
version, another port, another data folder.

## The risks, and what closes each

| Risk (each was found while setting it up) | Closed by |
|---|---|
| the copy holds real records; one "cancel" or "send" on a copy reaches a real provider | an **outbound block** preloaded in every rehearsal process: name lookup and connections to the listed production hosts are refused; the process refuses to start with an empty list. The copy's integration settings are switched to the provider's test mode as well |
| the working tree's configuration file points to the production database, and the loader reads it | the rehearsal variables are **exported before** the start (the configuration loader does not override variables already set - verify that for yours), and a **probe** runs before every step |
| a token minted in the rehearsal would be valid in production (same signing key) | an **own key pair and key id** for the rehearsal; the services that verify tokens get only the rehearsal's public key |
| files, secrets and mail would be written or sent for real | storage and secret paths pointed at **empty folders** of the scratch area; mail at a **closed local port** |
| production passwords would enter the copy | the copy's database users are **recreated with new passwords** (the dump does not carry the server's user table) |
| a counter in the copy would collide with real history (document numbers, sequences) | counters on the copy moved **far from** the real range |
| a stopped process is the production one | processes stopped by **port and command line path**, never by a process id found by name |
| a link inside the scratch area points into a real repository | links removed with the command that removes **the link**, never a recursive delete through it |

## Recipe (neutral; adapt the commands to the engine and the shell)

1. **Scratch folder** `S` outside every repository. Initialise a new data folder in `S`
   with its own port and an admin password created for the rehearsal; bind it to the
   local machine only; copy production's server settings (modes, character set, lock
   timeouts); start it in the background.
2. **Users** on the copy with the grants production gives them (the definer of views and
   triggers included) and new passwords.
3. **Data**: a read-only, consistent dump of the schemas involved (routines, triggers and
   events included) from production, restored on the copy.
4. **Neutralize** on the copy: integration settings to the provider's test mode, counters
   moved away from the real range.
5. **Environment** per service: port, database = the copy, storage / secrets / mail
   isolated, the rehearsal's signing key and key id, allowed origins for the local
   client, the block list, and the preload that enforces it.
6. **Probe** before each step (below). Nothing runs with its execute flag unless the probe
   names the copy.
7. **Run the runbook** on the copy: migrations, dry runs, the abort's dry run, the act,
   restarts in the runbook's order, the build of every client artifact. Services start
   **without file watching** (a watcher restarts the service on its own and blurs the
   order of the steps).
8. **The walk**, when the window needs one: a local failure proxy in front of each service
   (see the delivery-gates walk), the client built against the proxies and served locally
   with caching off; the owner types the login.
9. **Read production back** (read-only): nothing changed.
10. **Clean up**: stop the processes (by port and command line), delete `S` with the data
    folder.

## The outbound block (sketch)

A small module loaded before the application (in Node, through the runtime's preload
option; other runtimes have an equivalent hook). It lives in the scratch area, never in
the repository.

```js
// rehearsal-block-hosts.js - preload: refuse production hosts in this process
const dns = require('dns'), net = require('net'), tls = require('tls')
const blocked = (process.env.REHEARSAL_BLOCK_HOSTS || '')
  .split(',').map(s => s.trim().toLowerCase()).filter(Boolean)
if (blocked.length === 0) throw new Error('REHEARSAL: empty block list - refusing to start')

const isBlocked = h => typeof h === 'string' &&
  blocked.some(b => { const x = h.toLowerCase().replace(/\.$/, ''); return x === b || x.endsWith('.' + b) })
const refusal = h => Object.assign(new Error(`REHEARSAL: ${h} BLOCKED`), { code: 'ECONNREFUSED' })

const lookup = dns.lookup
dns.lookup = function (host, ...rest) {
  if (!isBlocked(host)) return lookup.call(this, host, ...rest)
  const cb = rest.find(r => typeof r === 'function'); process.nextTick(() => cb && cb(refusal(host)))
}
const plookup = dns.promises.lookup
dns.promises.lookup = (host, ...rest) => isBlocked(host) ? Promise.reject(refusal(host)) : plookup(host, ...rest)

for (const [mod, names] of [[net, ['connect', 'createConnection']], [tls, ['connect']]])
  for (const n of names) {
    const orig = mod[n]
    mod[n] = function (...args) {
      const a = args[0], host = (a && typeof a === 'object') ? (a.host || a.servername) : args[1]
      if (isBlocked(host)) throw refusal(host)
      return orig.apply(this, args)
    }
  }
process.stderr.write(`[rehearsal] blocked: ${blocked.join(', ')}\n`)
```

Prove it once per rehearsal: from inside a rehearsal process, a request to a blocked host
must fail with the rehearsal's refusal.

## The probe

Run from the **same working folder and with the same environment** the next step will use,
loading the configuration exactly as the service loads it:

```
probe -> connects as the service would, then asks the SERVER:
         { workingFolder, configuredPort, serverPort, serverDataFolder, currentUser }
```

The server's own answer (its port and data folder), not the configured value, is what
counts: a configuration can say one port while the loader picked up another file.

## Rehearsal evidence (shape)

| Step | Result |
|---|---|
| migrations on the copy | applied: <list> |
| dry run of the act | exit 0; the only blocker is the expected one |
| dry run of the abort | answers without refusal: no triggers, no migration row, no tombstone |
| start of the new code | the start log shows the lines the runbook expects |
| resync + counts | origin = replica on both sides |
| the act, execute flag | committed; the copy's state is the expected one |
| production read back | unchanged |

This table goes into the runbook's "Rehearsal evidence" section
([template](../../../templates/CUTOVER_RUNBOOK.template.md)).
