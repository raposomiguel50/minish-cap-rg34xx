# Engineering knowledge base

This knowledge base records findings from the RG34XX/H700 integration that may be useful beyond this project.

Entries follow a consistent structure: **context -> finding/problem -> decision -> evidence boundary -> reusable lesson**.

Historical experiments remain documented when they clarify a technical boundary or support future work.

## KB-MC-001 - Upstream selection includes dependency auditability

**Context:** Selecting a practical public foundation for an H700 native port.

**Finding:** Source quality alone is not sufficient if important dependencies are inaccessible, unpublished or difficult to reproduce.

**Decision:** Project Picori became the principal integration foundation while zeldaret remained an important reference.

**Reusable lesson:** Evaluate the complete build and dependency boundary, not only the core source tree.

## KB-MC-002 - Host success and target success are separate

**Context:** Development on stronger host hardware while targeting Allwinner H700 / Cortex-A53.

**Finding:** A host build does not establish ABI compatibility, timing quality or runtime behaviour on the target.

**Decision:** Host work is used for development and diagnostics; target validation remains a separate gate.

**Reusable lesson:** Keep host evidence and target-runtime evidence distinct.

## KB-MC-003 - Respect the CFW runtime boundary

**Context:** Native integration with muOS.

**Risk:** Replacing or bundling platform libraries can introduce ABI, lifecycle or update conflicts.

**Decision:** Prefer the existing CFW runtime boundary unless a replacement is clearly required and validated.

**Reusable lesson:** Platform compatibility is part of the port architecture.

## KB-MC-004 - Preserve the original presentation and control identity

**Context:** RG34XX-H presentation and handheld integration.

**Decision:** Preserve the game’s art, music, sound effects, UI and GBA control identity. Port-specific diagnostics remain outside the game image, and device-specific combinations are reserved for port functions.

Reference presentation: original 240x160 image scaled to 720x480 using integer 3x scaling.

**Reusable lesson:** Platform adaptation can remain technically substantial while preserving the original presentation.

## KB-MC-005 - Display refresh and game cadence are different clocks

**Context:** High-refresh presentation on the RG34XX-H.

**Finding:** A high-refresh display does not imply that the game logic should run at the same frequency.

**Decision:** Retain game logic around **59.7275 Hz**, use the panel around **119.455 Hz**, and perform **one explicit presentation per logical tick**.

In the recorded comparison, tick-lateness p95 improved from approximately **5.791 ms** to **0.028 ms** under the tested configuration.

**Evidence boundary:** This is not a 120 FPS game-logic claim.

**Reusable lesson:** Separate simulation cadence, presentation calls and panel refresh before interpreting high-refresh behaviour.

## KB-MC-006 - Instrumentation can revise the initial plan

**Context:** High-refresh investigation.

**Finding:** The initial two-present-per-tick hypothesis was not supported by the instrumentation.

**Decision:** Adopt the measured single-present policy instead.

**Reusable lesson:** Experimental design should allow the evidence to change the proposed solution.

## KB-MC-007 - Audio validation needs timing evidence and listening

**Context:** Audio cost on Cortex-A53/H700.

**Finding:** A later 1600-frame test reduced the nominal interval from roughly 40 ms to 33.333 ms while retaining a callback-gap warning/outlier in the instrumentation.

**Validation:** Human audio QA was acceptable for the adopted configuration.

**Evidence boundary:** A heuristic underrun/callback counter is not a direct count of audible defects.

**Reusable lesson:** Instrumentation and listening answer different audio-quality questions and should be used together.

## KB-MC-008 - Benchmark context must represent normal use

**Context:** AutoLab configuration comparison.

**Finding:** Early direct-SSH measurements were affected by frontend/background conditions that did not represent a normal Ports launch.

**Decision:** Later variants used a normal Ports-session context, deterministic replay and CPU/GPU restoration between variants.

**Reusable lesson:** Validate the benchmark environment before relying on the result.

## KB-MC-009 - Automate repeatable work, retain human QA

**Context:** AutoLab comparisons across multiple runtime variants.

**Decision:** Automate deterministic setup, replay, measurement and restoration while keeping final visual/audio acceptance separate.

**Reusable lesson:** Automation is most useful when it removes repetition without replacing perceptual judgment.

## KB-MC-010 - Clock reduction is not a battery-life percentage

**Context:** P13/P13.1 optimisation work.

**Retained configuration evidence:** CPU ceiling 936 MHz, GPU 420 MHz, audio 1600, `TMC_RENDER_THREADS=3`.

