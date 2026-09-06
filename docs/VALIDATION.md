# Validation evidence and limits

This document records the validation evidence available for the RG34XX/H700 integration and the limits of the conclusions that can be drawn from it.

## Reference target

Validated reference configuration:

- Device: **ANBERNIC RG34XX-H**
- SoC: **Allwinner H700**
- CPU class: **Cortex-A53**
- Architecture: **AArch64**
- CFW: **muOS**
- Display: **720x480**

Other H700 devices or custom firmware may be compatible, but they are not presented as validated without independent testing.

## Retained private V1 identity

SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

This identifies the retained private executable used as the stable project artifact. The executable itself is not distributed publicly.

## Presentation

The project preserves the original 240x160 presentation and uses integer 3x scaling to the RG34XX-H 720x480 display.

## Timing/high-refresh evidence

The accepted direction separates:

- game/simulation cadence;
- explicit presentation calls;
- physical display refresh.

Recorded values for the tested configuration:

- logical cadence: approximately **59.7275 Hz**;
- panel: approximately **119.455 Hz**;
- accepted direction: **one explicit presentation per logical tick**.

Recorded comparison:

- tick-lateness p95 before the accepted single-present direction: approximately **5.791 ms**;
- tick-lateness p95 in the recorded accepted comparison: approximately **0.028 ms**.

### Evidence boundary

This result concerns presentation timing while retaining the original logical cadence. It is not a 119/120 FPS game-logic claim.

## Audio evidence

Preserved later configuration evidence includes:

- audio value: **1600**;
- nominal interval discussed in the project record: approximately 33.333 ms;
- human listening QA: accepted for the retained direction;
- a callback-gap/outlier warning retained in the record.

### Evidence boundary

A heuristic callback/underrun counter is not treated as a direct count of audible defects. Timing instrumentation and listening provide complementary evidence.

## Runtime/optimisation evidence

Retained P13/P13.1 configuration evidence:

- CPU ceiling: **936 MHz**;
- GPU: **420 MHz**;
- audio: **1600**;
- `TMC_RENDER_THREADS=3`.

The CPU ceiling changed from 1416 MHz to 936 MHz, approximately 33.9%.

### Evidence boundary

That figure describes CPU-frequency reduction only. It is not used as an equivalent energy-savings or battery-life percentage.

The project record also includes mixed results, including a comparison with a higher recorded maximum temperature and slightly higher RSS.

A retained acceptance note recorded 874 samples and a maximum temperature of approximately **52.6 C** under that test context.

This does not establish a full-playthrough thermal guarantee, leak-free execution or universal H700 behaviour.

## Rejected and negative results

Relevant negative evidence includes:

- an experimental GPU-renderer path that failed and was not promoted;
- a fullscreen-clear experiment that was not adopted;
- early direct-SSH AutoLab measurements that were invalidated because the test context did not represent a normal Ports launch;
- high-refresh hypotheses revised after instrumentation.

These results remain documented because they clarify the tested boundaries of the project.

## AutoLab methodology

Later comparison work used automation to reduce repeated manual setup across variants.

Early direct-SSH measurements were not accepted as authoritative optimisation evidence because the surrounding frontend/background state differed from a normal Ports launch.

The revised approach used a normal Ports-session context, deterministic replay and CPU/GPU restoration between variants. Final visual/audio acceptance remained human.

## Exit/lifecycle evidence

Public patch history includes dedicated work on:

- exit diagnostics;
- clean-quit unwind;
- post-shutdown exit;
- file-select/UI clean-exit behaviour.

Clean return to the handheld/frontend is treated as part of target integration.

## Public source and private-binary validation

The public repository is a source/patch/launcher record. The retained private V1 is a separate artifact.

These remain distinct questions:

- Is the public source material documented and attributable?
- Can a new build be reconstructed from it?
- Does a new build behave like the retained V1 on RG34XX-H?
- Does it reproduce the V1 bit-for-bit?

The current public publication addresses the first directly. Functional reconstruction remains a separate validation task, and bit-for-bit reproduction is not currently claimed.

## Licensing boundary

The retained private V1 used VirtuaAPU. At the audited revision, VirtuaAPU did not provide an explicit published licence file.

Validation of the private executable therefore remains separate from permission to redistribute it.

## Supported wording

Examples consistent with the current evidence:

- "validated on ANBERNIC RG34XX-H with muOS";
- "the retained private V1 has SHA-256 ...";
- "the accepted timing direction retained ~59.7275 Hz logical cadence on a ~119.455 Hz panel";
- "the recorded comparison improved tick-lateness p95 under the tested conditions";
- "later retained runtime evidence used CPU 936 MHz, GPU 420 MHz, audio 1600 and three render threads".

Claims not currently supported include:

- 120 FPS game logic;
- a proportional battery/power reduction derived from CPU frequency alone;
- compatibility with all H700 devices;
- bit-for-bit reproducibility of the retained V1;
- unrestricted redistribution of the private executable.
