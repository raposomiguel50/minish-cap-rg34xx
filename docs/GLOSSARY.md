# Terms used in this project

Use this page when a technical word interrupts the explanation.

## Software and files

**Port:** an adaptation of existing game software for another platform.

**Upstream:** the earlier project on which this integration builds. Here, the pinned source is EstebanPdN's Project Picori-derived fork.

**Patch:** a file describing changes to source code. Historical patches may overlap; they are not automatically an installation recipe.

**Build:** the process of turning source code into an executable program.

**Launcher:** the script that sets up the runtime and starts the game.

**Commit:** a recorded revision in Git. A full commit identifier locates a specific source version.

**SHA-256:** a file fingerprint. Matching fingerprints establish matching file contents, not proof that the game works correctly.

## Hardware and execution

**H700:** the chip targeted by this integration. The RG34XX is the recorded handheld target.

**AArch64 / ARM64:** the 64-bit Arm execution target used for the port's game logic.

**muOS:** the operating-system environment used in the recorded handheld tests.

**SDL:** a software layer used by the port for platform integration. Native game logic still relies on supporting software.

**Underclock / clock ceiling:** a lower operating-frequency limit. The recorded CPU/GPU ceilings are 936/420 MHz; they are not energy measurements.

**Governor:** the system policy controlling CPU frequency. It is different from the maximum-frequency limit.

## Timing and audio

**Tick:** one game-logic update. The recorded reference cadence is about 59.7275 updates per second.

**Presentation call:** a software call that submits an image for display. Its duration is not the time from pressing a button to seeing a response.

**Refresh rate:** how often the screen refreshes. A 119.455 Hz panel does not make the game logic run at that rate.

**p95:** the 95th percentile. About 95% of recorded values are at or below it. Larger values still exist; p95 is not the maximum.

**Callback:** a function invoked to perform work, such as supplying audio. A callback gap measures elapsed time between such calls.

**Audio buffer:** a block of audio samples. The requested size may differ from a printed message or the size actually negotiated with the device.

**Resampling:** converting audio between sample rates. The reviewed patch changes one resampling branch, not every audio mode.

## Reading test results

**Capture:** one recorded sequence of observations. Thousands of ticks within it are not thousands of independent test runs.

**Soak test:** an automated run used to observe behaviour over time. It is not a human playthrough.

**RSS:** resident set size, a measure of process memory held in RAM.

**Workaround:** an intervention that avoids a failure without necessarily identifying or repairing its underlying cause.

These definitions describe usage in this documentation. Exact measures and source paths are in the [detailed report](EVIDENCE_AUDIT.md).

**Next:** [Return to the learning guide](KNOWLEDGE_BASE.md).
