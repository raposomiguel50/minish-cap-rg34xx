# Reconstruction and reproducibility status

This document explains what another developer can reproduce from the public material **today**, what remains incomplete, and what evidence would be required before making stronger claims.

## Three different claims

The project deliberately separates:

1. **Historical auditability** — the public record explains what was tried, why decisions were made and which evidence supported them.
2. **Functional reconstruction** — a new build can be produced from documented inputs and behaves acceptably on the target.
3. **Bit-for-bit reproducibility** — the documented source, toolchain, dependencies and build procedure recreate an identical binary artifact.

The public project currently provides the strongest support for **historical auditability**.

It does **not** currently claim that the retained private V1 can be rebuilt bit-for-bit from this repository.

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
- engineering knowledge base.

See:

- `SOURCE_BASELINE.json`
- `config/UPSTREAM_SOURCES.tsv`
- `config/REFERENCE_HASHES.tsv`
- `docs/PATCH_SERIES.md`
- `docs/PROVENANCE.md`

## Retained private V1 identity

The validated private V1 executable is identified by SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

This hash is useful for identifying the retained artifact.

It is **not** evidence by itself that another developer can rebuild the same bytes.

## Source material preserved from later work

The project review found four hash-verified source snapshots from P13.1:

- `port/port_ppu.cpp`
- `port/port_gpu_renderer.cpp`
- `port/port_main.c`
- `xmake.lua`

They were preserved in the private engineering record and matched their source-authority manifest during review.

Their existence improves historical recoverability, but they are not automatically equivalent to a complete final source tree or build environment.

A complete reconstruction must still account for:

- exact upstream/source ancestry;
- all accepted source changes;
- dependency revisions;
- toolchain/compiler identity;
- build flags;
- link inputs;
- strip/post-processing steps;
- launcher/runtime policy;
- any generated files that affect the output.

## Licensing blocks public binary reproduction/distribution

The validated private V1 incorporated VirtuaAPU.

At the audited revision, VirtuaAPU did not contain an explicit published licence file. Therefore this repository does not redistribute:

- VirtuaAPU source;
- the retained V1 executable incorporating it.

This is a redistribution boundary, not evidence that the private V1 is technically invalid.

See `docs/LEGAL_STATUS.md` and `THIRD_PARTY_NOTICES.md`.

## Safe reconstruction starting point

A developer studying the project can begin by obtaining the exact public upstream revision:

```bash
git clone https://github.com/EstebanPdN/zelda-tmc-3ds.git
cd zelda-tmc-3ds
git checkout --detach e72663ca4059dabf9dbf7f03c36fc791d90b8db5
```

Then:

1. inspect `docs/PATCH_SERIES.md` before applying anything;
2. begin with the Foundation patches only;
3. verify each patch against the pinned source revision;
4. keep instrumentation/A-B patches out of a production candidate unless you are reproducing the experiment they were designed for;
5. record every dependency/toolchain choice;
6. validate host-build success separately from H700 target behaviour.

This repository intentionally does **not** provide a blind `apply-all` command because the public patch directory includes historical and diagnostic material.

## Target validation reference

Validated reference environment:

- ANBERNIC RG34XX-H
- Allwinner H700
- Cortex-A53 / AArch64
- muOS
- original 720x480 display

Important retained behaviour/decision evidence includes:

- original-style 240x160 -> 720x480 integer 3x presentation;
- logical cadence around ~59.7275 Hz;
- panel around ~119.455 Hz;
- one explicit presentation per logical tick in the accepted high-refresh direction;
- retained later runtime evidence: CPU ceiling 936 MHz, GPU 420 MHz, audio 1600, `TMC_RENDER_THREADS=3`;
- clean-exit/lifecycle work;
- target audio QA.

These values are engineering evidence for the validated line, not universal recommendations for every H700 device or CFW.

## What would qualify as a supported functional reconstruction

Before this repository should advertise a supported reconstruction procedure, the following should be demonstrated in a **new clean directory**:

1. exact upstream clone at the documented revision;
2. deterministic dependency acquisition or explicit dependency pins;
3. a documented, minimal accepted patch sequence;
4. successful AArch64 build without relying on hidden local files/caches;
5. binary architecture/link checks;
6. launch on the target through a normal CFW/Ports context;
7. visual, input, audio and exit QA;
8. recorded hashes and toolchain versions;
9. clear statement of any unavoidable difference from the retained V1.

Only after that should the procedure be called a **validated functional reconstruction**.

## What would qualify as bit-for-bit reproducibility

A stronger claim would additionally require:

- complete final source identity;
- exact dependency objects;
- exact compiler/linker/toolchain versions;
- deterministic timestamps/build metadata where relevant;
- exact flags and environment;
- identical post-processing/strip steps;
- identical resulting SHA-256.

No such claim is made today.

## Why publish an incomplete reconstruction path?

Because uncertainty is itself useful engineering information when it is documented precisely.

The goal is not to pretend the project is more reproducible than the evidence shows. The goal is to leave enough provenance, decisions and technical structure that the next developer can continue from a known boundary instead of starting from folklore or an unexplained binary.

That is consistent with the project's wider philosophy: **preserve what is known, contain what is uncertain, and improve the record incrementally.**
