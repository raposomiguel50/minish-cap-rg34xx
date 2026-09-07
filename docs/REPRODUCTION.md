# Reconstruction and reproducibility status

## What is available

The repository provides the [upstream pin](../SOURCE_BASELINE.json), [15 historical patches](PATCH_SERIES.md), a [launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh) and [selected archived evidence](evidence/2026-09-07/README.md). The pinned foundation is EstebanPdN's `zelda-tmc-3ds` at `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`, derived from work credited in that upstream README (EstebanPdN, 2026).

The private executable is identified in the [archived acceptance](evidence/2026-09-07/final_acceptance.json) as SHA-256 `787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`, with size 8,858,736 bytes in the [winner record](evidence/2026-09-07/runtime_winner.json). Neither its bytes nor proprietary game assets are part of this evidence publication.

## Three separate claims

**Traceability:** a named patch, launcher setting or archived observation can be inspected. The new evidence extract includes original member hashes, machine summaries and selected diagnostic lines.

**Functional reconstruction:** a new build from a specified complete source/dependency environment passes target validation. This audit did not perform that build.

**Bit-for-bit reproduction:** the documented environment regenerates the private executable's exact bytes. This is not established by a binary hash, four retained source snapshots or the patch directory. See [source baseline](../SOURCE_BASELINE.json), [patch map](PATCH_SERIES.md) and [validation limits](VALIDATION.md).

## Numerical reanalysis

The read-only [reanalyse.py](evidence/2026-09-07/reanalyse.py) recalculates timing and selected monitor statistics from the owner-held archive. It creates a new output directory, does not launch the game and does not execute scripts stored in the archive. The public evidence subset contains selected summaries and the calculation method, not the complete raw traces. Public numerical reproducibility from this repository alone is consequently limited. Original member paths and hashes are recorded in [reanalysis.json](evidence/2026-09-07/reanalysis.json).

## Before claiming a new runnable release

A reconstruction needs a complete pinned source/dependency/toolchain list, a resolved redistribution path, reviewed non-overlapping patch order, build logs, output hashes and a fresh target test. The public historical patch map is not a substitute for that process. The privately recorded VirtuaAPU boundary is unchanged; see [LEGAL_STATUS.md](LEGAL_STATUS.md) and [THIRD_PARTY_NOTICES.md](../THIRD_PARTY_NOTICES.md).

No reconstruction command is presented here as already validated. Do not overwrite the private V1, original project tree, saves or prior evidence while attempting a new build.

## External reference

EstebanPdN. (2026). *The Minish Cap 3DS* (Commit `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`) [Source code]. GitHub. https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5
