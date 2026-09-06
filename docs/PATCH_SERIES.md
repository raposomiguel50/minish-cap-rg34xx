# Patch history and application intent

The files under `patches/` are **not one linear patch stack to apply blindly**.

They preserve the engineering history of the RG34XX/H700 integration: foundational fixes, target-specific work, instrumentation, A/B experiments, superseded approaches and policies that contributed to the retained private V1 line.

This document exists so the patch directory can be read as a decision record rather than as an unexplained pile of diffs.

## Status vocabulary

- **Foundation** — required or broadly useful work that enabled the target path.
- **Accepted direction** — work whose underlying decision was retained in the stable line.
- **Instrumentation** — diagnostic/measurement code; useful for study, not necessarily for a production build.
- **A/B experiment** — a controlled alternative used to test a hypothesis.
- **Historical / superseded** — retained because it explains the route taken, but not intended as the current final implementation.

The exact P13.1 worktree used around the retained V1 was not preserved as a complete isolated tree. Therefore this classification describes the **engineering role** of each published patch; it is not a claim that applying every “accepted” patch to the upstream pin recreates the private V1 bit-for-bit.

## Foundation

### `P04_AARCH64_LINK_COMPLETENESS_R1.patch`

**Role:** AArch64 build/link completeness.

The target cannot be treated as a desktop build with a different compiler flag. Missing architecture-specific objects or incomplete link inputs must be resolved explicitly.

**Reusable lesson:** cross-build completeness is part of the port, not a post-build packaging detail.

### `P04_FMT_PACKED_COLLISION_R1.patch`

**Role:** build compatibility / packed-format collision resolution.

**Reusable lesson:** small compiler/ABI compatibility defects should be isolated and fixed narrowly rather than becoming justification for large source rewrites.

### `P06_H700_CORTEX_A53_TARGET_R1.patch`

**Role:** target the H700 / Cortex-A53 execution environment deliberately.

**Reusable lesson:** optimising for the target starts with naming the actual target rather than relying on generic ARM64 assumptions.

## Handheld integration

### `P09_RG34XX_HANDHELD_POLISH_R1.patch`

**Role:** RG34XX-specific handheld integration/polish.

This belongs to the layer where the port adapts to device controls/presentation while attempting to preserve the original game identity.

**Status:** accepted direction / historical integration evidence.

## Exit and lifecycle investigation

### `P10_3_1_EXIT_DIAG_R1.patch`

**Role:** exit-path diagnostics.

**Status:** instrumentation.

### `P10_3_1D2_CLEAN_QUIT_UNWIND_R1.patch`

**Role:** clean-quit/unwind investigation.

**Status:** accepted direction with later exit work layered after it.

### `P10_3_1D3_RG34XX_POST_SHUTDOWN_EXIT_R1.patch`

**Role:** post-shutdown process-exit behaviour on the target.

**Status:** accepted direction / later lifecycle refinement.

### `P10_3_2_RG34XX_CLEAN_EXIT_FILESELECT_UI_R3.patch`

**Role:** clean-exit behaviour around file-select/UI flow.

**Status:** later lifecycle integration evidence.

**Reusable lesson for this group:** a port is not complete when only its steady-state gameplay works. Shutdown and return-to-frontend behaviour are part of target integration.

## High-refresh / presentation investigation

### `P10_3_RG34XX_SEAMLESS_HIGH_REFRESH_R1.patch`

**Role:** early high-refresh presentation experiment.

**Status:** historical / experimental foundation for later measurement.

It should not be interpreted as evidence that game logic was promoted to 120 FPS.

### `P11_1_RG34XX_TIMING_INPUT_PRESENT_TRACE_R3.patch`

**Role:** timing/input/presentation instrumentation.

**Status:** instrumentation.

This patch exists to measure separate cadence domains rather than infer them from display refresh.

### `P11_2_RG34XX_HIGH_REFRESH_VSYNC_OFF_AB_R1.patch`

**Role:** VSync-off A/B experiment.

**Status:** A/B experiment, not a universal recommendation.

### `P11_3_RG34XX_PPU_PHASE_SPLIT_TRACE_R3.patch`

**Role:** PPU/presentation-phase trace instrumentation.

**Status:** instrumentation.

### `P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch`

**Role:** test and establish the single-present policy on a ~119.455 Hz panel while retaining ~59.7275 Hz logical cadence.

**Status:** accepted direction.

The preserved comparison recorded tick-lateness p95 improving from ~5.791 ms to ~0.028 ms under the tested conditions.

**Important boundary:** this does not mean the game simulation runs at 119/120 FPS.

## Audio investigation

### `P10_3_1_RG34XX_A53_AUDIO_R1.patch`

**Role:** A53/H700 audio-path work.

**Status:** accepted direction / historical input to later audio tuning.

The later retained configuration evidence uses an audio value of 1600. The public patch history should be read together with the knowledge-base entry on audio timing and human listening.

## Production-like runtime policy

### `P11_7_RG34XX_PRODUCTION_LIKE_RUNTIME_POLICY_R1.patch`

**Role:** move from instrumentation-heavy experimentation toward a production-like runtime policy.

**Status:** accepted direction.

This is important conceptually: diagnostic code and experimental settings should not remain enabled merely because they were useful during investigation.

## Work preserved outside this public patch set

The project record also contains later P12/P13/P13.1 AutoLab and optimisation evidence. Not every source snapshot or private build artifact from those phases is redistributed here.

Retained V1 evidence includes the configuration:

- CPU ceiling: **936 MHz**
- GPU: **420 MHz**
- audio: **1600**
- `TMC_RENDER_THREADS=3`

The experimental GPU backend that failed was not adopted. A fullscreen-clear experiment was also not promoted into the retained V1 line.

These negative results matter because they prevent a future maintainer from assuming every experiment should be reapplied.

## How to use this directory

If you are studying or reconstructing the port:

1. start from the pinned Project Picori revision in `SOURCE_BASELINE.json`;
2. read `docs/PHILOSOPHY.md` and `docs/KNOWLEDGE_BASE.md` first;
3. treat Foundation patches separately from instrumentation and A/B experiments;
4. apply one conceptual change at a time;
5. verify that the patch matches the source revision before applying it;
6. build and test after each accepted layer;
7. do not apply instrumentation or historical A/B patches merely because they have a higher phase number;
8. keep target testing separate from host build success.

A future independently validated reconstruction recipe should convert this historical map into a smaller supported patch/build sequence. Until then, this file is intentionally explicit about the difference between **engineering history** and **a supported apply-all recipe**.
