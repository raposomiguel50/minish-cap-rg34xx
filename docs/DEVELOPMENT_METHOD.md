# Development method and AI assistance

## Human-directed, AI-assisted

This project is part of **Miguel's Game Dev Lab** and follows a human-directed, AI-assisted workflow.

I define the project purpose, target hardware, scope, preservation criteria, acceptance criteria and final decisions. I also perform or evaluate the real-device observations used to accept changes.

ChatGPT assists with calculations, programming, debugging, automation, technical analysis, documentation and repetitive repository work.

AI-assisted output is reviewed against the project requirements and available evidence before adoption.

## Engineering principles

The workflow follows the same principles used throughout the project:

- **preservation** — retain the original creative work as the authority;
- **containment** — address each problem within the smallest practical boundary;
- **focus** — keep accepted scope separate from optional technical research;
- **restoration** — correct justified technical defects without adding or repainting creative content;
- **minimalism** — prefer smaller, justified interventions where they are sufficient;
- **curation** — define and validate a coherent reference experience rather than require the player to assemble one from many micro-settings.

The finished game is the primary evidence for what is being preserved. When the distinction between a technical defect and a creative decision is uncertain, preservation is the default.

See [`PHILOSOPHY.md`](PHILOSOPHY.md).

## Restoration decisions

Technical restoration and historical reproduction are treated as different questions.

A known bug, crash, save problem, avoidable slowdown, stutter or similar implementation defect may be corrected when the correction preserves content, mechanics, visual identity, sound, structure and deliberate cadence.

A familiar defect is not automatically treated as part of the work merely because players have become accustomed to it. Conversely, a limitation that has become part of the deliberate visual, audio or gameplay language is not automatically treated as something to remove.

When restoration changes observable behaviour, the difference, rationale and supporting evidence are documented. Historical behaviour may be retained for A/B testing, investigation or reference without becoming the default user-facing mode.

## Curated reference configuration

The project validates one preservation reference rather than treating every upstream option combination as equally representative.

The reference direction includes:

- original 240x160 presentation at exact 3x integer scale to 720x480;
- no smoothing, shaders or instructional overlays as part of the default game image;
- Project Picori menu functions accessible through shortcuts while their instructional overlays remain disabled by default;
- original GBA controls reserved for gameplay;
- port functions assigned to device-specific combinations that do not replace the original controls.

Inherited Project Picori options may remain accessible where useful, but changing them can move the configuration outside the validated preservation reference.

## Evidence-based validation

Different claims require different evidence. Depending on the task, the project uses:

- exact upstream revisions;
- file and binary hashes;
- build and link evidence;
- architecture checks;
- timing traces;
- runtime measurements;
- target-device observations;
- visual/audio QA;
- publication and deployment verification.

A successful command is treated as process evidence, not as proof of every property of the resulting artifact.

## Proportional claims

Measurements are reported within the limits of what they demonstrate.

Examples:

- CPU-frequency reduction is not converted directly into a battery-life, power or temperature percentage;
- panel refresh rate is kept separate from game-logic cadence;
- heuristic audio counters are not treated as direct perceptual measurements;
- a binary SHA-256 identifies an artifact but does not prove reproducibility;
- validation on RG34XX-H + muOS is not presented as universal H700 compatibility.

## Efficiency after fidelity

The optimisation order is deliberate:

1. preserve the work faithfully;
2. maintain stable execution;
3. remove justified technical obstacles;
4. reduce unnecessary resource use once the first three requirements are satisfied.

The retained V1 configuration uses CPU ceiling 936 MHz and GPU 420 MHz rather than simply maximising clocks. The reduced clocks were selected with the objective of avoiding unnecessary power and thermal demand while keeping the accepted experience intact.

That objective is not presented as a measured percentage unless direct power or thermal evidence supports one.

## Controlled experiments

Where practical, experiments change one relevant variable at a time and keep the surrounding conditions stable.

