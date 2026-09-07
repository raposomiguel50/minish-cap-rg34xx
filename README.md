# The Minish Cap — RG34XX

An unofficial H700/Linux integration of EstebanPdN's Project Picori-derived Minish Cap port. The pinned source is `zelda-tmc-3ds` at `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`; its README credits the Android port, Project Picori and the zeldaret decompilation (EstebanPdN, 2026; Raposo, 2026d).

## What this repository documents

The public material contains 15 integration patches and a launcher. The patches address AArch64 build/link configuration, handheld controls and menu hints, quit propagation, a post-shutdown exit workaround, audio configuration and timing instrumentation/policy. They are historical stages, **not** one validated linear patch series (Raposo, 2026b, 2026c).

The recorded target is the RG34XX with muOS. Historical project records use the label **RG34XX-H**; ANBERNIC markets the GBA-style device as **RG34XX**. Its 720 × 480 display accommodates the game's 240 × 160 image at integer scale 3× (ANBERNIC, n.d.; Raposo, 2026a).

## Why this project

I grew up with PC games. My father gave me my first console, a Game Boy Advance. I chose the RG34XX for its close physical resemblance to that handheld.

**Project principles:** preserve the existing creative work, make justified technical interventions and provide a curated reference configuration. The premise of additional optimisation time and hardware margin concerns execution of the same work, not new content or an imagined expanded edition. These are decision criteria; they are not claims that every possible defect has been corrected. See [Philosophy](docs/PHILOSOPHY.md).

## Implemented changes and recorded results

| Area | Specific evidence | Limit |
| --- | --- | --- |
| Build | Source inclusion/link changes; `fmt` header order; ARMv8-A/SIMD and Cortex-A53 tuning flags | Build changes are not gameplay-bug fixes |
| Exit | Quit requests propagate through loops; `_Exit(0)` follows explicit shutdown in the target profile; a later session logs exit code 0 | Exact failing finalizer not identified |
| Controls/UI | MENU+R2 settings; MENU+L2 exit; suppression of the legacy `L Settings` hint | Settings remain accessible |
| Timing | Historical p95 tick lateness: 5.790787 → 0.027887 ms, from 10,203 and 10,449 ticks | One capture per variant; maxima and unmatched conditions matter |
| Runtime | Accepted record: CPU ceiling 936 MHz, GPU ceiling 420 MHz, audio 1,600 frames, three render threads | Not measured energy savings |

Sources: patches/launcher and archived records (Raposo, 2026a, 2026b, 2026c). The full [evidence audit](docs/EVIDENCE_AUDIT.md) includes measurement definitions, adverse results and traceability.

The audio record is mixed: the earlier 1,600-frame machine test was labelled `AUDIO1600_MACHINE_AUDIO_REGRESSION`; the later operator acceptance records audio `OK`. No correction of an **original GBA gameplay bug/glitch** is established by the reviewed material. A policy permitting such corrections must not be read as a completed result (Raposo, 2026a).

## Native execution and efficiency

The game logic is built for the host platform. The port still uses Linux, SDL integration and software models of GBA presentation/audio behaviour; it is not bare-metal execution or removal of every emulated subsystem. No native-versus-emulator benchmark is claimed. Lower clock limits were selected to reduce unnecessary resource demand, but the archived records do not establish measured battery-life or thermal savings (Raposo, 2026a, 2026b, 2026c).

## Reading order

[Evidence audit](docs/EVIDENCE_AUDIT.md) · [Validation](docs/VALIDATION.md) · [Patch map](docs/PATCH_SERIES.md) · [Knowledge base](docs/KNOWLEDGE_BASE.md) · [Reconstruction](docs/REPRODUCTION.md) · [Philosophy](docs/PHILOSOPHY.md) · [Development method](docs/DEVELOPMENT_METHOD.md)

## Private V1 and public boundaries

The archived acceptance record identifies private V1 by SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

That hash is an identity reference, not proof of a bit-for-bit reproducible build. The public tree does not contain the game ROM, extracted Nintendo assets, saves or the V1 executable. It is a source-side integration and evidence publication, not a downloadable game release (Raposo, 2026a, 2026d).

The recorded VirtuaAPU licensing boundary remains unresolved for binary distribution. See [Third-party notices](THIRD_PARTY_NOTICES.md), [Legal status](docs/LEGAL_STATUS.md), [Provenance](docs/PROVENANCE.md) and [PortMaster status](docs/PORTMASTER_STATUS.md). This editorial audit does not change licences or publish a binary.

## Authorship and assistance

I define the scope, preservation criteria and acceptance decisions. ChatGPT assists with code, analysis and documentation; its output is not evidence of successful execution. The audit distinguishes archived device observations from the analysis performed on those records.

Original integration work is published under the repository's GPL-3.0-or-later terms; upstream components retain their own notices. See [LICENSE](LICENSE), [COPYING.txt](COPYING.txt) and [THIRD_PARTY_NOTICES.md](THIRD_PARTY_NOTICES.md).

## References

ANBERNIC. (n.d.). *ANBERNIC RG 34XX*. Retrieved September 7, 2026, from https://anbernic.com/en-fr/products/rg34xx

EstebanPdN. (2026). *The Minish Cap 3DS* (Commit `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`) [Source code]. GitHub. https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5

Raposo, M. (2026a). *Archived development records for The Minish Cap—RG34XX (27 August–5 September 2026)* (Evidence extract 1.0) [Data set]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/ede6e9090e7ca78c6c3a8c3d324d8c1de881f8b3/docs/evidence/2026-09-07

Raposo, M. (2026b). *H700 integration patches for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/90fd77a82d579de9460f2de1167a95ec264e57c3/patches

Raposo, M. (2026c). *Reference launcher for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh

Raposo, M. (2026d). *Source baseline for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Project metadata]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/SOURCE_BASELINE.json
