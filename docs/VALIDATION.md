# Validation evidence and limits

This document records what has actually been validated for the RG34XX/H700 line and what must not be inferred beyond that evidence.

## Reference target

Validated reference configuration:

- Device: **ANBERNIC RG34XX-H**
- SoC: **Allwinner H700**
- CPU class: **Cortex-A53**
- Architecture: **AArch64**
- CFW: **muOS**
- Display: **720x480**

Other H700 devices or other custom firmware may work, but they are not presented as validated unless independently tested.

## Retained private V1 identity

SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

This identifies the retained private executable used as the stable project artifact.

The executable itself is not distributed publicly.

## Presentation

The project preserves the original 240x160 presentation and uses integer 3x scaling to the RG34XX-H 720x480 display.

This reflects the project principle that the port should adapt infrastructure without visually replacing the game.

## Timing/high-refresh evidence

The accepted direction separates three concepts:

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

This does **not** mean the game logic runs at 119/120 FPS.

The usefulness of the high-refresh work was improved presentation/timing behaviour under the measured configuration while retaining the original logical cadence.

## Audio evidence

The project investigated audio cost and callback timing on Cortex-A53/H700.

Preserved later configuration evidence includes:

- audio value: **1600**;
- nominal interval change discussed in the project record: roughly 40 ms -> 33.333 ms;
- human listening QA: accepted for the retained direction;
- an outlier/callback-gap warning remained visible in the record.

### Evidence boundary

A heuristic callback/underrun counter is not a literal audible-defect count.

Human listening and timing instrumentation are complementary evidence, not substitutes for one another.

## Runtime/optimisation evidence

Retained P13/P13.1 configuration evidence:

- CPU ceiling: **936 MHz**;
- GPU: **420 MHz**;
- audio: **1600**;
- `TMC_RENDER_THREADS=3`.

The CPU ceiling was reduced from 1416 MHz to 936 MHz, approximately 33.9%.

### Evidence boundary

That 33.9% frequency reduction is **not** a claim of 33.9% energy savings or battery-life improvement.

The project record also retained mixed results, including a comparison with a higher recorded maximum temperature and slightly higher RSS. These are kept to avoid cherry-picking only favourable numbers.

A retained acceptance note recorded 874 samples and a maximum temperature of approximately **52.6 C** under that test context.

This is not, by itself, proof of a full-playthrough thermal guarantee, leak-free execution or universal H700 behaviour.

## Rejected/negative results

The project deliberately retains negative evidence.

Examples:

- an experimental GPU-renderer path failed and was not promoted;
- a fullscreen-clear experiment was not adopted;
- early direct-SSH AutoLab measurements were invalidated because the test context did not represent a normal Ports launch;
- some high-refresh hypotheses were rejected after instrumentation contradicted them.

These are part of validation because they narrow the set of approaches future work should trust.

## AutoLab methodology

Later comparison work used automation to reduce repetitive manual setup across variants.

Important methodological correction:

Early direct-SSH measurements were treated as contaminated by frontend/background state and were not accepted as authoritative optimisation evidence.

The improved approach executed variants through a normal Ports-session context, with deterministic replay and CPU/GPU restoration between variants.

Final visual/audio acceptance remained human.

## Exit/lifecycle evidence

Public patch history preserves dedicated work on:

- exit diagnostics;
- clean-quit unwind;
- post-shutdown exit;
- file-select/UI clean-exit behaviour.

This reflects the project position that a port must return control to the handheld/frontend cleanly, not merely render gameplay correctly.

## Public/source validation versus private-binary validation

The public repository is a source/patch/launcher record.

The retained private V1 is a separate artifact.

Therefore these are distinct questions:

- **Is the public source material internally documented and attributable?**
- **Can a new build be reconstructed from it?**
- **Does a new build behave like the retained V1 on RG34XX-H?**
- **Does it reproduce the V1 bit-for-bit?**

Only the first is fully addressed by the current public publication. The second is a future clean reconstruction task. The fourth is not claimed.

## Licensing validation boundary

The private V1 used VirtuaAPU. At the audited revision, VirtuaAPU had no explicit published licence file.

Therefore public validation of the retained executable does not imply permission to redistribute that executable.

Technical validity and redistribution rights are separate gates.

## Claim discipline

When citing this project, keep claims proportional to evidence.

Supported examples:

- "validated on ANBERNIC RG34XX-H with muOS";
- "the retained private V1 has SHA-256 ...";
- "the accepted timing direction retained ~59.7275 Hz logical cadence on a ~119.455 Hz panel";
- "the recorded comparison improved tick-lateness p95 under the tested conditions";
- "later retained runtime evidence used CPU936/GPU420/audio1600/3 render threads".

Unsupported examples:

- "runs at 120 FPS";
- "uses 33.9% less power";
- "works on all H700 devices";
- "is bit-for-bit reproducible";
- "the private binary can be redistributed safely".

The purpose of these boundaries is not to weaken the project. It is to make the record more trustworthy and reusable.
