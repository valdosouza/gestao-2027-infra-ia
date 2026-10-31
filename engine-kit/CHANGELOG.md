# Changelog

**Scope**: method

Newest first. Every entry: what changed, why, and where the evidence came from
(described, never imported — see [docs/MATURITY.md](docs/MATURITY.md)).

## [Unreleased]

- **Hygiene: nothing in the kit points at a case (2026-10-28)**, the owner's rule restated
  ("the kit is generic: nothing related to either case"). An audit beyond the deny-lists
  found two traces and removed them:
  - the 0.7.0 consolidation manifest (`docs/history/`) named the author's machine paths
    and one case's folder layout: it now stays with the kit's author, outside the kit;
    `MIGRATION.md`, the README, the technique register (T61) and EK#32 no longer link it;
  - the `VAULT_ROOT` / `--vault` / `--vault-root` aliases of `KB_ROOT` / `--kb-root` /
    `--root` existed only for one case's environment: removed from the adapters, the memory
    index and the registry tools.
  - **Adopters: re-check**: a case that set `VAULT_ROOT` sets `KB_ROOT`; a script that
    passed `--vault` or `--vault-root` passes `--kb-root` or `--root`.

- **The kit's home moves (2026-10-28, EK#32, revising EK#1)**: the kit now lives in the
  `engine-kit/` folder of the method author's workspace repository, replacing the older
  copy there (every file of that copy has a destination in the consolidation manifest,
  kept by the kit's author, outside the kit: it names the source machines and cases). The separate repository of EK#1 stays
  as history with its `exit-test-*` tags. README, INSTALLATION and ARCHITECTURE say so;
  the plugin marketplace is added from the kit's folder.
  - **Adopters: re-check**: the `Kit` row of `AGENTS.md` - the kit's path or repository
    and the tag or commit it is pinned at.

- **Exit test 3a stage 5 and 3b stage 4 (2026-10-28)**, both on the pinned tag
  `exit-test-stage7`: short stages that recorded the owner's "they stay owed" (the owner's
  walk in 3a, the rehearsal of the prepared change in 3b), moved each case to the new kit
  version and re-checked the last fixes - 13 of 13 (3a) and 16 of 16 (3b) confirmed. Each
  test wrote its outcome: 3a a delivered wave waiting for the owner's walk (139 tests, 5
  expected failures), 3b an approved, prepared first change waiting for its rehearsal.
  19 findings, no blocker, fixed:
  - `decision-rounds`, `close-and-retain`: an owner message that only defers an item
    closes nothing and is quoted where the item lives; the round that carries a prepared
    change's go asks who applies and rehearses it.
  - `INSTALLATION.md`, "Moving to a newer kit version": an open, unanswered round is the
    next round (additions dated, named in the hand-off); a move over a move not yet
    ratified revises it; earlier moves recorded as decisions are ratified like Day-1
    choices; facts recorded under an answer table the kit has since changed are re-read;
    an approved artifact keeps its shape until its next revision.
  - `delivery-gates`: a FINDING probe asserts the whole recommended option against every
    option of its question, away from time boundaries; a probe-only delta is gated (G2
    mutates the code in a copy); a suite test pins FINDING probes where the framework
    cannot.
  - Templates: one home for the release list (the closing record); the English-words list
    names the draft markers and probe labels; `-> probe result (F<n> when recorded
    before)`.
  - Legacy and words: bundled hypothesis rows are split at their next turn; a word sweep
    covers inflections. Registry: a copied tool summary ("decisions 17") is no longer read
    as a decision citation.
  - Kit rule: a CHANGELOG entry that reshapes a case's own files lists them under **Case
    files to reshape**. Journal: 8 outbox lines pulled.
  - **Adopters: re-check**: the English-words list of `AGENTS.md` (draft markers, probe
    labels); the resume block's release line points at the closing record.
  - **Case files to reshape**: an open round after a kit move (its ratification added,
    dated); FINDING probes (the whole option, time read off the boundary, a suite test
    pinning them where the framework has no `raises=`) - and a probe-only delta passes the
    gates; the hypothesis register's bundled rows (listed, split at their next turn); each
    sweep row of the occupied words (the forms it counts); a prepared change's `APPLY.md`,
    evidence and closing draft (the person who applies it, a people-register row or `not
    named yet - R-<NS>n`).
  - Two descriptions rewritten to start with "Use when" (EK#18; 12 left); registry tests
    23 -> 24.

- **Exit test 3a stage 4 and 3b stage 3 (2026-10-28)**, both on the pinned tag
  `exit-test-stage6`: 3a went from the closing round's answer and its go to the first wave
  built in one pass (138 tests: 133 passed, 5 expected failures; the delivery gates passed
  after two deltas) and stopped at the owner's walk, a round raised by the gates and the
  release word; 3b prepared its first change as two patches and a rehearsal script (apply
  checked on a scratch copy, the code still untouched) and stopped where a person must run
  the rehearsal. 27 findings, and two stage-2 findings left open by the last pass, fixed:
  - `decision-rounds`: an answer is read by the ids it names and the case they are
    attached to (a round number that matches no open round reopens nothing); a go is a
    sentence of its own naming its artifact, not a line of its own; the result of a read a
    person made on request is a probe result; an environment the code constrains (a server
    version, a profile, the database it selects) is a claim about the system; a kit change
    between a question and its answer is recorded as given (a contradicted decision takes
    the contradicted-decision path; a recommendation that only lost its reason is told,
    with no new question); a round raised by the delivery gates after the go carries the
    plan's revision with its go (the EK#26 pattern).
  - `change-gate`: prose in an analysis is not a map; facts that arrive with the go (void,
    revise, or an "After the go" note with a WORKLOG row and a stop condition); a file is
    written at its first run; `Browser cases:` in the Test plan. `prepare-only`: read the
    build's treatment of each touched file before the patches, build and install as
    production does, `* -text` in `PATCH/`, no credential line in a patch's context, the
    walkthrough and the owner's walk in `APPLY.md`, the closing record drafted with the
    patches.
  - `close-and-retain`: drafts while a gate waits (`[DRAFT - pending the returned logs]`,
    the walk and the release word asked in one message, the word valid after the walk).
  - `test-gate`: a stubbed class or web application compares the whole result (or the
    status) first; `browser-verification`: what stands in when no server may run here;
    `delivery-gates`: a FINDING probe asserts the recommended option and fails on its
    assertion.
  - `conceptual-guardian`: a word decision applied to a written base is a sweep with
    declared exceptions; `pipeline-builder`: a setting with no registry row always has a
    receiver; hypothesis register: one claim per row, a partly settled row is split.
  - `INSTALLATION.md`: the ignore probe also checks a log under a ticket's `TESTS/`; a kit
    move made before the owner decides it is an assumption; the closed prompt stays the
    living front prompt in `prompts/` until the front's close (G2 and `kb-setup` agree with
    `front-protocol`).
  - Close script: one warning per evidence file for "not run here" (close tests 66 -> 67);
    run logs are kept as `.txt`.
  - Journal: 25 outbox lines of both exit tests pulled, each with its landing; pulling a
    line means writing it in the journal (a CHANGELOG entry is not a pull). Corrected
    landing: two lines of 3a stage 2 had been given `exit-test-stage4` and now say
    `exit-test-stage5`, the tag that carries their text.
  - **Adopters: re-check** (rules a case copies into its own `AGENTS.md`):
    - the go rule: a sentence of its own naming the artifact, which may share a message
      with answers and with other gos;
    - the outbox for the kit is written in the case's artifact language (missed in the
      previous list);
    - run logs are `.txt`, never `.log`;
    - the `Kit` row of the template names an assumption while the owner has not decided a
      kit move; the closed prompt stays in `prompts/` until the front's close;
    - the WORKLOG has an "After the go" section and `CLOSE.md` the draft markers.


