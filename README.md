# The Minish Cap - RG34XX

An unofficial RG34XX/H700 native-port integration of
[Project Picori](https://github.com/EstebanPdN/zelda-tmc-3ds), developed with the **ANBERNIC RG34XX-H**
running **muOS** as the validated reference device.

This project is part of **[Miguel's Game Dev Lab](https://raposomiguel50.github.io/)**.

It is not published only to deliver a port. It is also a public engineering record about how **preservation, containment, focus, restoration and minimalism** can guide small incremental changes into a stable result — and how the reasoning, failures and evidence can remain useful to somebody working on a different constrained device later.

The working principle is simple:

> **Keep the intervention small; keep the knowledge visible.**

The public goal is to provide both the result and the method: deliver the fish and explain how it was caught.

## Start here

If you are here to understand the work rather than only browse patches, use this path:

1. **[Project philosophy](docs/PHILOSOPHY.md)** — why preservation, containment, focus, restoration and minimalism matter here.
2. **[Engineering knowledge base](docs/KNOWLEDGE_BASE.md)** — problems, failures, decisions, validation and reusable lessons.
3. **[Patch history](docs/PATCH_SERIES.md)** — which patches are foundations, instrumentation, A/B experiments or accepted directions.
4. **[Validation](docs/VALIDATION.md)** — what was actually measured/observed and what must not be overclaimed.
5. **[Reconstruction and reproducibility](docs/REPRODUCTION.md)** — what can be reconstructed today and why this repository does not claim bit-for-bit reproduction of the retained V1.
6. **[Development method and AI assistance](docs/DEVELOPMENT_METHOD.md)** — human direction, AI assistance, evidence, handovers and failure handling.

This structure intentionally keeps failed and superseded work visible when it teaches something useful.

## Project identity

The port aims to make the original experience practical on the target hardware **without turning the port itself into the main attraction**.

The original game remains authoritative for:

- art and visual identity;
- music and sound effects;
- interface logic;
- game cadence;
- GBA control identity.

The preferred intervention is restoration/adaptation at the platform boundary rather than replacement of the experience.

This means the project does not chase features because they are fashionable, marketable or technically possible. Higher refresh rates, higher clocks, new rendering paths or remastered presentation are only useful when they solve a demonstrated problem without violating the preservation goal.

See [docs/PHILOSOPHY.md](docs/PHILOSOPHY.md).

## Publication status

This repository is deliberately a **source / patch / launcher / knowledge publication**.

It does not distribute a public game executable.

- **Upstream Project Picori revision:** `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`
- **Private validated V1 SHA-256:** `787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`
- **Commercial/proprietary game data included:** **No**
- **Public V1 binary included:** **No**

The private RG34XX-H V1 is retained separately for personal use and engineering evidence.

The public repository excludes:

- Game Boy Advance ROMs;
- extracted Nintendo game assets;
- save files and runtime state;
- private device backups;
- private development builds;
- the validated V1 executable;
- VirtuaAPU source.

The validated private executable used VirtuaAPU. At the audited revision, VirtuaAPU did not contain an explicit published licence file, so neither that component nor the executable incorporating it is redistributed here.

This is a redistribution boundary, not a reason to hide safe engineering knowledge.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and [docs/LEGAL_STATUS.md](docs/LEGAL_STATUS.md).

## Validated reference target

- Device: **ANBERNIC RG34XX-H**
- SoC: **Allwinner H700**
- CPU class: **Cortex-A53**
- Architecture: **AArch64**
- CFW: **muOS**
- Display: **720x480**

This is the validated reference configuration.

Other H700 devices or other custom firmware may work, but are not presented as validated unless independently tested.

## Selected engineering decisions

The public record includes the reasoning behind decisions such as:

### Preserve original cadence on a high-refresh display

The accepted direction separates logical cadence, explicit presentation calls and physical display refresh.

Recorded reference values:

- game logic around **59.7275 Hz**;
- panel around **119.455 Hz**;
- **one explicit presentation per logical tick** in the accepted high-refresh direction.

A recorded comparison reduced tick-lateness p95 from approximately **5.791 ms** to **0.028 ms** under the tested conditions.

This is not described as “120 FPS gameplay”. The innovation is in presentation/timing behaviour while retaining the original logical cadence.

### Validate benchmark context before optimising

Early AutoLab measurements taken through direct SSH were rejected because frontend/background state did not represent a normal Ports launch.

Later comparisons used a normal Ports-session context, deterministic replay and CPU/GPU restoration between variants.

The reusable lesson is broader than this port: **prove that the benchmark represents the user context before trusting the number.**

### Keep mixed results

Later retained runtime evidence includes:

- CPU ceiling **936 MHz**;
- GPU **420 MHz**;
- audio **1600**;
- `TMC_RENDER_THREADS=3`.

Reducing the CPU ceiling from 1416 MHz to 936 MHz is roughly a 33.9% frequency reduction. It is **not** presented as 33.9% battery savings.

Less favourable observations — such as a higher maximum temperature in one comparison and slightly higher RSS — remain part of the record.

### Reject experiments that do not earn their place

An experimental GPU-renderer path failed and was not promoted. A fullscreen-clear experiment was also not adopted.

A failed experiment is useful when it prevents a later maintainer from repeating the same plausible idea without new evidence.

More examples are documented in [docs/KNOWLEDGE_BASE.md](docs/KNOWLEDGE_BASE.md).

## Verified private V1 identity

The retained private V1 executable is identified by:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

The hash is published as engineering evidence only. The binary itself is not included.

The exact isolated P13.1 build worktree was not retained, so this repository does **not** claim byte-for-byte reproducibility of that private executable.

Four later P13.1 source snapshots were preserved and hash-verified in the private engineering record, which improves historical recoverability but does not automatically constitute a complete final build tree.

See [docs/REPRODUCTION.md](docs/REPRODUCTION.md), [docs/PROVENANCE.md](docs/PROVENANCE.md) and [SOURCE_BASELINE.json](SOURCE_BASELINE.json).

## Upstream

Principal upstream foundation:

https://github.com/EstebanPdN/zelda-tmc-3ds

Reference revision:

`e72663ca4059dabf9dbf7f03c36fc791d90b8db5`

The complete upstream source tree is not vendored in this repository.

Upstream selection is itself part of the engineering record: a useful base must have a dependency/provenance boundary that can actually be audited and maintained.

## Repository contents

- `patches/` — RG34XX/H700 development, integration, instrumentation and historical experiment patches.
- `launcher/` — retained launcher/runtime integration work cleared for publication.
- `config/` — upstream pins and reference hashes.
- `docs/PHILOSOPHY.md` — preservation and project principles.
- `docs/KNOWLEDGE_BASE.md` — reusable engineering lessons and failures.
- `docs/PATCH_SERIES.md` — patch classification and intended reading order.
- `docs/VALIDATION.md` — evidence and claim boundaries.
- `docs/REPRODUCTION.md` — reconstruction/reproducibility status.
- `docs/DEVELOPMENT_METHOD.md` — human-directed, AI-assisted workflow.
- `docs/PROVENANCE.md` / `docs/LEGAL_STATUS.md` — source and redistribution boundaries.
- `SOURCE_BASELINE.json` — machine-readable source/provenance baseline.

Historical patches are deliberately preserved. They must not be interpreted as one linear patch series to apply blindly.

## PortMaster status

There is currently **no PortMaster release** from this repository.

A PortMaster submission remains separate work because:

1. binary redistribution must first have a clean licensing path;
2. PortMaster requires appropriate licence coverage for bundled components;
3. the validated configuration currently centres on RG34XX-H/H700 + muOS;
4. broader CFW/device testing is required before claiming general PortMaster compatibility.

See [docs/PORTMASTER_STATUS.md](docs/PORTMASTER_STATUS.md).

The PortMaster blocker does **not** block publication of safe technical knowledge, project philosophy or source-side lessons.

## Development attribution and AI assistance

This project is **human-directed and AI-assisted**.

I define the goals, preservation philosophy, target hardware, process, constraints, critical decisions, acceptance criteria and final approval. Physical-device testing and final hardware interpretation remain under my control.

ChatGPT provides substantial assistance with calculations, programming, automation, debugging support, technical analysis, documentation, reproducibility work and repetitive repository operations.

AI output is not accepted automatically. It can be rejected for technical reasons, evidence quality, unnecessary complexity or conflict with the intended preservation/design direction.

The workflow itself records useful AI failures because context loss, overengineering and plausible-but-wrong assumptions are engineering risks that other people may also encounter.

See [docs/DEVELOPMENT_METHOD.md](docs/DEVELOPMENT_METHOD.md) and the [Miguel's Game Dev Lab development method](https://raposomiguel50.github.io/method/).

## Licence

Original integration work in this repository is distributed under the GNU General Public License v3.0 or later, consistent with the audited Project Picori upstream licence.

See:

- [LICENSE](LICENSE)
- [COPYING.txt](COPYING.txt)
- [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)

Upstream and third-party components retain their respective copyright and licensing terms.

No Nintendo proprietary game data is distributed by this repository.
