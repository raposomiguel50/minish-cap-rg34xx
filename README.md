# The Minish Cap — RG34XX

An unofficial native port of *The Minish Cap* for the **ANBERNIC RG34XX** handheld, running **muOS**.

A port adapts a game's software to another device. This project builds on EstebanPdN's Project Picori-derived work.

**Available here:** integration patches, a launcher, test records and development guides. **There is no public game download.** See [distribution status](docs/PORTMASTER_STATUS.md).

## Start with your question

| I want to… | Read |
| --- | --- |
| Understand the choices | [Why this approach](docs/PHILOSOPHY.md) |
| Learn from the work | [Practical lessons](docs/KNOWLEDGE_BASE.md) |
| Check the results | [Tests and results](docs/VALIDATION.md) |
| Study or rebuild the port | [Reconstruction guide](docs/REPRODUCTION.md) |

New to the terminology? Use the [short glossary](docs/GLOSSARY.md).

## Why this handheld?

I grew up with PC games. My father gave me my first console, a Game Boy Advance. I chose the RG34XX for its close physical resemblance to that handheld.

Its 720 × 480 screen also fits the game's 240 × 160 image at exactly 3× scale. Each original pixel becomes a 3 × 3 block, without stretching the image (ANBERNIC, n.d.).

Archived project records call the device **RG34XX-H**. This documentation uses the product name **RG34XX**.

## The handheld reference

**Presentation.** The reference uses the original image at 3× integer scale. Port instructions stay off the game image; settings remain available through `MENU+R2`.

**Controls.** GBA buttons remain assigned to gameplay. `MENU+R2` opens port settings and `MENU+L2` exits to muOS.

**Presentation timing.** P11.4 changes when the port presents frames. Two archived captures show lower p95 tick lateness, but some delays remain.

**Runtime settings.** The accepted record uses CPU/GPU ceilings of 936/420 MHz and three rendering threads. These settings do not establish battery savings.

## For developers

The build changes target the H700. The shutdown path propagates quit requests through the game loop and closes subsystems before terminating the process.

The [patch map](docs/PATCH_SERIES.md) shows the code changes. The [results](docs/VALIDATION.md) explain the tests and their limits.

## What stays the same?

The aim is to preserve the game's creative work: its content, artwork, music, mechanics and control identity.

Restoration guides the technical changes. Curation brings the presentation, controls and runtime settings into one reference configuration.

[Read the preservation principles](docs/PHILOSOPHY.md).

## What does “native” mean here?

The game logic is built as ARM64 code for the target device. Linux, SDL and software models of GBA graphics/audio behaviour still provide supporting layers.

The integration controls its build, presentation timing, audio configuration and shutdown handling. [Tests and results](docs/VALIDATION.md) describes the measured configurations.

## What can I download?

The repository contains **15 historical patches**, a launcher and documentation. The patches are not one ready-to-apply build sequence.

The private V1 executable, ROM, extracted Nintendo assets and saves are not included. The recorded VirtuaAPU distribution restriction remains unresolved.

[What a rebuild still needs](docs/REPRODUCTION.md) · [Third-party notices](THIRD_PARTY_NOTICES.md)

## Foundation and credits

The pinned foundation is EstebanPdN's `zelda-tmc-3ds` fork. Its README credits the Android port, Project Picori and zeldaret (EstebanPdN, 2026).

Exact revisions and file identities are in [SOURCE_BASELINE.json](SOURCE_BASELINE.json).

I set the project goals and acceptance criteria. ChatGPT assists with code, analysis and documentation. [How the work is reviewed](docs/DEVELOPMENT_METHOD.md).

Original integration work uses the repository's [GPL-3.0-or-later terms](LICENSE). Upstream and third-party notices remain applicable.

## External references

ANBERNIC. (n.d.). *ANBERNIC RG 34XX*. Retrieved September 7, 2026, from https://anbernic.com/en-fr/products/rg34xx

EstebanPdN. (2026). *The Minish Cap 3DS* (Commit `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`) [Source code]. GitHub. https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5
