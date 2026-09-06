# Engineering knowledge base

This knowledge base preserves reusable lessons from the RG34XX/H700 integration work.

The preferred structure is:

**context -> symptom/problem -> impact -> root cause or finding -> decision -> validation -> reusable lesson**

Historical research remains useful even when it did not become part of the retained V1.

## KB-MC-001 - Choose the upstream whose dependency boundary can actually be audited

**Context:** Selecting a practical public foundation for an H700 native port.

**Problem:** A theoretically attractive upstream is not useful if important dependencies are inaccessible, unpublished or impossible to reproduce in the intended environment.

**Decision:** Project Picori became the principal integration foundation while zeldaret remained an important reference. Upstream selection was treated as an engineering and provenance decision, not merely a code-quality comparison.

**Reusable lesson:** Evaluate an upstream by the whole build and dependency boundary you need to maintain, not only by the elegance of its core source tree.

## KB-MC-002 - Host success is not target success

**Context:** Development work performed with stronger host hardware while targeting Allwinner H700 / Cortex-A53.

**Problem:** A build or runtime result on a Raspberry Pi 5 or another host does not prove correctness, ABI compatibility or acceptable behaviour on the H700 target.

**Decision:** Host work is treated as a development aid; target validation remains a separate gate.

**Reusable lesson:** Keep host build evidence and target-runtime evidence separate. Cross-compilation success is not hardware validation.

## KB-MC-003 - Do not replace CFW libraries casually

**Context:** Native integration with muOS and its runtime environment.

**Risk:** Bundling or replacing system libraries can solve one local problem while creating ABI, lifecycle or update conflicts with the custom firmware.

**Decision:** Prefer the existing CFW boundary where practical and make library changes only when the need is demonstrated.

**Reusable lesson:** On appliance-like Linux targets, compatibility with the platform environment is part of the port architecture.

## KB-MC-004 - The port should disappear from the player's perception

**Status:** Stable product principle.

**Context:** RG34XX-H integration and handheld presentation.

**Decision:** Preserve the game's art, music, sound effects, UI and GBA control identity. Port diagnostics should not invade the game image. Device-specific combinations are reserved for port functions rather than replacing original controls.

The reference presentation is the original 240x160 image scaled to the RG34XX-H 720x480 display using integer 3x scaling.

**Reusable lesson:** A technically sophisticated port can still be visually conservative. Infrastructure should be visible to the developer and largely invisible to the player.

## KB-MC-005 - High-refresh display rate and game cadence are different clocks

**Context:** Investigating presentation on the RG34XX-H high-refresh display.

**Initial hypothesis:** Approximately two presentations per logical game tick might improve display behaviour.

**Finding:** Instrumentation did not demonstrate that this was the useful stable model.

**Decision:** Retain the game logic around ~59.7275 Hz while using the panel around ~119.455 Hz and one explicit presentation per logical tick.

In the recorded comparison, tick-lateness p95 improved from approximately **5.791 ms** to **0.028 ms** under the tested configuration.

**Boundary:** This is not evidence that the game logic runs at 120 FPS.

**Reusable lesson:** Separate simulation cadence, presentation calls and physical-panel refresh before interpreting a "high refresh" result.

## KB-MC-006 - Reject the original plan when measurement contradicts it

**Context:** High-refresh investigation.

**Problem:** The planned approach was plausible but instrumentation did not support promoting it.

**Decision:** Adopt the measured single-present policy instead of defending the original two-present idea.

**Reusable lesson:** An experiment is useful when it can disprove the plan. Measurement should have authority over attachment to the original hypothesis.

## KB-MC-007 - Audio optimisation needs both timing evidence and human listening

**Context:** Audio cost on Cortex-A53/H700.

**Finding:** The investigated path included LINEAR processing and a 1920-frame buffer. A later 1600-frame test changed the nominal interval from roughly 40 ms to 33.333 ms while retaining an observed callback-gap warning/outlier.

**Validation:** Human audio QA was reported as acceptable for the adopted configuration.

**Boundary:** A counter labelled as an underrun heuristic is not a literal count of audible clicks or drop-outs.

**Reusable lesson:** Real-time audio should combine instrumentation with listening. Do not turn an implementation counter into a stronger perceptual claim than the evidence supports.

## KB-MC-008 - Benchmark context must represent real launch context

**Context:** AutoLab / automated configuration comparison.

**Problem:** Early direct-SSH measurements were contaminated by frontend behaviour, background music, screensaver state or other conditions that did not represent a normal Ports launch.

**Decision:** Invalidate that measurement context and run variants through a normal Ports-session context, with deterministic replay and CPU/GPU restoration between variants.

**Reusable lesson:** Before optimising a number, prove that the benchmark environment represents the user environment.

## KB-MC-009 - Automate repeated experiments, not final judgment

**Context:** AutoLab campaign across multiple runtime/configuration variants.

**Decision:** Automate deterministic setup, replay, measurement and restoration so several variants can be compared without repeating all gameplay manually.

**Boundary:** Final visual/audio acceptance remains a human decision.

**Reusable lesson:** Automation should remove repetitive work while leaving perceptual and design judgment with the operator.

## KB-MC-010 - Lower clocks are not the same thing as proportional energy savings

**Context:** P13/P13.1 optimisation work.

**Retained configuration evidence:** CPU ceiling 936 MHz, GPU 420 MHz, audio 1600, `TMC_RENDER_THREADS=3`.

