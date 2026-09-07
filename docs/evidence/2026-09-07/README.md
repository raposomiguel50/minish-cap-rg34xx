# Archived development records: evidence extract 1.0

**Prepared 7 September 2026.** This is a selected extract from the project-owner-supplied archive `RG34XX_PORT_MINISH_CAP_HANDOVER_V0.1.0_20260906_123500.zip` (SHA-256 `07ae7e1be8aed80dc9494c084d3ac5bfb5b60be186f6778344bec8fb7393ca10`). It contains historical measurements and acceptance records, not a newly executed device test.

`reanalysis.json` identifies the original archive members, sizes and SHA-256 hashes. The five archived JSON records (`audio_summary.json`, `final_machine_summary.json`, `final_acceptance.json`, `runtime_winner.json`, `stage_a_winner.json`) reproduce the original file bytes. `log_excerpts.json` retains original line numbers for selected diagnostic lines; transient crash addresses are explicitly redacted. Final V1 promotion marker files are included as exact text with source hashes.

`reanalyse.py` recalculates timing and selected final-monitor statistics from the original archive using Python's standard library. Run it against an existing archive and a **new** output directory:

```sh
python reanalyse.py RG34XX_PORT_MINISH_CAP_HANDOVER_V0.1.0_20260906_123500.zip new-analysis-output
```

The script does not launch the game, execute archived scripts or contact a device. It writes numerical CSV projections and reanalysis results. The complete archive, full traces and private build material are **not** bundled here. Public readers can inspect the selected machine records and analysis method; this extract alone does not permit reconstruction of every statistic from the complete raw traces. Hashes support identity checks, not independent verification of the original experimental procedure.

The evidence contains unfavourable results, including an audio-machine regression verdict and a higher maximum temperature in one optimisation comparison. Acceptance records and machine measurements answer different questions; neither should be silently substituted for the other.