The CPU ceiling changed from 1416 MHz to 936 MHz, approximately 33.9%.

**Evidence boundary:** That figure describes frequency reduction only. It is not used as a battery-life or energy-consumption percentage.

The comparison record also retains less favourable observations, including higher maximum temperature in one comparison and slightly higher RSS.

**Reusable lesson:** Report the variable that was actually measured.

## KB-MC-011 - Mixed results improve the record

**Context:** Optimisation and candidate selection.

**Decision:** Retain relevant negative and neutral observations alongside improvements.

**Reusable lesson:** A useful engineering record preserves context and trade-offs, not only favourable values.

## KB-MC-012 - Rejected experiments define useful boundaries

**Context:** Experimental GPU-renderer work during P13.1.

**Finding:** The investigated GPU backend failed and was not promoted. A fullscreen-clear experiment was also not adopted.

**Decision:** Keep these results available for reference and revisit them only if new evidence or requirements justify it.

**Reusable lesson:** Documenting rejected approaches reduces unnecessary repetition.

## KB-MC-013 - Clean exit is part of platform integration

**Context:** Handheld/CFW lifecycle behaviour.

**Work preserved:** Clean-quit unwind, post-shutdown exit and file-select UI/exit diagnostic work are part of the public patch history.

**Reusable lesson:** Startup, gameplay and shutdown all belong to the integration boundary.

## KB-MC-014 - Build evidence should match the claim

**Context:** Cross-build work and the retained private V1.

The retained private V1 is identified by SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

**Evidence boundary:** The hash identifies the artifact; it does not establish that the public repository reproduces identical bytes.

**Reusable lesson:** Use the evidence that directly supports the property being claimed.

## KB-MC-015 - Auditability, reconstruction and reproducibility are distinct

**Context:** P13.1 source-authority material and publication review.

Four source snapshots were retained and hash-verified:

- `port/port_ppu.cpp`
- `port/port_gpu_renderer.cpp`
- `port/port_main.c`
- `xmake.lua`

**Evidence boundary:** These files improve historical traceability but do not establish that the complete final build environment was preserved.

Three separate claims are therefore maintained:

1. **Historical auditability** — decisions and evidence can be traced.
2. **Functional reconstruction** — a new build can be produced and validated.
3. **Bit-for-bit reproducibility** — the specified environment reproduces identical bytes.

**Reusable lesson:** Keep reconstruction claims precise and evidence-specific.

## KB-MC-016 - Licensing is part of the release boundary

**Context:** Public binary redistribution.

**Finding:** The retained private V1 incorporates VirtuaAPU. At the audited revision, VirtuaAPU did not provide an explicit published licence file.

**Decision:** Publish cleared source-side integration material, but do not redistribute VirtuaAPU or the V1 executable incorporating it until the licensing path is resolved.

**Reusable lesson:** Technical validity and redistribution eligibility are separate requirements.

## KB-MC-017 - Review publication scope and documentation scope separately

**Context:** Initial public release preparation.

**Finding:** Restricting private or non-redistributable material does not require reducing safe technical documentation.

**Decision:** Keep redistribution controls focused on the affected content while publishing safe decisions, measurements, limitations and lessons.

**Reusable lesson:** A careful release boundary can coexist with comprehensive technical documentation.

## KB-MC-018 - Local QA and production verification are separate gates

**Context:** Miguel's Game Dev Lab music-player maintenance.

**Finding:** A local candidate passed QA before the live site had been updated.

**Decision:** Treat candidate validation, repository publication, deployment and live verification as distinct states.

**Reusable lesson:** Confirm the production artifact before closing a live-site issue.

## KB-MC-019 - Keep tooling proportionate to the task

**Context:** Publication and recovery automation.

**Finding:** Large automation scripts introduced avoidable parser, state and helper errors during otherwise small operations.

**Decision:** Prefer direct, auditable steps for small tasks; use automation when it reduces meaningful repetition or risk.

**Reusable lesson:** Tooling should simplify the workflow rather than become an additional engineering problem.

## KB-MC-020 - Reuse verified local artifacts when available

**Context:** Music-source recovery.

**Finding:** The required MP3 files were already present locally from an earlier official download.

**Decision:** Inventory and validate existing artifacts before requesting reacquisition.

**Reusable lesson:** Check the known local state before creating unnecessary repeat work.

## Template for future entries

When adding a new lesson, prefer:

- **Status**
- **Context**
- **Finding/problem**
- **Decision/resolution**
- **Validation**
- **Evidence limits**
- **Reusable lesson**
