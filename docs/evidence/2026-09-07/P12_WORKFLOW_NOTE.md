# P12 AutoLab orchestrator R2.6 — effect-gated visual/resumable native muOS session

Recorded: 2026-09-04T17:48:47+01:00

Six optimization streams were automated using a benchmark-only deterministic replay derived
from the real P11.1 input trace, but all performance measurements ran inside one normal
muOS content session launched from Ports.

- P12 R1 direct-SSH performance results were invalidated and not reused.
- P11.7 reference was not modified.
- P08 Stable was not modified.
- Device tests ran only inside `/mnt/sdcard/ports/minishcap-autolab-P12`.
- One native Ports launch kept `frontend.sh` blocked in `launch.sh`; `muxfrontend`,
  frontend BGM and the frontend screensaver renderer were gated absent before every job.
- Jacaranda idle was inhibited through its own `idle.sh` process-watchlist mechanism;
  `/run/muos/idle_state` was retained as telemetry only because R2.4 hardware proved it can be stale.
  AutoLab did not write a persistent idle configuration override.
- CPU/GPU policy was restored to its exact pre-run state after every variant.
- Compiler/linker, LTO and PGO candidates were selected by automated gates.
- CPU caps were searched descending.
- GPU caps used only sysfs-advertised OPPs.
- Audio buffers below 1600 were attempted only if a measured headroom gate allowed them.
- Benchmark replay/profile instrumentation was removed from the clean winner.
- Manual gameplay sessions during the six streams: **0**.
- Native menu launches during the six streams: **1**.
- Stable promotion: **NO**.

Winner details: `project/autolab/P12/AUTOLAB_WINNER_R2_NATIVE_SESSION.json`.
