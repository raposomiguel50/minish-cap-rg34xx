# Development and reporting method

## Responsibility

I define the project purpose, target platform, preservation criteria and acceptance decisions. ChatGPT assists with code, automation, analysis and documentation. An AI-generated statement, script or expected-output template is not evidence that a command ran successfully.

## Source-to-claim reporting

Every factual result should identify the source path/revision, relevant configuration, observation and limit. Keep five categories separate: source implementation, recorded observation, reanalysis, approved policy and unsupported claim. Use author–date citations and an APA-style reference list; use immutable revisions for code and versioned extracts for data.

For this audit, 15 historical patches were inspected, two timing traces were recalculated and selected final-session telemetry was checked. There were **no new hardware runs**. Hash agreement checks artifact identity; it does not establish the historical authenticity or completeness of a test (Raposo, 2026a, 2026b).

## Experiments and statistics

Define the variable before reporting its value. Tick lateness, a presentation-call duration, panel refresh and perceptual latency are different quantities. Repeated ticks within a session are not independent experiments. Report adverse maxima and negative verdicts alongside improved percentiles. Do not imply randomised or matched-scene testing when the record does not establish it.

The earlier audio-machine verdict and later operator acceptance are both retained. CPU-frequency reduction is not converted into energy or thermal savings. See [Validation](VALIDATION.md) and [Evidence audit](EVIDENCE_AUDIT.md) for the concrete records (Raposo, 2026a).

## Preservation policy is not a completed feature

[PHILOSOPHY.md](PHILOSOPHY.md) contains approved decision criteria. Any proposed original-game bug correction requires a reproducible symptom, defect/design assessment, source change, build identity and test result before appearing as completed work. No such original-GBA gameplay-bug correction is claimed by this audit.

## Controlled intervention

Work on an isolated copy, retain the prior state and change the smallest justified scope. A technical experiment can be useful even when rejected. The historical GPU-renderer and fullscreen-clear directions were not selected in the recorded winner; their existence must not become a claim of a new renderer shipped in V1 (Raposo, 2026a).

## Continuity and publication

Persist executed actions, outcomes, failures and evidence independently of the conversation. Keep local state, repository publication, deployment and live verification distinct. Do not say the Honor project record has been synchronised without an actual local write and verification. Public evidence is selected to exclude ROMs, private binaries and personal runtime data.

A small read-only analysis of thousands of trace rows is appropriate automation. Repeatedly generating large untested publication runners is not. Questions should resolve a real ambiguity, one at a time, rather than repeatedly reconfirm an approved decision.

## Reusable contribution

The reusable material is the source change, configuration, measurement definition, result, alternative and limitation. Publishing a principle does not demonstrate its fulfilment; publishing a number without its context does not establish a performance improvement.

## References

Raposo, M. (2026a). *Archived development records for The Minish Cap—RG34XX (27 August–5 September 2026)* (Evidence extract 1.0) [Data set]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/ede6e9090e7ca78c6c3a8c3d324d8c1de881f8b3/docs/evidence/2026-09-07

Raposo, M. (2026b). *H700 integration patches for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/90fd77a82d579de9460f2de1167a95ec264e57c3/patches
