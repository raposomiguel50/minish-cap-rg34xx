# Patch history and application intent

The files under `patches/` document different stages of the RG34XX/H700 integration. They include foundation work, instrumentation, A/B experiments, accepted directions and historical approaches.

They should be read by role rather than as one linear patch sequence.

## Status vocabulary

- **Foundation** — required or broadly useful work that enabled the target path.
- **Accepted direction** — work whose underlying decision was retained in the stable line.
- **Instrumentation** — diagnostic or measurement code.
- **A/B experiment** — a controlled alternative used to test a hypothesis.
- **Historical / superseded** — retained for reference but not intended as the current final implementation.

The complete isolated P13.1 worktree used around the retained V1 was not preserved. This classification describes the engineering role of each published patch; it does not establish that applying all accepted patches recreates the private V1 bit-for-bit.

## Foundation

### `P04_AARCH64_LINK_COMPLETENESS_R1.patch`

**Role:** AArch64 build/link completeness.

Resolves architecture-specific build/link requirements needed for the target path.

**Reusable lesson:** Cross-build completeness is part of the port, not a packaging detail.

### `P04_FMT_PACKED_COLLISION_R1.patch`

**Role:** build compatibility / packed-format collision resolution.

**Reusable lesson:** Compiler/ABI compatibility issues are easier to validate when fixed within a narrow scope.

### `P06_H700_CORTEX_A53_TARGET_R1.patch`

**Role:** explicit H700 / Cortex-A53 targeting.

**Reusable lesson:** Target-specific optimisation begins with an explicit hardware baseline rather than a generic ARM64 assumption.

## Handheld integration

### `P09_RG34XX_HANDHELD_POLISH_R1.patch`

**Role:** RG34XX-specific handheld integration and presentation work.

**Status:** accepted direction / historical integration evidence.

## Exit and lifecycle

### `P10_3_1_EXIT_DIAG_R1.patch`

**Role:** exit-path diagnostics.

**Status:** instrumentation.

### `P10_3_1D2_CLEAN_QUIT_UNWIND_R1.patch`

**Role:** clean-quit/unwind work.

**Status:** accepted direction with later lifecycle refinements.

### `P10_3_1D3_RG34XX_POST_SHUTDOWN_EXIT_R1.patch`

**Role:** post-shutdown process-exit behaviour.

**Status:** accepted direction / later lifecycle refinement.

### `P10_3_2_RG34XX_CLEAN_EXIT_FILESELECT_UI_R3.patch`

**Role:** clean-exit behaviour around file-select/UI flow.

**Status:** later lifecycle integration evidence.

**Reusable lesson for this group:** Startup, gameplay and shutdown are all part of the target integration boundary.

## High-refresh / presentation

### `P10_3_RG34XX_SEAMLESS_HIGH_REFRESH_R1.patch`

**Role:** early high-refresh presentation experiment.

**Status:** historical / experimental foundation for later measurement.

### `P11_1_RG34XX_TIMING_INPUT_PRESENT_TRACE_R3.patch`

**Role:** timing/input/presentation instrumentation.

**Status:** instrumentation.

### `P11_2_RG34XX_HIGH_REFRESH_VSYNC_OFF_AB_R1.patch`

**Role:** VSync-off A/B experiment.

**Status:** A/B experiment.

### `P11_3_RG34XX_PPU_PHASE_SPLIT_TRACE_R3.patch`

**Role:** PPU/presentation-phase trace instrumentation.

**Status:** instrumentation.

### `P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch`

**Role:** single-present policy on a ~119.455 Hz panel while retaining ~59.7275 Hz logical cadence.

**Status:** accepted direction.

The preserved comparison recorded tick-lateness p95 improving from approximately 5.791 ms to 0.028 ms under the tested conditions.

**Evidence boundary:** This does not mean the game simulation runs at 119/120 FPS.

## Audio

### `P10_3_1_RG34XX_A53_AUDIO_R1.patch`

**Role:** Cortex-A53/H700 audio-path work.

**Status:** accepted direction / historical input to later audio tuning.

Later retained configuration evidence uses an audio value of 1600. See the audio entries in `docs/KNOWLEDGE_BASE.md` and `docs/VALIDATION.md` for timing and QA context.

## Production-like runtime policy

### `P11_7_RG34XX_PRODUCTION_LIKE_RUNTIME_POLICY_R1.patch`

**Role:** transition from instrumentation-heavy experimentation toward a production-like runtime policy.

**Status:** accepted direction.

Diagnostic and experimental settings are kept separate from the stable runtime unless they remain necessary.

## Later private engineering evidence

The private project record also contains P12/P13/P13.1 AutoLab and optimisation evidence. Not every source snapshot or private build artifact from those phases is redistributed here.

Retained V1 evidence includes:

- CPU ceiling: **936 MHz**
- GPU: **420 MHz**
- audio: **1600**
- `TMC_RENDER_THREADS=3`

The experimental GPU backend was not adopted. A fullscreen-clear experiment was also not promoted into the retained V1 line.

## How to use this directory

For study or reconstruction:

1. start from the pinned Project Picori revision in `SOURCE_BASELINE.json`;
2. review `docs/PHILOSOPHY.md` and `docs/KNOWLEDGE_BASE.md`;
3. separate Foundation patches from instrumentation and A/B experiments;
4. apply one conceptual change at a time;
5. verify each patch against the source revision;
6. build and test after each accepted layer;
7. keep diagnostic/historical patches separate unless reproducing those experiments;
8. validate target behaviour separately from host-build success.

A future validated reconstruction procedure can reduce this historical map to a smaller supported patch/build sequence.
