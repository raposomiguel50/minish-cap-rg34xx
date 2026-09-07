# P13.1 profile-driven render AutoLab R2 — crash resume

Recorded: 2026-09-05T11:58:34+01:00

Stage-A authority: CPU 936 MHz, GPU 420 MHz, audio 1600, fixed DVFS, strip adopted.
P13.1 retested only measured renderer/backend/runtime opportunities; prior negative lanes were not repeated.
R1 GPU renderer was blacklisted after a hardware REJECT with zero profile windows plus operator-observed RG34XX crash. R2 never rebuilds or replays that backend.
R1 baseline results are reused only through the existing CONFIG_SHA + native PRE/POST context cache gates.

Winner:
- clean binary SHA-256: `787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`
- backend: `SDL_RENDERER`
- fullscreen redundant-clear patch: `NO`
- TMC_RENDER_THREADS: `3`
- OMP_NUM_THREADS: `default`
- OMP_WAIT_POLICY: `default`
- OMP_PROC_BIND/PLACES: `default` / `default`
- MALLOC_ARENA_MAX: `default`

All acceptance used deterministic replay at CPU936/GPU420 and two-run final soak.
P11.7, P12.RC1, P13 Stage A and Stable P08 were not modified. Stable promotion: NO.
