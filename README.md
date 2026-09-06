# The Minish Cap - RG34XX

An unofficial RG34XX/H700 native-port integration of [Project Picori](https://github.com/EstebanPdN/zelda-tmc-3ds), developed and validated on the **ANBERNIC RG34XX-H** running **muOS**.

This project is part of **[Miguel's Game Dev Lab](https://raposomiguel50.github.io/)**, where ports are used to study platform constraints, improve practical compatibility and document reusable engineering knowledge.

The engineering approach is guided by five principles: **preservation, containment, focus, restoration and minimalism**. The aim is to preserve the original experience while making targeted, evidence-based adaptations for the H700 platform.

## Why the RG34XX-H

I chose the RG34XX-H primarily because its horizontal form and overall design closely recall the original Game Boy Advance. For me, it is the modern handheld that most closely evokes the GBA as a physical device.

That connection is important to this project. I grew up mainly with PCs and PC games; the Game Boy Advance was the first console I owned, given to me by my father. Using hardware that recalls the original GBA therefore supports the preservation objective at both a practical and personal level.

The technical characteristics reinforce that choice. The RG34XX-H display is **720x480**, allowing the GBA's original **240x160** image to scale exactly at **3x** without changing its aspect ratio. The H700 and muOS also provide a constrained ARM/Linux target that is useful for native-port engineering and optimisation.

## Why native execution

The project also removes the GBA emulation layer. Instead of spending part of the system's resources reproducing the original console's CPU, graphics, audio and timing environment, the game runs as native AArch64 software within the RG34XX-H Linux/muOS environment.

This is not bare-metal execution, but it provides substantially more control over the software/hardware boundary: build configuration, timing, presentation, audio, threading, input and lifecycle behaviour can be adapted directly to the target platform.

That additional hardware margin also makes it possible to imagine and explore what the original developers could have achieved with more optimisation time and more room in the hardware to express their vision and creativity. The native port therefore provides a practical way to study both the original constraints and the possibilities opened by removing them.

## Start here

- **[Project philosophy](docs/PHILOSOPHY.md)** — design and preservation principles.
- **[Engineering knowledge base](docs/KNOWLEDGE_BASE.md)** — findings, decisions and reusable lessons.
- **[Patch history](docs/PATCH_SERIES.md)** — purpose and status of the published patches.
- **[Validation](docs/VALIDATION.md)** — measurements, observations and evidence limits.
- **[Reconstruction and reproducibility](docs/REPRODUCTION.md)** — current reconstruction status and open requirements.
- **[Development method](docs/DEVELOPMENT_METHOD.md)** — workflow, validation and AI assistance.

## Project scope

The original game remains the reference for:

- art and visual identity;
- music and sound effects;
- interface behaviour;
- game cadence;
- GBA control identity.

Port-specific work is limited to the platform integration required for a reliable experience on the target device. Experimental rendering, remastering and broader feature work remain separate unless they demonstrate a clear benefit within that scope.

## Publication status

This repository publishes **source-side integration work, launcher material and engineering documentation**. It does not distribute a public game executable.

- **Upstream Project Picori revision:** `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`
- **Private validated V1 SHA-256:** `787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`
- **Commercial/proprietary game data included:** **No**
- **Public V1 binary included:** **No**

The public repository excludes GBA ROMs, extracted Nintendo assets, save data, private builds, device backups and the validated V1 executable.

The retained private V1 used VirtuaAPU. At the audited revision, VirtuaAPU did not provide an explicit published licence file, so neither that component nor the executable incorporating it is redistributed here.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [docs/LEGAL_STATUS.md](docs/LEGAL_STATUS.md).

## Validated reference target

- Device: **ANBERNIC RG34XX-H**
- SoC: **Allwinner H700**
- CPU class: **Cortex-A53**
- Architecture: **AArch64**
- CFW: **muOS**
- Display: **720x480**

Other H700 devices or custom firmware may be compatible, but they are not presented as validated without independent testing.

## Selected engineering findings

### High-refresh presentation

The accepted timing direction keeps game logic around **59.7275 Hz**, uses the panel around **119.455 Hz**, and performs **one explicit presentation per logical tick**.

In the recorded comparison, tick-lateness p95 improved from approximately **5.791 ms** to **0.028 ms** under the tested conditions.

This is a presentation/timing result; it is not described as 120 FPS game logic.

### Benchmark context

Early AutoLab measurements obtained through direct SSH were rejected because the surrounding frontend/background state did not represent a normal Ports launch.

Later comparisons used a normal Ports-session context, deterministic replay and CPU/GPU restoration between variants.

### Retained runtime configuration

Later retained evidence includes:

- CPU ceiling **936 MHz**;
- GPU **420 MHz**;
- audio **1600**;
- `TMC_RENDER_THREADS=3`.

The CPU ceiling reduction from 1416 MHz to 936 MHz is reported as a frequency change only. No proportional battery-life claim is made from that figure.

### Experimental work

An experimental GPU-renderer path failed and was not promoted. A fullscreen-clear experiment was also not adopted. These results remain documented because they help define the tested boundaries of the project.

More detail is available in [docs/KNOWLEDGE_BASE.md](docs/KNOWLEDGE_BASE.md).

## Private V1 identity and reconstruction status

The retained private V1 executable is identified by:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

The hash identifies the validated artifact; it does not establish bit-for-bit reproducibility.

Four P13.1 source snapshots were also preserved and hash-verified in the private engineering record. They improve historical traceability but are not presented as a complete final build tree.

See [docs/REPRODUCTION.md](docs/REPRODUCTION.md), [docs/PROVENANCE.md](docs/PROVENANCE.md) and [SOURCE_BASELINE.json](SOURCE_BASELINE.json).

## Upstream

Principal upstream foundation:

https://github.com/EstebanPdN/zelda-tmc-3ds

Reference revision:

`e72663ca4059dabf9dbf7f03c36fc791d90b8db5`

The complete upstream source tree is not vendored in this repository.

## Repository contents

- `patches/` — RG34XX/H700 integration, instrumentation and historical experiments.
- `launcher/` — launcher/runtime integration cleared for publication.
- `config/` — upstream pins and reference hashes.
- `docs/PHILOSOPHY.md` — project principles.
- `docs/KNOWLEDGE_BASE.md` — engineering findings and lessons.
- `docs/PATCH_SERIES.md` — patch classification and reading order.
- `docs/VALIDATION.md` — evidence and claim boundaries.
- `docs/REPRODUCTION.md` — reconstruction and reproducibility status.
- `docs/DEVELOPMENT_METHOD.md` — development workflow and AI assistance.
- `docs/PROVENANCE.md` / `docs/LEGAL_STATUS.md` — source and redistribution boundaries.
- `SOURCE_BASELINE.json` — machine-readable source/provenance baseline.

Historical patches are retained for reference and should not be treated as one linear patch series.

## PortMaster status

There is currently **no PortMaster release** from this repository.

A future submission requires:

1. a clear redistribution/licensing path for all bundled components;
2. appropriate licence coverage for the final package;
3. broader CFW/device validation beyond the current RG34XX-H + muOS reference;
4. final packaging aligned with PortMaster conventions.

See [docs/PORTMASTER_STATUS.md](docs/PORTMASTER_STATUS.md).

## Development attribution and AI assistance

This project is **human-directed and AI-assisted**.

I define the project goals, scope, target hardware, preservation criteria, acceptance criteria and final decisions. I also perform or evaluate the real-device validation used to accept changes.

ChatGPT assists with calculations, programming, automation, debugging, technical analysis, documentation and repetitive repository work. AI-assisted output is reviewed against the project requirements and available evidence before adoption.

See [docs/DEVELOPMENT_METHOD.md](docs/DEVELOPMENT_METHOD.md) and the [Miguel's Game Dev Lab development method](https://raposomiguel50.github.io/method/).

## Licence

Original integration work in this repository is distributed under the GNU General Public License v3.0 or later, consistent with the audited Project Picori upstream licence.

See:

- [LICENSE](LICENSE)
- [COPYING.txt](COPYING.txt)
- [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)

Upstream and third-party components retain their respective copyright and licensing terms.

No Nintendo proprietary game data is distributed by this repository.
