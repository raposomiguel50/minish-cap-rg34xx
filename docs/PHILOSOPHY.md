# Technical restoration, preservation and curation

**Status: approved project policy.** This document explains decision criteria. It is not a catalogue of bugs already fixed or a substitute for the [implementation and evidence audit](EVIDENCE_AUDIT.md).

## The creative work is the reference

My aim is to preserve the released game's content, art, music, mechanics, structure, progression, deliberate cadence and control identity. Additional hardware capability is useful when it supports reliable execution of that work; it is not a reason to add creative material.

The premise of giving the original developers more optimisation time and technical margin is a conservative guide to this aim. It does not reconstruct an unmade game or attribute undocumented intentions to its authors. The released work is the main reference.

## Why the RG34XX

I grew up with PC games, and my father gave me my first console, a Game Boy Advance. The RG34XX's physical resemblance to that console motivated the choice. Its 720 × 480 screen also fits a 3× scale of the game's 240 × 160 image (ANBERNIC, n.d.). ANBERNIC calls the device RG34XX; the [historical project records](evidence/2026-09-07/final_acceptance.json) use RG34XX-H.

## Restoration, not overpainting

I use painting restoration as an analogy: retain the image rather than add new detail, and distinguish the work from a degraded layer obscuring it. Familiarity with yellowed varnish does not, in this analogy, make it part of the intended image.

For this project, the equivalent decision is to distinguish creative choices from demonstrated implementation defects. The analogy is a curatorial principle, **not empirical proof** that a particular game behaviour is defective.

Known technical bugs are eligible for correction when feasible and compatible with the work. A bug's popularity or use as an exploit does not by itself make it intentional. Conversely, when code, observed behaviour and contextual evidence do not resolve defect versus design, preserve the behaviour by default. Characteristics arising from hardware limits but incorporated into the art, composition or sound remain part of the work.

Each adopted correction should identify the symptom, reproduction conditions, original/port origin, patch or commit, tested build and observed result. This audit has not established an original-GBA gameplay-bug correction; the [concrete exit fix documented so far](EVIDENCE_AUDIT.md#2-exit-handling-a-port-defect-not-an-original-game-bug) concerns the host port.

## One curated reference

The reference should be usable without requiring the player to assemble it through many technical choices. The [launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh) selects `--window_scale=3 --console-parity`; the [integration patches](PATCH_SERIES.md) hide the legacy settings hint while retaining access through MENU+R2. MENU+L2 exits. These are documented choices, not a claim that every upstream option has been audited or removed.

The approved default policy is integer-scaled original imagery, without smoothing, shaders or instructional overlays that change the game image. GBA controls stay assigned to the game; device-specific shortcuts provide port functions. Useful inherited options can remain accessible, but changing them need not represent the validated reference. Options without a clear purpose may be hidden or removed only through a separately documented change.

New content, new mechanics and new non-preservation presentation features are outside this port's scope. Such work would need a separate project or branch; this is a boundary, **not an announcement or commitment to develop one**.

## Native execution is a means

The practical purpose is control over the host build, timing, input, presentation, audio and lifecycle. Native game logic does not eliminate Linux, SDL or all software models of original hardware behaviour. Actual gains must be measured; no automatic speed or power advantage is inferred from the word “native”. See the [audited implementation and measurement limits](EVIDENCE_AUDIT.md).

## Fidelity before efficiency

The order is fidelity, stability, justified removal of technical obstacles, then efficiency. Spare CPU/GPU capacity is a reserve rather than an obligation to add effects. Reduced clocks are acceptable only while the tested fidelity, timing and audio criteria remain satisfied.

The [archived accepted configuration](evidence/2026-09-07/final_acceptance.json) specifies CPU ceiling 936 MHz, GPU ceiling 420 MHz, audio 1,600 frames and three render threads. Lower power and temperature are objectives, not results established by the frequency values. The audit retains an [adverse temperature comparison](evidence/2026-09-07/runtime_winner.json) and [missing energy measurements](evidence/2026-09-07/stage_a_winner.json).

## Focus, containment and shared knowledge

Prefer a small intervention with a clear purpose, test and evidence trail. Detailed documentation is compatible with minimal code changes. Record negative results and distinguish a proposed test from an executed one.

Historical uncorrected behaviour can remain useful for comparison, diagnostics or research without becoming a mandatory user-facing mode. The curated port and the historical reference answer different questions. Neither should be used to invent an improvement that has not been demonstrated.

## External reference

ANBERNIC. (n.d.). *ANBERNIC RG 34XX*. Retrieved September 7, 2026, from https://anbernic.com/en-fr/products/rg34xx
