# Engineering knowledge base

Each entry identifies its evidence category. **Approved policies and website-maintenance lessons are not game-port test results.** Full methods, statistics, source paths and limits are in [EVIDENCE_AUDIT.md](EVIDENCE_AUDIT.md).

## KB-MC-001 — Foundation and attribution

**Status:** Source provenance.

The pinned foundation is EstebanPdN's Project Picori-derived fork, not an independently created engine. Its README identifies the Android, Project Picori and zeldaret antecedents (EstebanPdN, 2026). The revision is recorded in [SOURCE_BASELINE.json](../SOURCE_BASELINE.json).

## KB-MC-002 — Host and target evidence

**Status:** Methodological rule.

A host build does not establish target timing or runtime behaviour. The [archived manual-session record](evidence/2026-09-07/final_acceptance.json) supplies separate target observations; this audit did not repeat them.

## KB-MC-003 — CFW runtime boundary

**Status:** Source inspection.

The [launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh) loads PortMaster control helpers, selects an SDL2-backed shim path when applicable, and sets renderer preference opengles2/software. These settings are not proof of all-CFW compatibility.

## KB-MC-004 — Presentation and controls

**Status:** Source plus session record.

MENU+R2 accesses settings; MENU+L2 exits. The seamless-profile patch suppresses the L Settings hint and its legacy L action, not the settings implementation. Console-Parity and 3× scale are selected by the launcher. Sources: [patch map](PATCH_SERIES.md), [session excerpts](evidence/2026-09-07/log_excerpts.json) and the pinned launcher linked above.

## KB-MC-005 — Simulation and panel clocks

**Status:** Recalculated observation.

P11.3/P11.4 capture p95 tick lateness was 5.790787/0.027887 ms. Their maxima were 70.186618/64.134375 ms; exactly-one-present ticks were 84.534%/99.014%. Panel 119.455 Hz is not 120 FPS logic. Source: [timing reanalysis](evidence/2026-09-07/reanalysis.json); definitions are in the [P11 instrumentation patches](PATCH_SERIES.md).

## KB-MC-006 — Single-present scheduling

**Status:** Source plus observation.

[P11.4](../patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch) changes renderPeriodNs to tickPeriodNs in the selected path. The [data](evidence/2026-09-07/reanalysis.json) still contain zero- and two-present ticks. Describe a scheduling policy, not an invariant absent from the data.

## KB-MC-007 — Audio has mixed evidence

**Status:** Archived machine result and later operator report.

The [P11.5 machine verdict](evidence/2026-09-07/audio_summary.json) is AUDIO1600_MACHINE_AUDIO_REGRESSION; maximum callback gap rose from 62.2 to 168.8 ms. The later [final-session record](evidence/2026-09-07/final_acceptance.json) reports audio OK. Neither observation replaces the other.

## KB-MC-008 — Benchmark context

**Status:** Methodological limit.

