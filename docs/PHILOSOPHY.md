# Preservation philosophy and project principles

This project uses **preservation, containment, focus, restoration and minimalism** as practical engineering principles.

The objective is to adapt the game reliably to the target platform while preserving its identity and documenting the decisions well enough to support future work.

## Preservation

The original game remains the reference for presentation, art, music, sound effects, interface behaviour, cadence and controls.

A technically possible change is not automatically an improvement. Port-specific changes are evaluated by whether they solve a demonstrated platform problem without altering the intended experience unnecessarily.

## Containment

Changes are kept within the smallest practical boundary that addresses the problem being investigated.

This helps to:

- reduce regression risk;
- make comparisons clearer;
- keep upstream differences understandable;
- preserve the purpose of each change;
- simplify future maintenance.

A build issue should remain a build issue unless evidence shows that a broader architectural change is required. The same principle applies to timing, audio and lifecycle work.

## Focus

Research and stable scope are kept distinct.

Remastering, alternate rendering paths, wider device support and other experiments may remain useful without becoming requirements for the stable line.

This allows the project to reach a coherent baseline while preserving future research separately.

## Restoration

The preferred approach is to restore intended behaviour under the new technical environment rather than replace it with a different interpretation.

Examples include:

- retaining the original logical cadence while adapting presentation to the RG34XX-H display;
- retaining original assets instead of introducing replacement graphics;
- retaining the original control identity while reserving device-specific combinations for port functions;
- adapting build, audio, timing and lifecycle behaviour to H700/muOS without changing the game’s core presentation.

## Minimalism

Minimalism applies to the technical intervention, not to the quality of documentation.

A small change can still require clear evidence, measurements, alternatives and limitations. Detailed documentation makes small improvements easier to understand, reproduce and reuse.

## Incremental improvement

The project favours small, measurable improvements that can be evaluated independently.

Work on pacing, build reliability, exit behaviour, audio margin, benchmark validity and runtime integration is treated as a sequence of contained improvements rather than a single broad redesign.

This approach makes it easier to identify which change produced a result and to retain only the work that contributes to the stable objective.

## Project priorities

Priorities are set by the preservation objective, target-platform constraints and available evidence.

Feature count, technical novelty or newer technology are not goals by themselves. A change is adopted when it contributes clearly to the project’s purpose and can be supported by appropriate validation.

## Evidence and claims

Claims are kept proportional to the evidence available.

For example:

- a lower CPU ceiling is reported as a frequency change, not as equivalent battery savings;
- a high-refresh display does not imply that game logic runs at the panel refresh rate;
- an instrumentation counter is not treated as a direct measure of perceived audio defects;
- a binary hash identifies an artifact but does not establish reproducibility;
- validation on one device/CFW combination is not presented as universal compatibility.

Mixed and negative results remain part of the record when they help define the limits of a conclusion.

## Human direction and AI assistance

The project is human-directed and AI-assisted.

I define the project goals, preservation criteria, scope, target hardware, acceptance criteria and final decisions. Real-device observations and final quality judgments remain part of that responsibility.

ChatGPT assists with programming, calculations, automation, analysis, debugging and documentation. AI-assisted output is reviewed against the project requirements and evidence before adoption.

## Public documentation

The public repository is intended to provide both usable integration work and a clear technical record.

Where redistribution is restricted, the restriction applies to the affected content or binary. Safe engineering information — decisions, measurements, rejected experiments, validation limits and reusable lessons — remains documented where possible.
