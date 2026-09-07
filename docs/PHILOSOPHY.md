# Preservation philosophy and project principles

This project uses **preservation, containment, focus, restoration, minimalism and curation** as practical engineering principles.

The objective is to adapt *The Minish Cap* reliably to the target platform while preserving the original creative work. Native execution, optimisation and additional hardware margin are useful only insofar as they serve that objective.

## Why this hardware matters

The RG34XX-H was a deliberate choice. Its horizontal form and overall design closely recall the original Game Boy Advance, which makes it a particularly appropriate physical context for this project.

I grew up mainly with PCs and PC games. The Game Boy Advance was the first console I owned, given to me by my father. That personal link is part of why preserving the character of the original handheld experience matters here.

The technical fit supports the same direction: the RG34XX-H display is **720x480**, so the GBA's original **240x160** image can be presented at an exact **3x integer scale** without changing its proportions. The H700 and muOS also provide a constrained ARM/Linux platform suitable for practical native-port work.

## Why native execution matters

Running the project natively removes the need to emulate the original GBA CPU, graphics, audio and timing environment. The game instead executes as AArch64 software within Linux/muOS and can use the RG34XX-H platform resources through the native runtime.

This is not bare-metal execution, but it gives the project more direct control over timing, presentation, audio, threading, input, lifecycle behaviour and resource use.

The additional margin is not a licence to redesign the game. It is a means of reducing avoidable technical compromises while preserving the same creative work.

As a restoration premise, I ask what technical limitations could be removed if the same game had more optimisation time and more hardware margin available to express what is already present in the finished work. This is not a historical claim about undocumented developer intentions. The published game remains the primary evidence for the work being preserved.

## Restoration: preserve the work, not every defect of the medium

The closest analogy is restoration of a painting.

A conservator does not repaint the artist's work or add details that were never there. At the same time, degradation such as discoloured varnish does not become part of the original painting merely because viewers have become accustomed to it.

The same distinction applies here. The project separates the creative work from technical defects or limitations affecting its presentation.

This means that known technical bugs, crashes, save problems, avoidable slowdowns, stutter and other implementation defects may be corrected when the correction preserves the game's content, mechanics, visual identity, sound, structure and deliberate cadence.

Familiarity with a defect does not by itself make that defect part of the work.

If the available evidence does not establish whether a behaviour is a technical defect or a creative decision, the default is to preserve it.

Observable differences introduced by restoration are documented so that the restored reference and the historical behaviour remain distinguishable.

## Preservation

The published game is the primary reference for:

- art and visual identity;
- music and sound effects;
- interface behaviour;
- mechanics, structure and progression;
- deliberate cadence and timing;
- GBA control identity.

A technically possible change is not automatically an improvement. New creative content, replacement art, new mechanics, reinterpretation or cosmetic embellishment are outside the restoration objective.

A limitation that has been deliberately incorporated into the work's aesthetic language is also preserved. Pixel art, resolution, composition, palette and characteristic sound are not treated as defects simply because modern hardware could present something technically different.

## Curation

Preservation is not served by presenting the player with an unstructured collection of technical choices.

The project therefore defines and validates a **reference configuration**. The objective is to present a coherent experience intentionally, rather than require the player to assemble it from many small adjustments.

For the preservation reference:

- the original **240x160** image is presented at exact **3x integer scale** to **720x480**;
- smoothing, shaders and presentation overlays that alter the original image are not part of the default presentation;
- Project Picori's menu functions remain accessible through shortcuts, while its instructional overlays are disabled by default so they do not cover the game image;
- the original GBA control identity remains reserved for the game;
- port functions use device-specific combinations that do not replace the original controls;
- inherited Project Picori options may remain accessible, but changing them can move the configuration outside the project's validated preservation reference;
- upstream options that do not serve a clear technical, historical or functional purpose may be removed or kept out of the main experience.