The [historical AutoLab account](https://github.com/raposomiguel50/minish-cap-rg34xx/tree/5c306562615b1595ed49c7388dc768c8348b1296/docs/evidence/2026-09-07) distinguishes direct-SSH and normal Ports launch contexts. The two timing captures audited here were not established as randomised, matched-scene replications. State the actual context before inferring causation; see the [timing-analysis method](EVIDENCE_AUDIT.md#timing-analysis).

## KB-MC-009 — Automation and human QA

**Status:** Recorded acceptance.

The [final acceptance](evidence/2026-09-07/final_acceptance.json) reports two automated soaks and one manual gameplay session, with visual/audio OK. These are different tests and are not three independent full playthroughs.

## KB-MC-010 — Clock reduction and energy

**Status:** Source plus archived result.

The 1,416-to-936 MHz comparison is a 33.9% CPU-ceiling change. GPU ceiling 420 MHz was retained. [Stage A energy fields](evidence/2026-09-07/stage_a_winner.json) are null/ineligible; do not claim 33.9% energy savings. See the [runtime record](evidence/2026-09-07/runtime_winner.json) and [baseline distinction](VALIDATION.md#efficiency-objective-versus-measurement).

## KB-MC-011 — Adverse observations remain visible

**Status:** Archived result.

The [P13.1 winner record](evidence/2026-09-07/runtime_winner.json) includes maximum-temperature delta +5.3 °C and median RSS ratio 1.003497 in that comparison. They do not support a general claim of lower temperatures or memory use.

## KB-MC-012 — Rejected renderer work

**Status:** Recorded selection.

The [retained winner](evidence/2026-09-07/runtime_winner.json) says backend SDL_RENDERER and fullscreen_clear_skip=false. Historical GPU-renderer experiments are not evidence that a new GPU backend shipped.

## KB-MC-013 — Exit is an integration boundary

**Status:** Patch plus diagnostic observation.

D2 records signal 11 after shutdown markers. D3 reaches the profile-specific _Exit path; the later session reports exit code 0. This is a targeted workaround, not identification of the faulty destructor or an original-ROM bug fix. Sources: [D2/D3 and final-session excerpts](evidence/2026-09-07/log_excerpts.json) and [exit patches](PATCH_SERIES.md).

## KB-MC-014 — Executable identity

**Status:** Recorded metadata.

The [acceptance](evidence/2026-09-07/final_acceptance.json) identifies SHA-256 787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710. A hash is not proof of a successful reconstruction. See also [SOURCE_BASELINE.json](../SOURCE_BASELINE.json).

## KB-MC-015 — Reconstruction claims

**Status:** Publication limit.

A historical patch set, a runnable new build and a bit-for-bit rebuilt V1 are different deliverables. This editorial audit supplies neither a new executable nor a new build validation. The [patch map](PATCH_SERIES.md), [source baseline](../SOURCE_BASELINE.json) and [reconstruction status](REPRODUCTION.md) identify what is available.

## KB-MC-016 — Release eligibility

**Status:** Recorded project boundary.

Private acceptance is separate from permission to redistribute dependencies. The recorded VirtuaAPU boundary remains unchanged; see [LEGAL_STATUS.md](LEGAL_STATUS.md). This audit does not resolve a licence.

## KB-MC-017 — Documentation and binary scope

**Status:** Publication rule.

A binary restriction need not prevent publishing cleared patches, measurement definitions and selected evidence. It does not justify disclosing the complete private archive. See [public materials and reconstruction limits](REPRODUCTION.md).

## KB-MC-018 — Local QA versus live deployment

**Status:** Website-maintenance lesson; not game-test evidence.

Candidate QA, repository publication, deployment and live verification are separate states. This operational lesson from lab-site maintenance is not a Minish Cap performance result.

## KB-MC-019 — Proportionate tooling

**Status:** Workflow policy; not a measured result.

Use direct, auditable operations for small changes and automation for real repetition. Parse and test a tool before asking the operator to run it.

## KB-MC-020 — Reuse existing artifacts

**Status:** Workflow policy; not game-test evidence.

Inventory and verify known local artifacts before asking for another download, copy or test. Music-source recovery is separate from game-port evidence.

## KB-MC-021 — Native execution

**Status:** Technical scope and policy.

Native game logic still uses Linux, SDL and software models of original presentation/audio behaviour. No native-versus-emulator speed or energy comparison is established here. The policy is to use available control for faithful execution. See [implementation scope and limits](EVIDENCE_AUDIT.md#interpretation-and-limits).

## KB-MC-022 — Original bugs and restoration

**Status:** Approved policy, not an implemented bug-fix list.

A demonstrated original technical bug may be corrected when compatible with the creative work. This is an eligibility rule. The reviewed material does not establish an original-GBA gameplay-bug correction.

## KB-MC-023 — Curatorial defaults

**Status:** Approved policy with specific source examples.

Select a coherent reference rather than requiring many manual adjustments. [Shortcut access and hint suppression](PATCH_SERIES.md) are evidenced; this does not prove every upstream option was individually audited.

## KB-MC-024 — Efficiency after fidelity

**Status:** Approved priority plus recorded settings.

CPU 936 MHz/GPU 420 MHz are recorded ceilings. Reducing power or thermal demand was the objective; actual savings are not established by those settings. Sources: [accepted configuration](evidence/2026-09-07/final_acceptance.json) and [energy-measurement status](evidence/2026-09-07/stage_a_winner.json).

## KB-MC-025 — Historical reference

**Status:** Approved policy.

Retain uncorrected historical behaviour when useful for comparison or investigation, without a requirement to expose a normal user mode. This is not a claim that such a mode was implemented.

## Entry template

State the category, exact symptom or decision, source revision/path, implementation if any, test configuration, observed result and limitation. No generic “improved”, “fixed” or “validated” statement without the supporting case.

## External reference

EstebanPdN. (2026). *The Minish Cap 3DS* (Commit `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`) [Source code]. GitHub. https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5