- **Decisions EK#29 to EK#31 (2026-10-28)**, all the recommended option:
  - EK#29 (refines the layout rule): a code tree may sit in a folder inside the base when
    it is its own repository and the base's version control ignores it; the projects
    registry names it and the checks that walk the folder exclude it
    (`checks.scope.exclude`, `checks.retired.normative.exclude`, `-ExcludePattern`).
  - EK#30: one go per wave - a plan may carry test-first steps whose reds are shown with
    it and covered by its go.
  - EK#31: ratifies assumption A-EK9 - the settings mapper scans on proposed patterns while
    their confirmation rides in the closing round.
  - **Adopters: re-check**: the `Layout` row of `AGENTS.md` (the template now names the one
    exception, an ignored code repository inside the base); a case that asked two gos for a
    plan and its red may ask one.

- **Exit test 3a stage 3 and 3b stage 2 (2026-10-27)**, both on the pinned tag
  `exit-test-stage4`: each went from the owner's answers to a plan of its first change and
  stopped at the code gate (3a with its red proven: 26 tests, 26 assertion failures, 0
  errors; 3b with a change it can only prepare, since its code is read-only). 25 findings,
  fixed in the kit:
  - `decision-rounds`: saying the release word vs naming, defining or quoting it (a
    sentence that names the word, or a message cut there, releases nothing); the
    cross-check of a round also reads the recommendations' combined consequences and, for
    the closing round, a go-live list (recovery of access, data at rest and backups, open
    items carried over, who operates it); a fact the owner gives about the world is a fact,
    a claim about what the system does stays a hypothesis; the confirmations a plan's gate
    needs ride in the closing round.
  - `change-gate`: a change the agent cannot write or run is prepared as two patches in
    `TICKETS/<ID>/PATCH/` for a person to apply in a disposable instance; the wave id
    `<NS>-W<n>` for any front without a tracker; fact premises and accepted-risk
    hypotheses in the plan. `test-gate`: a stub returns a sentinel no expectation equals.
  - `settings-mapper`: scans on patterns marked `proposed` while their confirmation rides
    in the closing round; a changed pattern means a rescan (applied as an assumption until
    the owner ratifies it).
  - Tools: the close script and the validator read the Scope line after a YAML front matter
    (a long claims front matter no longer hides it); a working copy with no first commit is
    one note at every level (`vcs.has_commit`). close tests 59 -> 66, registry 21 -> 23.
  - `INSTALLATION.md`: no production behaviour before the go (the red may exist before
    it); "Moving to a newer kit version"; the frozen draft goes to `HISTORY/` at the
    front's close; the outbox is written in the case's language.
  - Journal: the landed-in column of 22 lines checked against the files and given the
    version that carries each lesson; four lessons that were claimed but missing were
    written into their skills.
  - **Adopters: re-check** (rules a case copies into its own `AGENTS.md`):
    - the gate sentence is now "no production behaviour before the go; the red's tests and
      a new unit's stub may exist before it; nothing leaves the working copy before the
      release word" (it was "no code before the release word");
    - a message that names or defines the release word releases nothing;
    - the conceptual guardian and the front-prompt skeleton are level 1 on both tracks
      (EK#25): a `borrowed:` entry for them in the adoption line can go;
    - a solo runtime area may be `.runtime/` inside the base, ignored by version control
      (EK#27).
  - Then decided as EK#29 to EK#31 (entry above): a code tree inside the knowledge folder
    when version control ignores it (Q-EK28), one go per wave with test-first steps inside
    the plan (Q-EK29), the settings-mapper scanning on proposed patterns (Q-EK30).

- **Decisions EK#25 to EK#28 (2026-10-27)**, all the recommended option:
  - EK#25 (revises EK#23): the whole `conceptual-guardian`, `FRONT_PROMPT` and
    `OCCUPIED_WORDS` sit in level 1 on both tracks; Round 0 of the legacy track uses the
    `FRONT_PROMPT` skeleton.
  - EK#26: the round that closes the prompt (on legacy, the one that settles the pilot's
    first change) carries the move to level 2 and the first wave's plan, written on the
    recommended answers, with the go asked on a line of its own; a blanket "follow the
    recommendations" is never a go. "No code before the go; nothing leaves the working copy
    before the release word" replaces "no code before the release word".
  - EK#27 (refines EK#5): a solo runtime area may be a folder inside the base that version
    control ignores (`.runtime/`); `rebuild-graphs.ps1` no longer warns for an ignored
    location and `validate-registry.ps1` skips `.runtime`.
  - EK#28: in test-first mode for a new unit the stub is part of the red artifact shown at
    the gate (`change-gate` step 4 states the exception).
  - A levels test that had become a skip now builds its own data (32 tests run).

- **Exit test 3a stage 2 and 3b stage 1 (2026-10-27)**, both on the pinned tag
  `exit-test-3a-stage2`: 3a went from the owner's Round 0 answers to the requirements
  (26 functional, 64 scenarios) and stopped at round 1; 3b (a small open-source Java web
  application, read only) went from Day 1 through sizing, pilot proposal and the
  analysis (25 hypotheses) to Round 0. 39 findings, fixed in the kit:
  - Greenfield change cycle: `change-gate` has a path for a wave with no tracker, no flow
    to map and no area yet; `test-gate` has the red of a new unit (assertion against a
    stub, expected values from the acceptance criteria); level tags in `retain-knowledge`,
    `close-and-retain`, `memory-engineering`, the `CLOSE` template and governance item 4
    of every agent; `decision-rounds` cross-checks a round's recommendations before it
    goes out; answered rounds move to a `-rounds.md` annex.
  - Install and levels: the level 1 -> 2 trigger no longer depends on a release word;
    Day-1 choices made before a decision owner exists are assumptions to ratify; the
    same-named check covers agents and has a fallback; the knowledge folder is the base
    root in both layouts; the legacy owner's request is copied and hashed; Round 0's file
    on the legacy track; the pilot is proposed in L2 and decided in Round 0;
    `sync-skills.ps1 -Track legacy|greenfield` (tracks in `levels.json`; levels tests
    19 -> 32).
  - Legacy: hypothesis status during the first reading; third-party behaviour as
    `inference` until a disposable run; the analysis document's place; a text-only sizing
    count; a "linked legacy document" census class; the ledger now lists an area's
    analysis and hypothesis files (a defect: files at an area root were dropped).
  - Tools: the close script recognises the owner's original while byte-identical to the
    frozen copy; the citation check skips only the next-free-ids item. close tests
    57 -> 59, registry tests 12 -> 21.
  - Leak found in review: a programming language tied to a case, and its file extensions,
    in the git skills' examples and the legacy sizing command - replaced by neutral ones.
  - Open for the owner: the conceptual guardian and the front-prompt skeleton at level 1
    on both tracks (Q-EK24), batching the first plan with the round that closes the
    prompt (Q-EK25), the solo runtime area inside the base folder (Q-EK26), a stub before
    the go in test-first mode (Q-EK27).

- **Decisions EK#22 to EK#24 (2026-10-27)**: the legacy exit test runs on a small
  open-source Java web application (EK#22); the greenfield entry's pieces -
  `conceptual-guardian` (its occupied-words step), `FRONT_PROMPT`, `OCCUPIED_WORDS` - move
  to level 1 as situational track-entry pieces (EK#23; level 1 now has 12 skills);
  each exit-test stage runs on a pinned local commit and tag (EK#24).

- **Exit test 3a, stage 1 (2026-10-22)**: a fresh greenfield project (solo, levels 1-2)
  used only the kit from Day 1 to Round 0 and stopped there for the owner: 10 of 13
  INSTALLATION steps, 16 questions, 30 findings in its log. Fixed in the kit:
  - Day 1 reordered (registers before the adoption line that cites them); the owner named
    on Day 1 only from a signed document, otherwise the first Round 0 question; no area on
    the greenfield track before Round 0 closes; the owner's draft copied byte-identical
    with its hash; the leak check moved to the kit author's release check; a pre-install
    check for same-named skills; an outbox (`JOURNAL-for-kit.md`) for adopters who cannot
    write the kit's journal; the artifact-language rule at level 1 and the list of what
    stays English for the tools; a `borrowed:` slot in the adoption line; level marks in
    the AGENTS template; solo keys in the projects template; `git-setup`,
    `git-commit-push` and `git-push` stage by path, never `git add .`.
  - One name, Round 0, for the first set of owner questions; requirements run after its
    answers; a workspace block in the front prompt's questions; facts requested from the
    owner (`R-n`); a "Reserved - never assumed" marker; next free ids written as `XY: 18`.
  - A "frozen source" census class (never marked; the close script and the validator skip
    it); the close script is level-aware (`level` 1-3); the citation check skips the
    "Next free ids" line. close tests 46 -> 57, registry tests 6 -> 12.
  - Open for the owner: whether the greenfield entry's three level-2 pieces move to level 1
    (Q-EK22), and pinning the version the exit tests run on (Q-EK23).

- **Decisions EK#13 to EK#21 (2026-10-22)**: the owner followed the recommendations of
  Q-EK12 to Q-EK20 ([DECISIONS.md](DECISIONS.md)). Applied in the kit:
  - EK#14: the commit door of `runtime/testing` wired into the plugin hooks: a
    `commitDoor` section in `.engine-kit/guards.json` turns it on, and the hook calls
    `suite.py precommit --warn-only` (new flag), so it never blocks even when the testing
    config says block; no Python on the machine = one "not run here" line. On the way,
    `launch.sh` reads only the command string (a `git status` described as "commit" no
    longer starts PowerShell) and finds `hook.ps1` from a backslash-only path; new
    `runtime/guards/tests/` (14 tests, git and svn).
  - EK#17: `runtime/registry/vcs.py --svn-client-ignored` (shared by every registry tool)
    and close.json `svnClientIgnored`, off by default: svn status with the client's
    global-ignores emptied, so the close checks see files a client hid; repository
    ignores still apply; git unchanged. New `runtime/registry/tests/` (6 tests); close
    tests 40 -> 46.
  - EK#18: `kit_lint.py` check 8 prints how many descriptions do not start with
    "Use when" (17 today).
  - EK#21: `sync-skills.ps1 -Level 1|2|3` (cumulative) and `-Borrow`; `runtime/levels.py`
    generates `runtime/levels.json` from docs/ADOPTION-LEVELS.md, and kit-lint check 9
    fails on drift; 19 tests in `runtime/tests-levels/`.
  - EK#13, EK#15, EK#16, EK#19, EK#20 confirm what the kit already said.

- **Wave 4 closed (2026-10-22)**: entry tracks - the register has no row left outside the
  kit (96 of 96 in kit; done 100%). What remains before 1.0 is phase 3, the exit tests
  ([EK#8](DECISIONS.md)).
  - Legacy track: `assess-legacy-repo` rewritten (T10 legacy documents stay hypotheses;
    T09 hypothesis register validated one per turn into a new analysis version; T11 agent
    reading + deterministic re-check, candidate; T94 rule form), `legacy-analyst` on the
    agent template, new `HYPOTHESES` template; new `runtime/data-probe/` (T94): a pure
    write/DDL guard that comments and literals fool in neither direction, the session
    proven read-only by a refused write, a row cap, no stored credential, pluggable driver;
    55 tests, no real engine run yet. New candidate skills `official-source-archive` (T13,
    with `runtime/sources/` - the archive manifest, 7 tests) and `migration-direction`
    (T14).
  - Greenfield track: new skill `frame-greenfield` (T17 draft organised as it is with
    warning marks and every item given a destination; T18 requirements pipeline, shared
    with `review-pack` in its pack profile; T19 validation vs message vs decision,
    candidate) + `REQUIREMENTS` template; `decision-rounds` gains the convergence rule.
  - `conceptual-guardian` (T20) rewritten: occupied words (+ template), presence vs act,
    third-party voice vs own effect, transaction-aware piece, a decision with a condition
    becomes a delivery check, a new pipeline entity as a trigger.
  - Ecosystem builders: new agents `settings-mapper` (T67), `pipeline-builder` (T68, T83
    shared-state analysis, T84 override parity - candidate), `version-diff` (T35) and
    `folder-importer` (T71) + `SETTINGS_REGISTRY`, `PIPELINE` and `VERSION_DIFF` templates;
    the pipeline builder is the single writer of pipeline documents and satisfies the
    pipeline gate; `projects_check.py` treats `SETTINGS/` as project-scoped.
  - Entry: `profiles/` (legacy, greenfield, solo, team), `docs/ADOPTION-LEVELS.md` (every
    piece placed in one of three levels; measured: the plugin format can limit skills
    per level but not agents or hooks - ~1,904 tokens for a level-1 skill set against
    ~3,782 for everything), `INSTALLATION.md` rewritten for two tracks, and the kit's own
    `AGENTS.md`.
  - Fixed on the way: `review-pack`'s requirements half now points to the shared pipeline
    (its old page is SUPERSEDED, kept as a pointer); the archive manifest tool moved out
    of the skill folder into `runtime/sources/` (scripts never live in a skill).
  - The owner's open points of this wave were decided on 2026-10-22 (EK#13 to EK#21).

- **Wave 3 closed (2026-10-21)**: close and retain - the 13 remaining wave-3 techniques
  are in the kit; the register shows no wave-3 row left (81 in kit, 3 partial, 12 planned
  of 96 - done 84%, started 88%).
  - New skill `close-and-retain` (T45, T78, T92) + `CLOSE` and `DELIVERABLE` templates: one
    closer per work item - closing record and tracker text (a sanctioned tracker write
    follows a read-test-show-write-verify protocol, never a comment as a substitute), the
    retention chain with card decisions, fix and tests packaged as two commits (fix
    first), the deliverable gate, then the close script.
  - New `runtime/close/` (T45, T78, T88): one call runs the mechanical checks of a closing,
    reusing the kit's tools (registries, Scope of touched documents, test evidence or the
    exempt line, retired locations in every spelling - written once, spellings derived,
    which fixes the UNC and forward-slash gap of the source case - decision citations,
    ledger, memory index, unversioned files); warn-only by default (EK#6); git and svn;
    40 tests.
  - `retain-knowledge` (T46) rewritten: destination rows for decisions, logs, cards,
    pipelines and settings; new claims compared with old; a card decision for every fact
    at 0.8 or more; the consolidation flag; root rules only on a workspace change; ends
    with the deliverable gate and the close script.
  - New skill `archive-card` (T49) + `CARD` template: one rule per file, strengthen instead
    of duplicating (two independent confirmations -> 0.95), supersession without deletion,
    time-minted ids `K-YYYYMMDD-HHMM`, VCS-neutral provenance.
  - `memory-engineering` (T48): the consolidation cycle in full (one area per cycle,
    evidence links to every log, the flag flipped only after the promotion is on disk,
    never a dump document); typed claims (`type: correction | missed | wrong | collision`,
    `agent:`) replace the body markers. `feedback-analyst` (T58, still design) reads the
    typed claims; its rules no longer repeat the governance block.
  - `runtime/memory_index.py`: card supersession (`supersedes:` or a SUPERSEDED line),
    live cards listed before superseded ones, supersession gaps reported, typed claims
    and `--claim-type`; a card's rule is the first H1 after the front matter (a YAML
    comment line no longer becomes the rule). Same counts as before on a regression base.
  - New `runtime/migration/` (T61, T89) + `docs/MIGRATION.md`: manifest-driven migration
    with a dry run into staging and `--apply` by batch, never deleting, renaming or
    fixing content; the frozen-source retirement gate (snapshot by content hash, drift
    with an old-to-new map, a human ruling per item). 36 tests; the per-item ruling and
    the content-hash comparison have not run in a case yet.
  - New `docs/AUTHORING.md` (T62) and kit-lint check 8 `sections`: skill heading, Scope
    and Maturity in the header block, agent front matter, size, and the governance block
    word for word from `templates/AGENT.template.md`; the lint prints the always-on cost
    of all descriptions.
  - New `JOURNAL.md` (T51): the product journal, one method insight per line,
    append-only, the one-session deadline, seeded with 37 distilled lines and two design
    entries (central memory service, multi-tool runner).
  - New skills `evaluate-harness` (T59, design - never run) and `weekly-report` (T96,
    candidate) + `runtime/weekly/` (one author's commits in a week, git or svn; 18 tests).
  - Integration: the governance block of every agent now ends the retention rule with the
    close script; `change-gate`, `test-gate`, `kb-setup`, `scope-census` and
    `INSTALLATION.md` point at the close; card paths and typed claims aligned in
    `kb-setup`, `AGENTS`, `SUBJECT_INDEX`, `KNOWLEDGE-BASE-STRUCTURE` and the runtime
    README; "the product journal" now links `JOURNAL.md`.
  - The owner's open points of this wave were decided on 2026-10-22 (EK#16 to EK#18).

- **Wave 2 closed (2026-10-21)**: the 10 remaining change-cycle techniques are in the kit;
  the register shows no wave-2 row left (68 in kit, 8 partial, 20 planned of 96 - done
  71%, started 79%).
  - New skill `browser-verification` (T41) + `runtime/browser/`: one engine-agnostic spec
    for the built-in browser, the user's Chrome or a headless Playwright runner; PASS /
    FAIL / BLOCKED / MANUAL with literal read-back; the login is a human step and the
    runner never handles credentials. Checked with dry runs, broken specs, argument
    guards and real headless runs through an API-compatible Playwright fork (Playwright
    itself, Firefox, WebKit and page-script console capture not yet run). Two runner
    defects fixed on the way (raw placeholders in read-back targets; manual-case
    instructions missing from the report).
  - New skill `result-review` (T42, T43, T80) + `REVIEW` template: the result, every
    revision of the item, file:line findings with a failure scenario, the open /
    acknowledged / resolved handshake, revision forensics, exit tests and dry runs.
  - `runtime/testing/` (T75; the tool behind T38 and T76): suite run with evidence
    checks and parts, the per-machine baseline and its gate, a warn-only commit door,
    the commit watcher (classify by path, grace, first claim wins by a VCS conflict, a
    headless agent's proposal checked and staged for a human). 141 tests, git and svn.
  - New agents `docs-writer` (T69, T93) and `build-analyst` (T70) + `runtime/build/`
    (registered builds, output outside the tree, verdict CLEAN / SUFFICIENT / BROKEN;
    45 tests against a fake compiler, every summary valid against its schema).
  - New skills `mold-factory` (T73) and `backport` (T79; git or svn, commits prepared).
  - The wave-2 skills now link each other; `change-gate` hands off build -> tests ->
    browser -> delivery gates -> review -> close; `test-gate` points at `runtime/testing/`.
  - Fixed: `test-gate/references/baseline-diff.md` said a blocking door refuses when
    there is no baseline, against its own section 3 and the source case's evidence; now
    "no baseline -> every failure counts as new".
  - Open for the owner: a new risky compiler warning sends the change back unless the
    owner accepts it as a numbered decision (stricter than the source case); who
    publishes a staged watcher proposal (kept human); wiring the commit door into the
    plugin hooks (proposed for wave 3); a browser-tester agent (not proposed yet).

- **Wave 2, part 1 (2026-10-21)**: the change cycle - 20 of its 30 techniques in the kit
  (register: 58 in kit, 8 partial, 30 planned - done 60%, started 69%).
  - `front-protocol` (T12, T26, T30, T31, T32) + `FRONT_PROMPT` and `RESUME_BLOCK` templates.
  - `change-gate` (T27, T28, T29 completed, T34, T36, T81, T82) + `PLAN`, `SPEC`, `WORKLOG`
    templates: one skill with three modes replaces three orchestrators.
  - `test-gate` (T37, T38, T44 as design, T76, T77) + `TEST_EVIDENCE` template.
  - `delivery-gates` (T39), `fences` (T40), `disposable-proof` (T33) + `CUTOVER_RUNBOOK` template.
  - Not yet in at that point: T41, T42, T43, T69, T70, T73, T75, T79, T80, T93 (their
    interrupted partial work was kept on branch `wip/wave2-remaining`; see "Wave 2 closed").
  - Open for the owner: the delivery-gates Socratic score anchors (0.85 / 0.75 / 0.70 -
    only 0.70 came from a case); whether a checkpoint commit needs the release word (kit
    decision instead of per case); the test-gate reading of EK#6 (doors warn-only, but an
    agent never moves on with a test it broke itself).

- **Wave 1 closed (2026-10-21)**: the 14 remaining wave-1 techniques are in the kit;
  the register shows no wave-1 row left (38 in kit, 9 partial, 49 planned of 96 -
  done 40%, started 49%).
  - New skill `kb-setup` (T01, T02, T03, T08, T25, T95): tool-neutral `AGENTS.md` + thin
    adapters, the domain-area model, mechanical placement, open-question onboarding,
    people are not roles, client specifics behind pointers. `docs/KNOWLEDGE-BASE-STRUCTURE.md`
    rewritten; `AGENTS.template.md` extended; new `AREA_KNOWLEDGE.template.md`;
    `scope-census` gains the placement rule after front matter, exclusion classes,
    resumed runs and a changed-files check.
  - `decision-rounds` (T22, T23, T24): `KEY#N` with project or front namespaces, the
    `D-XY2` = `XY#2` alias, reserved ranges and the renumbering table for parallel
    sessions; the assumption ledger and the owner's release word; optional business-rule
    files and the rule gate (new `RULE.template.md`). `registry/decisions_index.py`
    recognises the alias in citations.
  - New skill `review-pack` (T85) with brief and implementer-context templates.
  - New agent `env-setup` (T57) and `AGENT.template.md`; the standard governance block
    (T72) now ends every kit agent.
  - New `runtime/install-journal/` (T74): reversible install journal, 65 tests passing.
  - New `SENSITIVE_DATA_REPORT.template.md` (T53), linked from the git-security references.
  - `INSTALLATION.md` Day 1 steps 1-4 now follow `kb-setup` (the full two-track rewrite
    stays in wave 4).
- **EK#11 and EK#12 decided** (owner followed the recommendations): the MCP merge keeps
  only secrets local; `rebuild-graphs.ps1 -Commit -StampRegistry` also commits each
  registry it stamped (stamped only when it had no local modifications) - tested in git:
  the registry rides along when clean, stays out with a human edit, and unrelated staged
  or modified files never enter the commit. Also fixed: a group with only registries no
  longer runs `git add -u` without a pathspec.

- **Technique register and coverage check (2026-10-21)**: `docs/techniques.csv` lists
  every technique distilled from the two cases (T01-T96: module, rule, maturity, tier,
  status, wave, location); `runtime/coverage.py` renders `docs/TECHNIQUES.md` with the
  coverage by tier, module and wave; `kit_lint.py` gains check 7 (coverage): malformed
  rows, an in-kit or partial row pointing at a missing file, a skill or agent not
  registered, or a stale page are errors. Starting point: 96 techniques, 24 in kit,
  14 partial, 58 planned (done 25%, started 40%). The README states the exit rule: a
  wave closes when its rows are in, and 1.0 needs every core row.

- **Wave 1, tools (2026-10-21)**: the tools a case had built for its knowledge base,
  ported as five neutral groups (git and svn behind small adapters, every path a
  parameter, VCS writes only behind opt-in switches; each tested on synthetic data and,
  read-only, against the original's output on the real base):
  - `runtime/registry/` — decision registers + generated index + citation check (T22),
    project inventory validator with tenant-isolation check and dated enforcement
    (T87, T86), generated ledger (T04). Templates `DECISIONS`, `REGISTRY_PROJECTS`.
  - `runtime/guards/` + `hooks/hooks.json` — encoding and revert guards behind one hook,
    opt-in per project (`.engine-kit/guards.json`, template `guards.example.json`),
    warn-only by default with an opt-in commit "ask" (EK#6); the harness ask-list
    pattern (T54, T55, T29). The hooks need `sh` (Git Bash on Windows) and PowerShell.
  - `runtime/adapters/` — one generator of per-editor agent stubs with a neutral tool
    vocabulary and per-persona allow-lists (T01, T91); MCP activation from one
    secret-free model, never versioned locally (T56); MCP smoke test. Template
    `mcp.model.template.json`.
  - `runtime/graph/` — registry-driven code-graph rebuild with an incremental hardlink
    overlay tree, designated builder and solo/team profiles (EK#5), freshness and
    registry cross-check, optional Build Status stamp, pinned install (T07, T90).
    `REGISTRY_GRAPHS.template.md` gains Profile, Designated builder, Kind, Pairs, Flags.
  - `runtime/ladder/` + skill `abstraction-ladder` + agent `ecosystem-curator`
    (candidate) — mode A generator, mode B extension, abstraction-tree graph, catalog
    generated from the real files (T63-T66).
- `kit_lint.py` now scans `.js`, `.mjs`, `.cjs`, `.ts`, `.html` and `.css` too;
  `.gitattributes` fixes LF everywhere.
- Open for the owner: (1) the MCP merge now keeps only SECRETS from the local file and
  lets the model win for every other value (the source let any non-empty local value
  win); (2) in team mode a stamped graph registry stays uncommitted, because `-Commit`
  commits only the graph folders - widen the automated commit or keep a human commit.

- Plan: the agents that build the knowledge ecosystem (map curator, abstraction ladder
  and tree graph, generated catalog, settings mapper, pipeline builder, docs writer,
  build analyst, working-folder importer, governance block, mold factory) join waves 1,
  2 and 4 ([EK#10](DECISIONS.md)).
- Plan: a file-by-file audit of the larger case's AI layer and tools adds 23 portable
  techniques (test-evidence integrity, commit watcher with proposal agent, change
  packaging, revision forensics, tenant-isolation and retired-location guards,
  toolchain pinning, reversible install journal, read-only data probe, among others),
  a port list for `runtime/` and `hooks/` by wave, and concrete improvements to the
  current `decision-rounds`, `retain-knowledge`, `memory-engineering` and
  `scope-census` skills (first item of wave 1: `KEY#N` in `decision-rounds`, per EK#4).
- Method lessons from fixing a case's AI layer (2026-10-21), to fold into waves 1 and 3:
  a commit-time guard must resolve the working copy from the hook payload's `cwd`
  (explicit parameter → payload → current folder), never from a fixed default path; a
  retired-location guard must match every spelling (drive letter, UNC, forward slashes)
  and exempt the migrator that reads the old location by design; a generator must never
  carry the one-off edits of its first run (once applied, their anchors vanish and every
  later run aborts - the generated stubs then go stale silently); every generator gets a
  `--check` mode that writes nothing; an automated job and its registry need a
  cross-check (warn-only), and a documented "the job stamps the registry" that no code
  implements is drift - flag it in the registry until it is built.

## [0.7.0] - 2026-10-21 — consolidation

The kit existed as three divergent copies: the English plugin edition (this
repository's history, v0.3–v0.4), a Portuguese edition that kept evolving on its own
(v0.3–v0.6, outside version control) and a sibling runtime repository (v0.2–v0.3,
outside version control). Meanwhile both real cases kept improving the method for two
months without bringing anything back. Round 0 of the consolidation decided EK#1–EK#9
([DECISIONS.md](DECISIONS.md)).

- **One repository** (EK#1). History of the English edition imported with its commits;
  the Portuguese edition and the runtime folded in; every source file mapped in a
  consolidation manifest (kept by the kit's author, outside the kit: it names the source machines and cases since 2026-10-28).
- **Runtime inside the kit** (EK#3): `runtime/validate-registry.ps1`,
  `runtime/memory_index.py`, `runtime/build-memory-index.ps1`, `runtime/sync-skills.ps1`
  and `templates/` — ported from the old runtime and upgraded with the newer logic one
  case had evolved (cards and project dimension in the memory index, junction-based
  skill sync, stricter registry validation), neutralized and parameterized.
- **New `runtime/kit_lint.py`**: version agreement, leak check against case deny-lists
  kept outside the kit, links, Scope lines, skill size and maturity labels. The drift
  that produced three copies is now a lint error.
- **New skill `memory-engineering`** (from the Portuguese edition, translated): memory
  classes mapped to stores, episodic logs with claims, before/after-action loops,
  pipeline gate, consolidation cycle.
- **New `docs/ARCHITECTURE.md`** (from the Portuguese edition's unification proposal):
  the three layers, updated to the decided state.
- **Recovered `skills/git-security/references/SECRETS_PROTECTION_SETUP.md`**: linked
  since 0.3 but silently dropped by a broad `*secret*` ignore rule; the kit's own
  `.gitignore` now warns against such patterns.
- **Agent `feedback-analyst`** (from the old runtime) with maturity `design`.
- **Maturity labels** on every skill and agent (EK#7, [docs/MATURITY.md](docs/MATURITY.md));
  the kit's own [DECISIONS.md](DECISIONS.md); `.claude-plugin/marketplace.json` so the
  repository installs as a plugin marketplace; version history moved out of the README
  into this file.
- **Leaks removed**: case names, case descriptions and machine paths found in the three
  copies.
- **Known residue, scheduled for wave 1**: the git-security examples still follow one
  multi-repository layout (api / sync / legacy / docs / learning placeholders) and the
  installation guide covers the legacy track only.

## [0.4.0] - 2026-09-04 — English edition

First feedback loop from a real large legacy case (~2.4k source files, 3 sessions):
`assess-legacy-repo` gains "Lessons from legacy cases" (index validation, call density,
fact × intent, rules as data, inverse process, sibling diff table, proposed modules,
knowledge-base entry door; lesson 14 the same day: an owner-verified document is a
hypothesis); `decision-rounds` Round 0 gains step 0 (check existing decisions + fact ×
intent split). The manifest still said 0.3.0 — one of the drifts 0.7.0 closes.

## [0.3.0] - 2026-07-28 — English edition

English edition + Claude Code plugin format adopted from harness-kit practices:
`.claude-plugin/plugin.json`, `skills/<name>/SKILL.md` with auto-trigger front matter,
`agents/` personas, the git security package converted to skills with a `references/`
folder.

## Portuguese edition 0.3–0.6 (2026-07-27 – 2026-08-21) — folded into 0.7.0

Evolved outside version control after the split from 0.2:

- **0.3 (2026-07-27)** — unification proposal: comparison of the kit with the most mature
  case's workspace, distilled into the three-layer architecture (method / runtime / case).
  Now [docs/ARCHITECTURE.md](docs/ARCHITECTURE.md).
- **0.4 (2026-07-27)** — Layer 2 created as a sibling runtime repository (registry
  validator, skill sync, four templates, feedback-analyst agent). Now `runtime/` (EK#3).
- **0.5 (2026-08-21)** — memory engineering skill distilled from a real case (phase plan
  executed, pilot in a real bug flow, three consolidation cycles). Now
  `skills/memory-engineering/`.
- **0.6 (2026-08-21)** — runtime 0.2/0.3: the derived memory index (rebuildable from the
  episodic corpus, with query and a mechanical consolidation flag). Its first run showed a
  corpus twice the size of the manual inventory. Now `runtime/memory_index.py`.

## [0.2.0] - 2026-07-19

Installation guide created (owner feedback: "how to install" was not executable) —
Day 1 / Day 2+ step-by-step with commands, connection to existing tools, pilot unit, and
"what to never do".

## [0.1.0] - 2026-07-19

Initial kit extracted from case zero: 5 skills + knowledge-base skeleton + git security
package (11 neutralized documents).
