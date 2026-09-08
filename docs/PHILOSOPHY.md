# Why this approach?

Preserve the game. Make its technical execution dependable. Choose a coherent presentation for the handheld.

## Keep the creative work intact

My aim is to preserve the released game's content, artwork, music, mechanics, progression and control identity.

More hardware capacity is useful when it helps the same work run reliably. It is not a reason to add content or reinterpret the game.

I use a conservative premise: what technical obstacles might more optimisation time and hardware margin remove from this same work?

The finished game is the reference for those decisions. Additional hardware margin serves the work already present in it.

## Choose a fitting device

I grew up with PC games. My father gave me my first console, a Game Boy Advance. The RG34XX's resemblance to it is the main reason for this choice.

The screen reinforces that fit. Its 720 × 480 resolution accommodates the game's 240 × 160 image at an exact 3× scale (ANBERNIC, n.d.).

Historical logs use the name RG34XX-H. The product name used here is RG34XX.

## Restore rather than repaint

Painting restoration offers a useful analogy. Preserve the image; do not add new details. A familiar layer of yellowed varnish is not necessarily part of the work beneath it.

For this port, code, behaviour and historical context help distinguish creative choices from technical defects.

Known technical bugs are eligible for correction. Their popularity or use as exploits does not make them intentional. Each correction still needs a reproducible case and a documented test.

When the evidence cannot distinguish a defect from a design choice, preserve the behaviour. Keep limitations that have become part of the artwork, composition or characteristic sound.

## Provide a curated starting point

The player should not need dozens of adjustments to reach the intended experience.

The reference policy is simple: original imagery at integer scale, original controls, and no smoothing, shaders or instructional messages over gameplay.

The reference keeps port instructions off the game image. Settings remain available through `MENU+R2`; `MENU+L2` returns to muOS.

The GBA control set remains reserved for the game. Additional port functions use the device-specific shortcuts. This separates platform controls from the game itself.

Useful inherited Project Picori options can remain accessible. Changing them may move the setup outside the validated reference.

Unnecessary options may be hidden or removed through a documented change. New creative or non-preservation features belong in a separate project or branch, not this port.

## Use native execution as a tool

Native game logic gives the project control over the host build, timing, input, audio and shutdown handling.

It still uses Linux, SDL and software models of original hardware behaviour. Performance and energy use require their own measurements.

[What the source and measurements show](EVIDENCE_AUDIT.md).

## Prefer efficiency after fidelity

The order is **fidelity → stability → justified technical correction → efficiency**.

Spare capacity is a reserve. It does not have to become extra effects or features.

The accepted record uses CPU/GPU ceilings of 936/420 MHz, an audio request of 1,600 frames and three rendering threads.

Lower power and heat are goals, not measured benefits inferred from those settings. The [results](VALIDATION.md) retain missing energy measurements and an adverse temperature comparison.

Underclocking is acceptable only while the tested timing, sound and fidelity criteria remain satisfied. Stability and fidelity take priority when they conflict with efficiency.

## Keep each intervention focused

Use the smallest change that addresses the demonstrated problem. Record what changed, why it changed and what the test showed.

Historical uncorrected behaviour can remain useful for comparison. It does not need to become a normal user-facing mode.

Detailed documentation supports small changes. Its purpose is to help others understand, check and reuse the work.

**Next:** [See the practical lessons](KNOWLEDGE_BASE.md).

## External reference

ANBERNIC. (n.d.). *ANBERNIC RG 34XX*. Retrieved September 7, 2026, from https://anbernic.com/en-fr/products/rg34xx