Convenience or presentation features inherited from upstream can remain accessible without becoming part of the preservation reference. The project does not add new non-preservation features as part of this restoration work.

## Technical restoration and historical reference are different goals

The main objective is preservation of the work through technical restoration.

Reproducing every original technical defect is a different, archaeological objective. Historical behaviour may be retained when it has real value for comparison, A/B testing, documentation or investigation, but it does not have to be exposed as the normal user experience.

This distinction allows the project to correct a demonstrated defect while still preserving the evidence needed to understand what changed and why.

## Efficiency after fidelity

The priority order is:

1. preserve the work faithfully;
2. maintain stable execution;
3. remove avoidable technical obstacles where justified;
4. reduce unnecessary resource use once the first three conditions are satisfied.

Unused hardware margin is treated as reserve, not as a budget that must be spent on additional effects or features.

The retained V1 configuration reflects this principle:

- CPU ceiling **936 MHz**;
- GPU **420 MHz**;
- audio **1600**;
- `TMC_RENDER_THREADS=3`.

The reduced clocks were adopted with the objective of lowering unnecessary power and thermal demand while maintaining the validated experience. That objective is distinct from a measured power or temperature result.

A CPU-frequency reduction is therefore reported as a frequency change only. It is not converted into an equivalent battery-life, energy-consumption or temperature percentage without direct measurements.

If efficiency and fidelity ever conflict, fidelity and stability take priority.

## Containment

Changes are kept within the smallest practical boundary that addresses the problem being investigated.

This helps to:

- reduce regression risk;
- make comparisons clearer;
- keep upstream differences understandable;
- preserve the purpose of each change;
- simplify future maintenance.

A build issue should remain a build issue unless evidence shows that a broader architectural change is required. The same principle applies to timing, audio, lifecycle and restoration work.

## Focus

Research and stable scope are kept distinct.

A technical experiment may be useful for learning without becoming part of the accepted port. Failed or rejected renderer, presentation or optimisation experiments remain documented when they define useful technical boundaries.

They are engineering investigations, not a separate creative direction for the game.

## Minimalism

Minimalism applies to the technical intervention, not to the quality of documentation.

A small change can still require clear evidence, measurements, alternatives and limitations. Detailed documentation makes small improvements easier to understand, reproduce and reuse.

## Incremental improvement

The project favours small, measurable improvements that can be evaluated independently.

Work on pacing, build reliability, exit behaviour, audio margin, benchmark validity, runtime integration and efficiency is treated as a sequence of contained improvements rather than a broad redesign.

This makes it easier to identify which change produced a result and to retain only the work that contributes to the preservation objective.

## Evidence and claims

Claims are kept proportional to the evidence available.

For example:

- a lower CPU ceiling is reported as a frequency change, not as equivalent battery savings;
- a high-refresh display does not imply that game logic runs at the panel refresh rate;
- an instrumentation counter is not treated as a direct measure of perceived audio defects;
- a binary hash identifies an artifact but does not establish reproducibility;
- validation on one device/CFW combination is not presented as universal compatibility;
- a suspected technical defect is not altered merely because a different behaviour appears preferable.

Where the distinction between defect and design is uncertain, preservation is the default.

Mixed and negative results remain part of the record when they help define the limits of a conclusion.

## Human direction and AI assistance

The project is human-directed and AI-assisted.

I define the project goals, preservation criteria, scope, target hardware, acceptance criteria and final decisions. Real-device observations and final quality judgments remain part of that responsibility.

ChatGPT assists with programming, calculations, automation, analysis, debugging and documentation. AI-assisted output is reviewed against the project requirements and evidence before adoption.

## Public documentation

The public repository is intended to provide both usable integration work and a clear technical record.

Where redistribution is restricted, the restriction applies to the affected content or binary. Safe engineering information — decisions, measurements, rejected experiments, restoration decisions, validation limits and reusable lessons — remains documented where possible.
