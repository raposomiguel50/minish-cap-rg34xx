# Development method, attribution and AI assistance

## Human-directed, AI-assisted

This project is part of **Miguel's Game Dev Lab** and is developed using a human-directed, AI-assisted workflow.

I define the project purpose, preservation philosophy, target hardware, scope, constraints, priorities, acceptance criteria and final decisions. I perform or judge the real-device observations that determine whether a result is actually acceptable.

ChatGPT provides substantial assistance with calculations, code drafting and modification, debugging support, PowerShell/shell/build automation, technical comparisons, evidence analysis, documentation and repetitive repository work.

The distinction matters because the project is not simply the sum of generated code. Its direction depends on choices about **what not to change**, which experiments to reject, which measurements to trust, when a result is sufficient and which claims the evidence does or does not support.

## The project philosophy shapes the engineering method

The Minish Cap RG34XX work is guided by five connected principles:

- **preservation** — keep the original game identity authoritative;
- **containment** — solve the demonstrated problem inside the smallest practical boundary;
- **focus** — do not let every possible enhancement become required scope;
- **restoration** — adapt behaviour to the target without replacing the original experience;
- **minimalism** — prefer smaller justified interventions over larger fashionable redesigns.

Minimalism applies to intervention, not to explanation. The public record should be detailed enough that another developer can understand and reuse the reasoning.

See [`PHILOSOPHY.md`](PHILOSOPHY.md).

## Why the workflow is structured this way

Long-running AI-assisted development has predictable failure modes:

- context can be lost between sessions;
- an assistant can infer a goal that was never approved;
- a technically plausible solution can conflict with the preservation intent;
- repeated automation can become more complex than the task;
- a successful command can be mistaken for a successful artifact;
- a local candidate can be mistaken for a production deployment;
- previously rejected experiments can be proposed again after context loss;
- physical-device behaviour cannot be judged purely from logs.

The workflow is deliberately designed around those risks rather than assuming they will not occur.

## 1. Explicit human checkpoints

Important design and quality decisions are explicit.

A technically possible change does not become part of the stable line automatically. I can reject it because it changes the visual identity, creates unnecessary scope, weakens evidence quality or solves a problem that the project does not actually have.

Examples from this project include:

- rejecting the implication that a ~119/120 Hz panel means the game should run its logic at 120 FPS;
- rejecting an experimental GPU renderer after failure rather than repeatedly reinserting it;
- not promoting a fullscreen-clear experiment merely because it existed;
- retaining original-style presentation instead of turning the port into an unsolicited remaster.

## 2. Evidence before confidence

A process exit code is not enough.

Where possible, the project uses distinct evidence for distinct claims:

- upstream revisions;
- file and binary hashes;
- build/link evidence;
- architecture checks;
- timing traces;
- runtime measurements;
- target-device observations;
- human audio/visual QA;
- publication/deployment verification.

This is particularly important when an AI assistant sounds confident about a result that has not yet been observed on the target.

## 3. Keep claims proportional to evidence

The project avoids converting one measured variable into a stronger marketing claim.

Examples:

- reducing CPU ceiling by ~33.9% is not evidence of ~33.9% battery savings;
- a display running around ~119.455 Hz does not mean game logic runs at 119/120 FPS;
- a heuristic callback/underrun counter is not a literal audible-defect count;
- a binary SHA-256 identifies an artifact but does not prove bit-for-bit reproducibility;
- validation on RG34XX-H + muOS is not a claim of compatibility with every H700 device and CFW.

Negative and mixed results remain in the record because they constrain future claims.

## 4. One experiment should answer one question

Contain variables whenever practical.

If investigating presentation, separate simulation cadence from presentation calls and panel refresh. If investigating audio cost, change the relevant audio parameter while keeping the rest of the context stable. If investigating runtime policy, restore CPU/GPU state between variants.

This makes a result easier to interpret and reduces the temptation to attribute improvement to the wrong change.

## 5. Benchmark the real usage context

The project explicitly rejected early AutoLab measurements taken through a context that did not represent normal use.

Direct-SSH measurements were treated as contaminated by frontend/background state. Later variants were run through a normal Ports-session context with deterministic replay and state restoration.

The lesson is general: **prove the benchmark context before optimising the benchmark number**.

## 6. Automate repetition, not judgment

Automation is useful when it removes deterministic grind:

