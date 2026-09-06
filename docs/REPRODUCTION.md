# Reconstruction and reproducibility status

This document defines the current reconstruction status of the public RG34XX/H700 integration and the evidence required for stronger reproducibility claims.

## Evidence levels

The project distinguishes three levels:

1. **Historical auditability** — decisions, experiments and supporting evidence can be traced.
2. **Functional reconstruction** — a new build can be produced from documented inputs and validated on the target.
3. **Bit-for-bit reproducibility** — the documented source, toolchain, dependencies and build procedure recreate an identical binary artifact.

The current public material provides the strongest support for **historical auditability**.

Bit-for-bit reproduction of the retained private V1 is not currently claimed.

## Authoritative public baseline

Principal upstream:

- Project Picori: https://github.com/EstebanPdN/zelda-tmc-3ds
- revision: `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`

The public integration repository provides:

- target/build compatibility patches;
- RG34XX/H700 integration patches;
- launcher/runtime material;
- upstream/reference pins;
- provenance and legal-status documentation;
- patch-history classification;
- engineering documentation.

See:

- `SOURCE_BASELINE.json`
- `config/UPSTREAM_SOURCES.tsv`
- `config/REFERENCE_HASHES.tsv`
- `docs/PATCH_SERIES.md`
- `docs/PROVENANCE.md`

## Retained private V1 identity

The validated private V1 executable is identified by SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

The hash identifies the retained artifact. It does not establish that another environment can reproduce identical bytes.

## Preserved source material

Four P13.1 source snapshots were retained and hash-verified in the private engineering record:

- `port/port_ppu.cpp`
- `port/port_gpu_renderer.cpp`
- `port/port_main.c`
- `xmake.lua`

These files improve historical traceability but are not presented as a complete final source tree or build environment.

A complete reconstruction would also need to account for:

- exact source ancestry;
- all accepted source changes;
- dependency revisions;
- compiler/toolchain identity;
- build flags;
- link inputs;
- strip/post-processing steps;
- launcher/runtime policy;
- generated files that affect the output.

## Licensing boundary

The retained private V1 incorporated VirtuaAPU.

At the audited revision, VirtuaAPU did not provide an explicit published licence file. The public repository therefore does not redistribute VirtuaAPU source or the V1 executable incorporating it.

This is a redistribution limitation and is separate from the technical identity of the retained private artifact.

See `docs/LEGAL_STATUS.md` and `THIRD_PARTY_NOTICES.md`.

## Public reconstruction starting point

A developer can begin from the exact public upstream revision:

```bash
git clone https://github.com/EstebanPdN/zelda-tmc-3ds.git
cd zelda-tmc-3ds
git checkout --detach e72663ca4059dabf9dbf7f03c36fc791d90b8db5
```

Then:

1. review `docs/PATCH_SERIES.md`;
2. begin with Foundation patches;
3. verify each patch against the pinned source revision;
4. keep instrumentation and A/B patches separate unless reproducing those experiments;
5. record dependency and toolchain choices;
6. validate host-build success separately from H700 target behaviour.

No single `apply-all` procedure is provided because the published patch directory contains both stable-direction work and historical/diagnostic material.

## Target validation reference

Validated reference environment:

- ANBERNIC RG34XX-H
- Allwinner H700
- Cortex-A53 / AArch64
- muOS
- 720x480 display

Retained behaviour and configuration evidence includes:

- 240x160 -> 720x480 integer 3x presentation;
- logical cadence around ~59.7275 Hz;
- panel around ~119.455 Hz;
- one explicit presentation per logical tick in the accepted timing direction;
- CPU ceiling 936 MHz, GPU 420 MHz, audio 1600, `TMC_RENDER_THREADS=3`;
- clean-exit/lifecycle work;
- target audio QA.

These values apply to the documented reference line and are not presented as universal settings for every H700 device or CFW.

## Requirements for functional reconstruction

A supported functional reconstruction should be demonstrated from a new clean directory with:

1. the documented upstream revision;
2. explicit dependency/toolchain pins;
3. a defined accepted patch sequence;
4. successful AArch64 build without hidden local inputs;
5. architecture/link checks;
6. launch through a normal target CFW/Ports context;
7. visual, input, audio and exit QA;
8. recorded hashes and toolchain versions;
9. documented differences from the retained V1, if any.

## Requirements for bit-for-bit reproducibility

A stronger claim would additionally require:

- complete final source identity;
- exact dependency objects;
- exact compiler/linker/toolchain versions;
- deterministic timestamps/build metadata where relevant;
- exact flags and environment;
- identical post-processing/strip steps;
- identical resulting SHA-256.

These requirements have not yet been demonstrated for the retained V1.

## Current position

The public repository provides a traceable baseline, source-side integration history and clear reconstruction boundaries. Future reconstruction work can build on that record without overstating the evidence currently available.
