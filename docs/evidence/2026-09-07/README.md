# Archived integration and runtime records

This collection supports the documentation audit dated 7 September 2026. It contains selected records recovered from `RG34XX_PORT_MINISH_CAP_HANDOVER_V0.1.0_20260906_123500.zip`, not new game or device tests.

## Provenance

`SOURCE_INDEX.json` identifies the archive, original relative paths, byte sizes and SHA-256 values. Six files are byte-preserved archived results: `P10_3_2_QA_VERDICT.txt`, `P11_4_AB_SUMMARY.json`, `P13_STAGE_A_WINNER.json`, `P13_1_WINNER.json`, `P13_1_ACCEPTANCE.json` and `P13_1_MACHINE_SUMMARY.json`.

`P13_1_LOG_EXCERPTS.txt` is an explicitly selected excerpt, with original line numbers and the original file's hash. It retains warnings and contradictory diagnostics as well as configuration and exit messages. It is not the complete runtime log.

`REANALYSIS.json` is newly calculated from the archived P11.3/P11.4 traces and the P13.1 monitor. Its method is stated in the file; it is not an original measurement session.

## Interpretation

- A configuration request is not proof of the configuration negotiated by the runtime.
- A test verdict is limited to the checks and session it records.
- Within-session ticks and monitor rows are not independent test sessions.
- `stable_promotion=false` and other historical state fields retain their original meaning at the date of each record.
- An absent energy value is not zero energy consumption.
- Operator acceptance does not establish that every original-game bug was corrected or that a full playthrough was tested.

## Access boundary

The two full numeric traces and the monitor are supplied in the accompanying audit delivery to the project owner. This repository snapshot publishes summaries and selected excerpts, not those complete raw files. Hashes identify the archived sources but do not substitute for public access. Recalculation requires the raw files identified in `SOURCE_INDEX.json`.

No ROM, extracted game assets, saves, game executable or third-party audio-engine source is included in this collection.
