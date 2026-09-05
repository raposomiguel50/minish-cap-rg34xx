# The Minish Cap - RG34XX

An unofficial RG34XX/H700 native-port integration of
[Project Picori](https://github.com/EstebanPdN/zelda-tmc-3ds), developed with the **ANBERNIC RG34XX-H**
running **muOS** as the validated reference device.

This project is part of **[Miguel's Game Dev Lab](https://raposomiguel50.github.io/)**:
learning hardware through practical ports, documenting the engineering work,
and applying those lessons to native development.

This repository is deliberately a **source / patch / launcher publication**.
It does not distribute a public game executable.

- **Upstream Project Picori revision:** `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`
- **Private validated V1 SHA-256:** `787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`
- **Commercial/proprietary game data included:** **No**
- **Public V1 binary included:** **No**

## Publication status

The private RG34XX-H V1 has been retained for continued personal use and
engineering evidence.

The public repository intentionally excludes:

- Game Boy Advance ROMs;
- extracted Nintendo game assets;
- save files and runtime state;
- private device backups;
- private development builds;
- the validated V1 executable;
- VirtuaAPU source.

The validated private executable used VirtuaAPU. At the audited revision,
VirtuaAPU did not contain an explicit published licence file, so neither that
component nor the executable incorporating it is redistributed here.

See [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md) and
[docs/LEGAL_STATUS.md](docs/LEGAL_STATUS.md).

## Validated reference target

- Device: **ANBERNIC RG34XX-H**
- SoC: **Allwinner H700**
- Architecture: **AArch64**
- CFW: **muOS**

This is the validated reference configuration.

Other H700 devices or other custom firmware may work, but are not presented as
validated unless they are independently tested.

## Verified private V1 identity

The retained private V1 executable is identified by:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

The hash is published as engineering evidence only. The binary itself is not
included.

The exact isolated P13.1 build worktree was not retained, so this repository
does **not** claim byte-for-byte reproducibility of that private executable.

See [docs/PROVENANCE.md](docs/PROVENANCE.md) and
[SOURCE_BASELINE.json](SOURCE_BASELINE.json).

## Upstream

The principal upstream foundation is Project Picori:

https://github.com/EstebanPdN/zelda-tmc-3ds

Reference revision:

`e72663ca4059dabf9dbf7f03c36fc791d90b8db5`

The complete upstream source tree is not vendored in this repository.

## Repository contents

- `patches/` — RG34XX/H700 development and integration patches.
- `launcher/` — retained launcher/runtime integration work cleared for publication.
- `config/` — upstream pins and reference hashes.
- `docs/` — provenance, legal status, PortMaster status and development method.
- `SOURCE_BASELINE.json` — machine-readable source/provenance baseline.

Historical patches record experiments as well as accepted work. They must not
be interpreted as one linear patch series to apply blindly.

## PortMaster status

There is currently **no PortMaster release** from this repository.

A PortMaster submission remains separate work because:

1. binary redistribution must first have a clean licensing path;
2. PortMaster requires appropriate licence coverage for bundled components;
3. the validated configuration currently centres on RG34XX-H/H700 + muOS;
4. broader CFW/device testing is required before claiming general PortMaster
   compatibility.

See [docs/PORTMASTER_STATUS.md](docs/PORTMASTER_STATUS.md).

## Development attribution and AI assistance

This project is **human-directed and AI-assisted**.

I define the goals, target hardware, process, constraints, critical decisions,
acceptance criteria and final approval. Physical-device testing and final
hardware interpretation remain under my control.

ChatGPT provides substantial assistance with calculations, programming,
automation, debugging support, technical analysis, documentation,
reproducibility work and repetitive repository operations.

AI output is reviewed against the intended design and available evidence rather
than accepted automatically.

See [docs/DEVELOPMENT_METHOD.md](docs/DEVELOPMENT_METHOD.md) and the
[Miguel's Game Dev Lab development method](https://raposomiguel50.github.io/method/).

## Licence

Original integration work in this repository is distributed under the GNU
General Public License v3.0 or later, consistent with the audited Project Picori
upstream licence.

See:

- [LICENSE](LICENSE)
- [COPYING.txt](COPYING.txt)
- [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md)

Upstream and third-party components retain their respective copyright and
licensing terms.

No Nintendo proprietary game data is distributed by this repository.
