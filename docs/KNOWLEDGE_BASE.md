# Engineering knowledge base

Each entry identifies its evidence category. **Approved policies and website-maintenance lessons are not game-port test results.** Full methods, statistics, source paths and limits are in [EVIDENCE_AUDIT.md](EVIDENCE_AUDIT.md).

## KB-MC-001 — Foundation and attribution

**Status:** Source provenance.

The pinned foundation is EstebanPdN's Project Picori-derived fork, not an independently created engine. Its README identifies the Android, Project Picori and zeldaret antecedents (EstebanPdN, 2026; Raposo, 2026d).

## KB-MC-002 — Host and target evidence

**Status:** Methodological rule.

A host build does not establish target timing or runtime behaviour. The archived manual-session record supplies separate target observations; this audit did not repeat them (Raposo, 2026a).

## KB-MC-003 — CFW runtime boundary

**Status:** Source inspection.

The launcher loads PortMaster control helpers, selects an SDL2-backed shim path when applicable, and sets renderer preference opengles2/software. These settings are not proof of all-CFW compatibility (Raposo, 2026c).

## KB-MC-004 — Presentation and controls

**Status:** Source plus session record.

MENU+R2 accesses settings; MENU+L2 exits. The seamless-profile patch suppresses the L Settings hint and its legacy L action, not the settings implementation. Console-Parity and 3× scale are selected by the launcher (Raposo, 2026a, 2026b, 2026c).

## KB-MC-005 — Simulation and panel clocks

**Status:** Recalculated observation.

P11.3/P11.4 capture p95 tick lateness was 5.790787/0.027887 ms. Their maxima were 70.186618/64.134375 ms; exactly-one-present ticks were 84.534%/99.014%. Panel 119.455 Hz is not 120 FPS logic (Raposo, 2026a, 2026b).

## KB-MC-006 — Single-present scheduling

**Status:** Source plus observation.

P11.4 changes renderPeriodNs to tickPeriodNs in the selected path. The data still contain zero- and two-present ticks. Describe a scheduling policy, not an invariant absent from the data (Raposo, 2026a, 2026b).

## KB-MC-007 — Audio has mixed evidence

**Status:** Archived machine result and later operator report.

The P11.5 machine verdict is AUDIO1600_MACHINE_AUDIO_REGRESSION; maximum callback gap rose from 62.2 to 168.8 ms. The later final-session record reports audio OK. Neither observation replaces the other (Raposo, 2026a).

## KB-MC-008 — Benchmark context

**Status:** Methodological limit.

The historical AutoLab account distinguishes direct-SSH and normal Ports launch contexts. The two timing captures audited here were not established as randomised, matched-scene replications. State the actual context before inferring causation (Raposo, 2026a).

## KB-MC-009 — Automation and human QA

**Status:** Recorded acceptance.

The final acceptance reports two automated soaks and one manual gameplay session, with visual/audio OK. These are different tests and are not three independent full playthroughs (Raposo, 2026a).

## KB-MC-010 — Clock reduction and energy

**Status:** Source plus archived result.

The 1,416-to-936 MHz comparison is a 33.9% CPU-ceiling change. GPU ceiling 420 MHz was retained. Stage A energy fields are null/ineligible; do not claim 33.9% energy savings (Raposo, 2026a, 2026c).

## KB-MC-011 — Adverse observations remain visible

**Status:** Archived result.

The P13.1 winner record includes maximum-temperature delta +5.3 °C and median RSS ratio 1.003497 in that comparison. They do not support a general claim of lower temperatures or memory use (Raposo, 2026a).

## KB-MC-012 — Rejected renderer work

**Status:** Recorded selection.

The retained winner says backend SDL_RENDERER and fullscreen_clear_skip=false. Historical GPU-renderer experiments are not evidence that a new GPU backend shipped (Raposo, 2026a).

## KB-MC-013 — Exit is an integration boundary

**Status:** Patch plus diagnostic observation.

D2 records signal 11 after shutdown markers. D3 reaches the profile-specific _Exit path; the later session reports exit code 0. This is a targeted workaround, not identification of the faulty destructor or an original-ROM bug fix (Raposo, 2026a, 2026b).

## KB-MC-014 — Executable identity

**Status:** Recorded metadata.

The acceptance identifies SHA-256 787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710. A hash is not proof of a successful reconstruction (Raposo, 2026a, 2026d).

## KB-MC-015 — Reconstruction claims

**Status:** Publication limit.

A historical patch set, a runnable new build and a bit-for-bit rebuilt V1 are different deliverables. This editorial audit supplies neither a new executable nor a new build validation (Raposo, 2026a, 2026b, 2026d).

## KB-MC-016 — Release eligibility

**Status:** Recorded project boundary.

Private acceptance is separate from permission to redistribute dependencies. The recorded VirtuaAPU boundary remains unchanged; see LEGAL_STATUS.md. This audit does not resolve a licence (Raposo, 2026d).

## KB-MC-017 — Documentation and binary scope

**Status:** Publication rule.

A binary restriction need not prevent publishing cleared patches, measurement definitions and selected evidence. It does not justify disclosing the complete private archive (Raposo, 2026a, 2026b).

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

Native game logic still uses Linux, SDL and software models of original presentation/audio behaviour. No native-versus-emulator speed or energy comparison is established here. The policy is to use available control for faithful execution (Raposo, 2026a, 2026b, 2026c).

## KB-MC-022 — Original bugs and restoration

**Status:** Approved policy, not an implemented bug-fix list.

A demonstrated original technical bug may be corrected when compatible with the creative work. This is an eligibility rule. The reviewed material does not establish an original-GBA gameplay-bug correction.

## KB-MC-023 — Curatorial defaults

**Status:** Approved policy with specific source examples.

Select a coherent reference rather than requiring many manual adjustments. Shortcut access and hint suppression are evidenced; this does not prove every upstream option was individually audited (Raposo, 2026b, 2026c).

## KB-MC-024 — Efficiency after fidelity

**Status:** Approved priority plus recorded settings.

CPU 936 MHz/GPU 420 MHz are recorded ceilings. Reducing power or thermal demand was the objective; actual savings are not established by those settings (Raposo, 2026a, 2026c).

## KB-MC-025 — Historical reference

**Status:** Approved policy.

Retain uncorrected historical behaviour when useful for comparison or investigation, without a requirement to expose a normal user mode. This is not a claim that such a mode was implemented.

## Entry template

State the category, exact symptom or decision, source revision/path, implementation if any, test configuration, observed result and limitation. No generic “improved”, “fixed” or “validated” statement without the supporting case.

## References

EstebanPdN. (2026). *The Minish Cap 3DS* (Commit `e72663ca4059dabf9dbf7f03c36fc791d90b8db5`) [Source code]. GitHub. https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5

Raposo, M. (2026a). *Archived development records for The Minish Cap—RG34XX (27 August–5 September 2026)* (Evidence extract 1.0) [Data set]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/ede6e9090e7ca78c6c3a8c3d324d8c1de881f8b3/docs/evidence/2026-09-07

Raposo, M. (2026b). *H700 integration patches for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/90fd77a82d579de9460f2de1167a95ec264e57c3/patches

Raposo, M. (2026c). *Reference launcher for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh

Raposo, M. (2026d). *Source baseline for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Project metadata]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/SOURCE_BASELINE.json
