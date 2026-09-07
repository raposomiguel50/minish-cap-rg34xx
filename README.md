# The Minish Cap - RG34XX

An unofficial RG34XX/H700 native-port integration of [Project Picori](https://github.com/EstebanPdN/zelda-tmc-3ds), developed and validated on the **ANBERNIC RG34XX-H** running **muOS**.

This project is part of **[Miguel's Game Dev Lab](https://raposomiguel50.github.io/)**, where ports are used to study platform constraints, improve practical compatibility and document reusable engineering knowledge.

The engineering approach is guided by **preservation, containment, focus, restoration, minimalism and curation**. The objective is not to redesign or expand the game, but to present the original creative work reliably on the target hardware while removing avoidable technical obstacles where the evidence supports doing so.

## Why the RG34XX-H

I chose the RG34XX-H primarily because its horizontal form and overall design closely recall the original Game Boy Advance. For me, it is the modern handheld that most closely evokes the GBA as a physical device.

That connection is important to this project. I grew up mainly with PCs and PC games; the Game Boy Advance was the first console I owned, given to me by my father. Using hardware that recalls the original GBA therefore supports the preservation objective at both a practical and personal level.

The technical characteristics reinforce that choice. The RG34XX-H display is **720x480**, allowing the GBA's original **240x160** image to scale exactly at **3x** without changing its aspect ratio. The H700 and muOS also provide a constrained ARM/Linux target that is useful for native-port engineering and optimisation.

## Why native execution

The project removes the GBA emulation layer. Instead of spending part of the system's resources reproducing the original console's CPU, graphics, audio and timing environment, the game runs as native AArch64 software within the RG34XX-H Linux/muOS environment.

This is not bare-metal execution, but it provides more direct control over build configuration, timing, presentation, audio, threading, input and lifecycle behaviour.

The additional margin is treated as a means, not an end. The priority is to use it to reduce avoidable technical compromises while preserving the same creative work. As a restoration premise, I ask what technical limitations could be removed if the same game had more optimisation time and more hardware margin available to express what is already present in the finished work. This is not a historical claim about undocumented developer intentions; the published game remains the primary evidence for the work being preserved.

Once fidelity and stability are satisfied, unused performance margin is not treated as something that must be spent. It can instead support lower clocks, lower resource demand and a larger stability reserve.

## Technical restoration and curation

The project treats preservation more like restoration of a painting than reproduction of every defect in its physical condition.

A painting conservator does not add new details or repaint the artist's work. At the same time, familiar degradation such as discoloured varnish does not become part of the original painting merely because viewers have become accustomed to it. The same distinction is applied here between the creative work and technical defects or limitations affecting its presentation.

Known technical bugs, crashes, save problems, avoidable slowdowns, stutter and other implementation defects may therefore be corrected when the correction preserves the game's content, mechanics, visual identity, sound, structure and deliberate cadence. If the evidence does not establish whether a behaviour is a technical defect or a creative decision, the default is to preserve it.

Observable divergences from the original behaviour are documented so that restoration and historical reference remain distinguishable.

Curation is equally important. The project provides a deliberately selected reference configuration rather than requiring the player to assemble the intended experience from many small settings.

For the preservation reference:

- the original **240x160** image is presented at exact **3x integer scale** to **720x480**;
- smoothing, shaders and presentation overlays that alter the original image are not part of the default presentation;
- Project Picori's menu functions remain accessible through shortcuts, while its instructional overlays are disabled by default so they do not cover the game image;
- the original GBA control identity remains reserved for the game, while port functions use device-specific combinations that do not replace the original controls;
- inherited Project Picori options may remain accessible, but changing them can move the configuration outside the project's validated preservation reference.

The project does not add new creative content, mechanics or presentation effects as part of restoration.

## Start here

- **[Project philosophy](docs/PHILOSOPHY.md)** — preservation, restoration and curation principles.
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
- game cadence and deliberate timing;
- mechanics, structure and progression;
- GBA control identity.

Port-specific work is limited to reliable platform integration, technical restoration and validated efficiency work. New creative content or reinterpretation is outside the preservation scope.

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

### Retained runtime configuration and efficiency intent

Later retained evidence includes:

- CPU ceiling **936 MHz**;
- GPU **420 MHz**;
- audio **1600**;
- `TMC_RENDER_THREADS=3`.

The reduced clock configuration reflects the project's priority order: first satisfy fidelity and stability, then avoid using more hardware resources than the validated experience requires. The underclock was adopted with the objective of reducing unnecessary power and thermal demand while retaining the accepted experience.

The CPU ceiling reduction from 1416 MHz to 936 MHz is reported as a frequency change only. No proportional battery-life, power-consumption or temperature reduction is inferred from that percentage without direct measurements.

### Rejected technical experiments

An experimental GPU-renderer path failed and was not promoted. A fullscreen-clear experiment was also not adopted. These results remain documented because they help define the tested boundaries of the project; they are engineering experiments, not an alternative creative direction for the game.

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
