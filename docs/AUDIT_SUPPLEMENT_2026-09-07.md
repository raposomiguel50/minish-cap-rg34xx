# Configuration and log discrepancies: Supplement to the evidence audit

Miguel's Game Dev Lab  
7 September 2026

## Scope

This supplement reports archived observations that limit stronger claims about the selected runtime. It accompanies [EVIDENCE_AUDIT.md](EVIDENCE_AUDIT.md). It does not introduce new device tests, diagnose the cause of every warning or modify the private V1.

The inspected [launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh) is pinned at revision `90fd77a82d579de9460f2de1167a95ec264e57c3`. The archived P13.1 log and monitor are identified by their original paths and SHA-256 values in the [fixed evidence collection and source index](https://github.com/raposomiguel50/minish-cap-rg34xx/tree/e0f8c056bb94e8112a4b142b6addce78c9deb53b/docs/evidence/2026-09-07).

## Observations

**Table 1**  
*Configuration requests, diagnostic messages and unresolved scope*

| Item | Exact source observation | Supported interpretation |
| --- | --- | --- |
| Audio buffer | The launcher exports `SDL_AUDIO_DEVICE_SAMPLE_FRAMES=1600` but prints `RG34XX_AUDIO_BUFFER_FRAMES=1920`. Archived log lines 2–3 repeat the conflict. | 1600 is the request. The printed diagnostic disagrees. The buffer actually negotiated by the device is not established by those strings alone. |
| Save states and autosave | Log line 22 describes save states as inert. Lines 94–95 and 101–102 record quicksave/autosave writes to ring slots 5 and 6. | It is not justified to state that every related convenience function is inactive. Manual actions and background autosave may have distinct gating; that distinction has not been established here. |
| CPU governor | The monitor reports `PRE_CPU_GOV=powersave` and `POST_CPU_GOV=ondemand`. | The original governor is not reproduced in the recorded post-session value. The cause of that difference is not established by this audit. |
| Restored limits and display mode | CPU maximum is 1,512,000 kHz before and after; GPU maximum is 0 before and after; the reported display mode returns from 119.455 Hz during sampling to the pre-session 60.005 Hz. | Restoration is supported for these recorded variables, not automatically for every system state. GPU maximum 0 is retained as a recorded value, not interpreted as a physical zero-Hz running frequency. |
| Pointer warnings | Log lines 103–104 report `ResolveRomPtr` addresses `0x80034678` and `0x8003C28C` outside the ROM. | The warnings remain part of an accepted session. Neither harmlessness, a specific gameplay defect nor a completed fix is inferred. |
| Extraction time | Line 81 reports completion of asset extraction in 102,799 ms. | This session does not support a claim of instant extraction or first-run startup. |

*Note.* Sources: [P13_1_LOG_EXCERPTS.txt](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/e0f8c056bb94e8112a4b142b6addce78c9deb53b/docs/evidence/2026-09-07/P13_1_LOG_EXCERPTS.txt); [REANALYSIS.json, `p13_1_monitor`](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/e0f8c056bb94e8112a4b142b6addce78c9deb53b/docs/evidence/2026-09-07/REANALYSIS.json); and the pinned launcher linked above. Line numbers refer to the original runtime log, not the excerpt's display lines. The excerpt explicitly identifies its selection and source hash.

The same log records MENU+L2 exit and return code 0 at lines 131 and 135. The [final acceptance](evidence/2026-09-07/final_acceptance.json) records visual and audio `OK` in one manual session. Those observations do not erase contradictory diagnostics or prove that every reference default was active.

## Evidence versus diagnosis

These discrepancies warrant narrower wording, not an automatic code change. A diagnostic string may be stale; a background operation may be gated differently from a manual feature; a governor may be changed by another lifecycle component. Those are possible explanations, not findings of this audit. Investigation must establish the relevant code path and effective runtime value before a cause or corrective action is claimed.

## Preserving concurrent work

The final publication check found a newer audit revision on `main`, `d222705dad4ba8c5030fae49e64f2555c286a229`. That revision and its updated documents were retained. The older competing editorial draft was not used to replace them. The additional evidence snapshots are retained in the merged history so their fixed references remain inspectable.

Only this supplement and its report index were added to that newer document baseline. Source patches, launcher, configuration pins and licensing notices were unchanged. Publication on GitHub does not by itself synchronize the separate Honor `Project-Control`; that local synchronization remains pending until independently confirmed.