- repeated configuration setup;
- build commands;
- hashing;
- evidence collection;
- variant execution;
- state restoration;
- repository maintenance.

Automation should not replace the decisions that require intent or perception.

Final visual/audio acceptance remains human. The purpose of automation is to free time for judgment, not to simulate judgment.

## 7. Real hardware remains an independent authority

The RG34XX-H/H700 target is not treated as an abstract Linux/ARM64 label.

A host build can answer build questions. It cannot prove target timing, audio quality, control feel, CFW lifecycle or clean return-to-frontend behaviour.

Physical-device validation remains a distinct gate.

## 8. Preserve negative results

Failed approaches and assistant mistakes are not automatically erased.

If they reveal a reusable rule, they belong in the engineering history.

Examples include:

- failed experimental rendering work;
- invalid benchmark context;
- high-refresh hypotheses contradicted by instrumentation;
- publication automation that became more complicated than the underlying task;
- a local music fix that had passed QA but had not yet been published to production;
- asking for files to be reacquired before checking whether they already existed.

See [`KNOWLEDGE_BASE.md`](KNOWLEDGE_BASE.md).

## 9. The project state must survive the conversation

Chat history is not treated as the sole project database.

The working method uses source control, versioned handovers, hashes, local durable state, evidence bundles and explicit START/PASS/FAIL records where appropriate.

A useful handover distinguishes:

- confirmed facts from hypotheses;
- approved decisions from experiments;
- current baseline from historical branches;
- completed gates from pending gates;
- private/proprietary material from public material;
- exact next step from optional future research.

This exists partly because an AI assistant can otherwise reconstruct the project incorrectly after context loss.

## 10. Publication is part of engineering

Publication has its own correctness boundary.

A safe public project should exclude:

- ROMs;
- extracted proprietary Nintendo assets;
- saves/private runtime state;
- private builds and device backups;
- third-party components without a clear redistribution path.

But sanitisation must not erase safe technical knowledge.

The initial Minish Cap publication was too narrow editorially: it correctly withheld restricted/private material but also under-published decisions, failures and lessons. That was corrected by expanding the public philosophy, knowledge base, patch history, validation and reconstruction documentation.

**Public safety and public teaching are compatible.**

## 11. Separate local QA, publication and production verification

These are different gates:

1. candidate exists;
2. candidate passes local tests;
3. change is committed/published;
4. deployment completes;
5. live behaviour is verified.

The music-player repair exposed this distinction directly: local QA succeeded before the live site had actually changed.

This lesson now applies to every public-site or release change.

## 12. Prefer the smallest workflow that preserves safety

Tooling is subordinate to the task.

A large automation framework is not automatically safer than a direct operation. During publication work, oversized PowerShell runners introduced parser errors, automatic-variable collisions and unnecessary repeated investigation.

The corrected principle is:

> use the smallest operation that preserves the required evidence, recovery path and safety boundary.

Automation earns its place when it reduces repeated work or risk; otherwise it becomes another source of failure.

## Responsibility by area

| Area | Primary responsibility |
| --- | --- |
| Project purpose and preservation philosophy | I define and approve it |
| Scope and priorities | I define them |
| Target hardware | I select it |
| Visual/interaction preservation decisions | I make the final decision |
| Acceptance/rejection of experiments | I decide |
| Real-device observations and final QA | I perform/judge them |
| Calculations and repetitive analysis | ChatGPT assists |
| Code drafting/modification | ChatGPT assists under my direction |
| Build/repository automation | ChatGPT assists under my direction |
| Evidence comparison | ChatGPT assists; claims remain evidence-bound |
| Documentation drafting/structuring | ChatGPT assists; I define the intended meaning and final scope |

## Attribution principle

The concise attribution used throughout the project is:

> **Human-directed, AI-assisted.** I retain responsibility for the project purpose, preservation philosophy, design direction, decisions, critical evaluation and final approval. ChatGPT provides substantial assistance with calculations, programming, automation, analysis, documentation and repetitive technical work.

## Related documents

- [`PHILOSOPHY.md`](PHILOSOPHY.md)
- [`KNOWLEDGE_BASE.md`](KNOWLEDGE_BASE.md)
- [`PATCH_SERIES.md`](PATCH_SERIES.md)
- [`REPRODUCTION.md`](REPRODUCTION.md)
- [`VALIDATION.md`](VALIDATION.md)
- [Miguel's Game Dev Lab development method](https://raposomiguel50.github.io/method/)