Timing work separates simulation cadence, presentation calls and physical refresh. Audio work combines timing evidence with listening. Runtime-policy comparisons restore CPU/GPU state between variants.

This improves interpretability and reduces attribution errors.

## Representative benchmark context

Benchmark conditions are reviewed before their results are accepted.

Early AutoLab measurements obtained through direct SSH were rejected because the surrounding frontend/background state did not represent a normal Ports launch. Later comparisons used a normal Ports-session context, deterministic replay and state restoration.

## Automation

Automation is used for deterministic and repetitive work such as:

- configuration setup;
- build commands;
- hashing;
- evidence collection;
- repeated variant execution;
- state restoration;
- repository maintenance.

Perceptual and design decisions remain separate from automated checks. Final visual/audio acceptance is performed on the target context.

## Real hardware

Host builds are useful for development and diagnostics, but they do not replace target validation.

The RG34XX-H/H700 environment remains the reference for timing, audio, controls, CFW lifecycle and clean return-to-frontend behaviour.

## Negative results

Rejected experiments are retained when they clarify a technical boundary or prevent unnecessary repetition.

Examples include:

- an experimental GPU renderer that was not promoted;
- a fullscreen-clear experiment that was not adopted;
- an early benchmark context that was invalidated;
- high-refresh hypotheses revised after instrumentation.

These are technical investigations, not an alternative creative direction for the game.

See [`KNOWLEDGE_BASE.md`](KNOWLEDGE_BASE.md).

## Project continuity

Durable project state is kept outside the conversation through source control, hashes, handovers, evidence files and explicit task status where appropriate.

Handovers distinguish:

- confirmed facts from open hypotheses;
- stable decisions from experiments;
- current baselines from historical work;
- completed gates from pending work;
- public material from private or non-redistributable material.

This supports continuity across development sessions and reduces reliance on conversational context.

## Publication boundary

Public release work is treated as a separate engineering gate.

The repository excludes proprietary game data, save/runtime state, private builds, device backups and third-party components without a clear redistribution path.

Technical documentation is reviewed separately from binary/content redistribution so that safe engineering knowledge can remain public even when a component cannot be distributed.

## Publication verification

Local QA, repository publication, deployment and live verification are separate states.

A public change is considered complete only after the relevant production artifact has been published and verified in its intended environment.

## Workflow size

Tooling should remain proportionate to the task.

Automation is useful when it reduces repetition or risk. For small, well-defined operations, direct and auditable steps are preferred over unnecessary infrastructure.

## Responsibility by area

| Area | Primary responsibility |
| --- | --- |
| Project purpose and preservation criteria | I define and approve them |
| Scope and priorities | I define them |
| Target hardware | I select it |
| Presentation, restoration and curation decisions | I make the final decisions |
| Acceptance/rejection of experiments | I decide |
| Real-device observations and final QA | I perform or evaluate them |
| Calculations and repetitive analysis | ChatGPT assists |
| Code drafting/modification | ChatGPT assists under my direction |
| Build/repository automation | ChatGPT assists under my direction |
| Evidence comparison | ChatGPT assists; conclusions remain evidence-bound |
| Documentation drafting/structuring | ChatGPT assists; final meaning and scope remain under my direction |

## Attribution

> **Human-directed, AI-assisted.** I retain responsibility for the project purpose, preservation criteria, design direction, decisions, critical evaluation and final approval. ChatGPT provides substantial assistance with calculations, programming, automation, analysis, documentation and repetitive technical work.

## Related documents

- [`PHILOSOPHY.md`](PHILOSOPHY.md)
- [`KNOWLEDGE_BASE.md`](KNOWLEDGE_BASE.md)
- [`PATCH_SERIES.md`](PATCH_SERIES.md)
- [`REPRODUCTION.md`](REPRODUCTION.md)
- [`VALIDATION.md`](VALIDATION.md)
- [Miguel's Game Dev Lab development method](https://raposomiguel50.github.io/method/)
