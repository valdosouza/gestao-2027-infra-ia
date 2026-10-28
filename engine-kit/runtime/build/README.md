# Build tools - registered builds with a warnings audit

**Scope**: method

One runner that executes a build **registered as data**, with the machine's paths in **one
per-machine env file**, writes everything **outside the source trees**, and turns the
tool's output into a `summary.json`: every error, warning and hint with its code and
`file:line`, the **risky** codes flagged (the risky set is data too), and a verdict
**CLEAN / SUFFICIENT / BROKEN**. The [`build-analyst`](../../agents/build-analyst.md) agent
runs it and audits the risky items (technique T70). The runner knows no language and no
compiler: the command, its arguments, the diagnostic formats and the codes are all
configuration. Windows PowerShell 5.1 (tested there; PowerShell 7 not yet), ASCII-only, LF.

## Files

| File | What it is |
|---|---|
| [`build.ps1`](build.ps1) | The runner: resolves one registered build, checks the paths, runs the tool in its working folder, parses, writes the log and `summary.json`, prints the verdict |
| [`projects.example.json`](projects.example.json) | The registry format, filled with a fictional product (two maintained lines, three builds). The case copies it next to its knowledge base and versions it |
| [`build.env.example.json`](build.env.example.json) | The per-machine roots. Each machine copies it to `build.env.json` next to the case's projects file; **never versioned** (put it on the ignore list) |
| [`summary.schema.json`](summary.schema.json) | JSON Schema (draft-07) of what the runner writes - the contract the agent reads |
| [`tests/test-build.ps1`](tests/test-build.ps1) + [`tests/fakecc.ps1`](tests/fakecc.ps1) | Plain PowerShell tests (no Pester) in a scratch folder, against a fake compiler that prints the three example formats ([Tests](#tests)) |

## Run

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File <kit>\runtime\build\build.ps1 -Projects <case>\build\projects.json -List
powershell -NoProfile -ExecutionPolicy Bypass -File <kit>\runtime\build\build.ps1 -Projects <case>\build\projects.json -Project orders-service -Line 2.1
powershell -NoProfile -ExecutionPolicy Bypass -File <kit>\runtime\build\build.ps1 -Projects <case>\build\projects.json -Project orders-service -Overlay <client-overlay-folder> -DryRun
```

| Parameter | Meaning |
|---|---|
| `-Projects` | The case's registry (mandatory) |
| `-Project` / `-Line` | The build to run; `-Line` is needed only when the id is registered in more than one line |
| `-Overlay` | A folder put **first** on the search path, so its units win over the base units of the same name (a per-client overlay). Refused unless the build says `overlaySupported` |
| `-EnvFile` | The per-machine roots (default: `build.env.json` next to the projects file) |
| `-DryRun` | Resolves everything and prints the command; runs nothing, writes nothing |
| `-List` | Lists the registered builds (needs no env file) |

**Exit codes**: `0` compiled (CLEAN or SUFFICIENT), `1` BROKEN, `2` usage or configuration
error - nothing was built, and the message names exactly what is missing (the env file,
a required path, an undefined variable, an output folder inside a source tree). The
tool's own exit code is in the summary.

## The registry (`projects.json`)

| Key | Level | Meaning |
|---|---|---|
| `parsers` | top | Named regular expressions (.NET syntax), one per diagnostic format the tool prints. Named groups: `file`, `line`, `column`, `kind`, `code`, `message` - all optional. A parser may set `ignoreCase` and a constant `kind` |
| `kindMap` | top | Raw kind text -> `error`, `warning`, `hint` or `info`. Built in: error, fatal -> error; warning, warn -> warning; hint, note -> hint; info -> info. An unknown kind counts as a warning |
| `riskyCodes` | top and build | Code -> why it matters (one sentence). The build's own entries are added to the global set. Every error is risky as well |
| `silencerPatterns` | top and build | Regular expressions over the arguments and the response file: an argument that switches a diagnostic off is recorded and blocks CLEAN (technique T34, anti-patch) |
| `suspectPattern` | top and build | What an unparsed line looks like when it is probably a diagnostic (default: the words error, warning or fatal). Such lines are counted, never ignored |
| `lines.<line>.variables` | line | Values shared by the line's builds (its toolchain folder, its tree) |
| `lines.<line>.projects.<id>` | build | `workdir`, `command`, `args`, optional `requires`, `searchPath` (`dirs`, `separator`, `quote`), `responseFile` (lines), `parsers` (names, tried in order; default all), `riskyCodes`, `silencerPatterns`, `overlaySupported`, `outputEncoding` (code page or name), `variables`, `description` |

**Variables.** Any string may use `{name}`. Sources, lowest precedence first: the env
file's `roots`, the line's `variables`, the build's `variables`, then the built-ins `{out}`
(this build's output folder), `{line}`, `{project}`, `{stamp}`, `{workdir}`, `{overlay}`,
`{searchPath}` and `{responseFile}`. An undefined variable is a configuration error. An
entry of `args`, `requires`, `searchPath.dirs` or `responseFile` that starts with `?` is
optional: it is dropped when one of its variables is empty.

**What the runner does with them.** Missing `requires` stop the run (exit 2, every
missing path named). Search-path folders missing on this machine are **skipped and
listed** (`skippedDirs`), not fatal; the overlay goes first. The tool runs **inside
`workdir`**, as an IDE would, so same-folder includes resolve. The response file, the
log and the summary go to `<outRoot>\<line>\<project>\`.

## The env file (`build.env.json`)

```json
{ "roots": { "toolchainRoot": "C:\\Tools\\acme-cc", "codeRoot": "%USERPROFILE%\\src\\acme-orders" },
  "outRoot": "%LOCALAPPDATA%\\kit-build" }
```

`%VAR%` expands from the environment. **The output never lands in a source tree**: the
runner refuses (exit 2) an `outRoot` inside the build's `workdir`, inside any root of the
env file, or inside the kit. Build products (binaries, intermediate files) are sent there
too by the build's own arguments (`--out={out}\bin`).

## The summary and the verdict

`<project>-<stamp>.summary.json`, next to `<project>-<stamp>.log` (the tool's output,
stdout then stderr). Fields: [`summary.schema.json`](summary.schema.json). Each item carries
`kind`, `code`, `file`, `line`, `column`, `location` (`file:line`), `message`, `risky`,
`riskReason` and the `parser` that matched; `byCode` counts per code.

| Verdict | When | Exit |
|---|---|---|
| **BROKEN** | the tool exited non-zero, or an error was parsed. A non-zero exit with no parsed error says so: the parsers missed the failure | 1 |
| **SUFFICIENT** | compiled, with warnings, risky hints, a silencer argument, or unparsed lines that look like diagnostics - **latent defects to audit, not a pass** | 0 |
| **CLEAN** | compiled; no warning, no risky item, nothing silenced, nothing unparsed (a non-risky hint is allowed) | 0 |

## Rules

- **Never silence a warning to make a build clean** - no directive in the source, no
  switch in the registry. A silenced diagnostic is a finding (T34); the runner records the
  arguments that do it.
- **The registry is data, the machine is one file.** No machine path in the registry, no
  build definition in the env file. A new machine copies one file.
- **The parsers are checked by their gaps**: an unparsed diagnostic-looking line keeps the
  verdict off CLEAN until a parser covers it or `suspectPattern` excludes it on purpose.
- **Before and after.** To judge a change, build before and after it and compare the
  summaries: the risky items that appear are the change's own (the agent's step).

## Tests

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File <kit>\runtime\build\tests\test-build.ps1 [-Scratch <empty dir>] [-KeepScratch]
```

Everything runs inside one scratch folder: a fake code tree with two lines, the fake
compiler run through `powershell.exe`, a projects file and env files written by the test.
It covers each verdict (CLEAN, SUFFICIENT, BROKEN on an error and on an exit code alone),
both output streams, the three diagnostic formats, risky and non-risky codes, an
unparsed diagnostic and a silencer argument keeping the verdict off CLEAN, the overlay
first on the search path, a missing search folder skipped and listed, the response file,
every configuration refusal (exit 2: output inside a tree, no env file, unknown or
ambiguous build, overlay not supported, missing required path), `-DryRun` writing
nothing, `-List`, and every summary against the key sets and verdict values of
[`summary.schema.json`](summary.schema.json). Last run: 45 of 45 checks on Windows
PowerShell 5.1; the summaries also validated against the schema with a draft-07
validator. Not run: PowerShell 7, and this runner against a real compiler (the case's
script it was distilled from ran against the case's compiler on every build it reported).

## What stayed in the case it came from

The runner was distilled from one case's build script for a single compiler family. Left
there: the assembly of that compiler's search-path switches and library folders, its
per-version debug switches, the option to drop the binary next to the project file, a
markdown twin of the summary (the agent writes the human report), and the case's own
risky codes (here replaced by fictional ones).