The CPU ceiling was reduced from 1416 MHz to 936 MHz, roughly 33.9%.

**Boundary:** That percentage is not evidence of a 33.9% battery-life or energy-consumption improvement.

Recorded comparisons also included less flattering results such as higher maximum temperature in one comparison and slightly higher RSS.

**Reusable lesson:** Report the measured variable. Do not convert frequency reduction into an unsupported battery or efficiency claim.

## KB-MC-011 - Mixed results belong in the record

**Context:** Optimisation and candidate selection.

**Problem:** It is easy to retain only favourable values from a comparison.

**Decision:** Keep denominator, context, negative values and limitations alongside improvements.

**Reusable lesson:** A trustworthy engineering record explains what became worse as well as what became better.

## KB-MC-012 - A failed experimental backend is a result, not an invitation to retry blindly

**Context:** Experimental GPU-renderer work during P13.1.

**Finding:** The investigated GPU backend failed and was not promoted. A fullscreen-clear experiment was also not adopted into the retained V1 line.

**Decision:** Do not automatically repeat or reintroduce those experiments without a new reason and new evidence.

**Reusable lesson:** Preserve rejected branches so future work does not rediscover the same failure through context loss.

## KB-MC-013 - Clean exit is part of port quality

**Context:** Handheld/CFW lifecycle integration.

**Problem:** A game that runs correctly but exits poorly can leave the frontend, process state or platform lifecycle in a bad condition.

**Work preserved:** The public patch history includes clean-quit unwind, post-shutdown exit and file-select UI/exit diagnostic work.

**Reusable lesson:** Startup, gameplay and shutdown are all platform-integration responsibilities.

## KB-MC-014 - Build evidence is more than a successful command

**Context:** Cross-build and retained private V1.

**Decision:** Use hashes, expected architecture, source pins, logs and target behaviour as distinct evidence layers.

The retained private V1 is identified by SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

**Boundary:** The hash identifies that artifact; it does not prove that the public repository can reproduce it bit-for-bit.

**Reusable lesson:** Prove the artifact property you actually care about instead of treating process exit code as universal evidence.

## KB-MC-015 - Historical auditability, functional reconstruction and reproducible builds are different claims

**Context:** P13.1 source-authority material and publication review.

Four source snapshots were retained and hash-verified during the review:

- `port/port_ppu.cpp`
- `port/port_gpu_renderer.cpp`
- `port/port_main.c`
- `xmake.lua`

**Boundary:** These snapshots do not automatically prove that the entire final V1 build environment or all source inputs were preserved.

Keep three claims separate:

1. **Historical auditability** - evidence and decisions can be traced.
2. **Functional reconstruction** - a new build can be produced and behaviour validated.
3. **Bit-for-bit reproducibility** - the specified environment recreates an identical artifact.

**Reusable lesson:** Never use "reproducible" as a synonym for "we have some source and a binary hash".

## KB-MC-016 - Licensing is part of the technical boundary

**Context:** Public binary redistribution.

**Finding:** The validated private V1 incorporates VirtuaAPU. At the audited revision, that component did not provide an explicit published licence file.

**Decision:** Publish source/patch/launcher work that is cleared for redistribution, but do not redistribute VirtuaAPU or the V1 executable containing it until the licensing path is resolved.

**Reusable lesson:** A technically working binary is not automatically a redistributable binary.

## KB-MC-017 - Public safety must not become knowledge erasure

**Context:** First public publication of this project.

**Failure:** The initial publication correctly excluded ROMs, saves, private builds and unlicensed components, but the same caution was applied too broadly to decisions, failures, methodology and reusable engineering knowledge.

**Correction:** Sanitise what is sensitive or non-redistributable; publish the reasoning, measurements, negative results and lessons that are safe to share.

**Reusable lesson:** **Minimal public risk does not require minimal public knowledge.**

## KB-MC-018 - Local validation and production publication are separate gates

**Context:** Repairing the Miguel's Game Dev Lab music player during publication work.

**Failure:** A local candidate passed testing, but the live site still had the old code because the candidate had not yet been published.

**Decision:** Treat candidate QA, remote publication, deployment and live verification as separate states.

**Reusable lesson:** Never say a live defect is fixed merely because a local candidate works.

## KB-MC-019 - Do not create work the evidence does not require

**Context:** Publication/recovery automation.

**Observed failures:** Overly large PowerShell runners introduced parser mistakes, automatic-variable collisions, export problems and repeated investigation that was not necessary to solve the underlying task.

**Correction:** Prefer the smallest direct operation that preserves the required evidence and safety. Add automation only when it reduces risk or repetition rather than increasing it.

**Reusable lesson:** Tooling is subordinate to the task. Minimalism applies to the workflow too.

## KB-MC-020 - Check for existing artifacts before asking the operator to create them again

**Context:** Music-source recovery.

**Failure:** A workflow requested another download even though both official MP3 files were already present in the user's Downloads directory.

**Correction:** Inventory the known location first, validate existing artifacts, and request reacquisition only when the required artifact is actually missing or invalid.

**Reusable lesson:** Do not turn context loss into unnecessary work for the operator.

## Template for future entries

When adding a new lesson, prefer:

- **Status**
- **Context**
- **Problem/symptom**
- **Impact**
- **Root cause/finding**
- **Decision/resolution**
- **Validation**
- **Evidence limits**
- **Reusable lesson**

A failed experiment is worth keeping when it prevents a future maintainer from repeating the same plausible mistake.
