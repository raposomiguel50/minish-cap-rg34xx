# Preservation philosophy and project principles

This project is not only about making a game run on another device. It is an exercise in **preservation, containment, focus, restoration and minimalism** as practical engineering principles.

The objective is to make small, justified and verifiable improvements while preserving the identity of the original work and keeping the technical result understandable enough that other people can learn from it.

## Preservation before novelty

The first question is not "what can be added?" but **"what should remain unchanged?"**

For this project, the original game presentation, art, music, sound effects, interface logic and control identity remain the reference. Port-specific work should disappear into the background as much as possible.

A technically possible change is not automatically an improvement. New rendering effects, replacement artwork, aggressive reinterpretation, unnecessary abstraction or feature expansion can all make a port less faithful even when they make it more visibly "modern".

Preservation therefore acts as a design constraint, not as nostalgia. It gives the engineering work a stable reference point.

## Containment

Changes should stay inside the smallest boundary that solves the demonstrated problem.

If the problem is build completeness, fix build completeness. If the problem is timing, measure timing. If the problem is audio cost, isolate the audio variable. Do not turn every local defect into a reason to redesign the whole program.

Containment has several benefits:

- regressions are easier to identify;
- results are easier to compare;
- rejected experiments remain understandable;
- upstream differences remain smaller;
- future maintainers can see why each intervention exists.

This is especially important in AI-assisted work, where an assistant can otherwise generate more change than the problem requires.

## Focus

A project becomes weaker when every interesting possibility is promoted into required scope.

Research into remastering, alternate rendering paths, broader device support or future expansion can remain useful without becoming part of the stable baseline.

The stable line is allowed to say **"this is enough"** when it satisfies the actual purpose of the project.

Focus is therefore a completion tool. It prevents optional experiments from blocking a coherent and usable result.

## Restoration rather than replacement

The preferred intervention is usually the one that restores the intended behaviour under a new technical environment rather than replacing that behaviour with a new interpretation.

Examples include:

- preserving the original logical game cadence while adapting presentation to a high-refresh display;
- preserving original assets instead of introducing replacement graphics;
- preserving the original interaction model while using device-specific controls only for port functions;
- preserving the game's own identity while adapting build, audio, timing and lifecycle behaviour to H700/muOS.

The port should make the original experience practical on the target hardware without asking the player to notice the port itself.

## Minimalism is not minimal documentation

Minimalism applies to **intervention**, not to knowledge.

A small change can require a detailed explanation. In fact, small changes are more reusable when the reason behind them is documented clearly.

The public project should therefore preserve:

- the problem that was observed;
- the hypothesis that was tested;
- alternatives considered;
- measurements and test conditions;
- failures and rejected experiments;
- the final decision;
- the limits of the evidence;
- the reusable lesson.

Publishing only a finished patch would preserve the result but lose much of the value of the work.

## Incremental innovation

This philosophy is not anti-innovation. It favours **incremental innovation that earns its place**.

A small improvement in pacing, build reliability, exit behaviour, audio margin, benchmark validity or runtime integration can become a dependable building block for later work.

Several small, evidence-backed improvements can create a stronger foundation than one large redesign whose benefits are difficult to isolate.

The aim is not novelty for its own sake. The aim is to make each improvement understandable, testable and useful beyond this specific project.

## Independence from trends and hype

Project priorities are not set by current trends, marketing language, hardware-fashion cycles, consumer pressure or the assumption that "more" is inherently better.

Higher clocks, more visual effects, larger feature sets, more abstraction or newer technology are not automatically goals.

A change must be justified by the project purpose, the target hardware and the available evidence.

This makes the project deliberately conservative in some areas and experimental in others. The distinction is made by need, not by fashion.

## Evidence before claims

A build exit code, a benchmark number or an assistant's confidence is not enough on its own.

Claims should remain proportional to evidence.

For example:

- a lower CPU ceiling is not automatically equal to proportional battery savings;
- a 120 Hz panel does not mean the game logic runs at 120 FPS;
- a heuristic underrun counter is not the same as an audible defect count;
- a retained binary hash identifies an artifact but does not prove bit-for-bit reproducibility;
- a successful local experiment is not the same as a published production result.

Negative or mixed results are kept because they prevent later overclaiming.

## Human judgment and AI assistance

This project is human-directed and AI-assisted.

ChatGPT can accelerate programming, calculations, automation, comparison, debugging and documentation. It can also be wrong, overcomplicate a task, repeat a rejected idea or infer a goal that was never approved.

Human judgment therefore remains part of the engineering method rather than a final cosmetic review step.

The project owner defines what should be preserved, what counts as enough, what evidence is acceptable and when an experiment should be rejected.

## Teach the method, not only deliver the result

The public goal is twofold:

1. provide the useful result;
2. make the path understandable enough that another person can reuse the reasoning.

In practical terms: **deliver the fish and explain how it was caught**.

The repository is therefore intended to function as both an integration project and a learning resource. Someone working on another constrained ARM device should be able to reuse lessons about source selection, build completeness, timing, audio, benchmark validity, scope control, evidence and publication boundaries even if they never use this exact port.
