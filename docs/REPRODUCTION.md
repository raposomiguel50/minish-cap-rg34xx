# Can I rebuild the port?

**Not from a complete, validated recipe yet.** This repository provides useful starting material, but it does not reproduce the private V1 by itself.

Use this page to see what exists and what a new build still needs.

## What is available?

The public material includes the [upstream revision](../SOURCE_BASELINE.json), [15 historical patches](PATCH_SERIES.md), a [launcher](../launcher/The%20Minish%20Cap.sh) and [selected test records](evidence/2026-09-07/README.md).

The source foundation is [EstebanPdN's Project Picori-derived fork](https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5). Its pinned revision is `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`.

The private executable, ROM, extracted game assets and saves are not included.

## What do the three evidence levels mean?

**Traceable:** you can inspect the patch, setting or recorded observation.

**Rebuilt and working:** a new build passes checks on the target device. A validated public rebuild recipe is still needed.

**Bit-for-bit reproduced:** the rebuild creates exactly the same bytes as the reference executable. This has not been demonstrated.

A matching file fingerprint identifies bytes. It does not replace a build recipe or a gameplay test.

## What identifies private V1?

The [acceptance record](evidence/2026-09-07/final_acceptance.json) identifies this SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

The [selection record](evidence/2026-09-07/runtime_winner.json) gives a size of **8,858,736 bytes**.

These values identify the private file. They are not a downloadable release.

## What would a new build need?

1. A complete list of source, dependency and toolchain versions.
2. A reviewed patch order, without overlapping historical alternatives.
3. Build settings, generated inputs and any final processing steps.
4. Build logs and the new executable's fingerprint.
5. Fresh device tests of that executable.

Distribution also needs a resolved licensing path. The recorded VirtuaAPU restriction remains open.

**Do not apply every patch in filename order.** Some add diagnostics; others overlap or replace earlier approaches.

Use a new worktree. Leave private V1, saves and earlier evidence untouched.

## Can I reproduce the statistics?

The published [analysis script](evidence/2026-09-07/reanalyse.py) reads archived timing and monitor data. It does not launch the game or execute archived scripts.

The public extract contains the calculation method and selected summaries, not all raw traces. Recalculating every statistic therefore still requires the private archive.

[Source paths and hashes](evidence/2026-09-07/reanalysis.json) identify those inputs. A hash does not provide access to a missing file.

**Next:** [Learn which patches do what](PATCH_SERIES.md).

[Licensing status](LEGAL_STATUS.md) · [Third-party notices](../THIRD_PARTY_NOTICES.md)
