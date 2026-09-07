# Patch map and evidence

This map inventories **15 public patches at commit `90fd77a82d579de9460f2de1167a95ec264e57c3`**. It describes source changes, not a guaranteed linear application order or a reconstructed V1. All links below are to that immutable revision (Raposo, 2026b).

| Patch | Role | What the source changes |
| --- | --- | --- |
| [P04_AARCH64_LINK_COMPLETENESS_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P04_AARCH64_LINK_COMPLETENESS_R1.patch) | Build | Adds a required source file and Linux/Android EGL/GLES links. |
| [P04_FMT_PACKED_COLLISION_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P04_FMT_PACKED_COLLISION_R1.patch) | Build | Moves fmt header before project headers. |
| [P06_H700_CORTEX_A53_TARGET_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P06_H700_CORTEX_A53_TARGET_R1.patch) | Build | Adds ARMv8-A/SIMD and Cortex-A53 tuning flags in its platform condition. |
| [P09_RG34XX_HANDHELD_POLISH_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P09_RG34XX_HANDHELD_POLISH_R1.patch) | Historical integration | Handheld input/menu labelling; later superseded in parts by P10.3. |
| [P10_3_1D2_CLEAN_QUIT_UNWIND_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1D2_CLEAN_QUIT_UNWIND_R1.patch) | Exit handling | Propagates quit requests through main loops and waits. |
| [P10_3_1D3_RG34XX_POST_SHUTDOWN_EXIT_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1D3_RG34XX_POST_SHUTDOWN_EXIT_R1.patch) | Historical workaround | Calls _Exit after shutdown on target profile; see refined P10.3.2. |
| [P10_3_1_EXIT_DIAG_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1_EXIT_DIAG_R1.patch) | Instrumentation | Adds exit-path/crash markers; diagnostic code is not itself a fix. |
| [P10_3_1_RG34XX_A53_AUDIO_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1_RG34XX_A53_AUDIO_R1.patch) | Audio configuration | Selects linear in one enhanced-audio branch; gbaAccurate remains nearest. |
| [P10_3_2_RG34XX_CLEAN_EXIT_FILESELECT_UI_R3.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_2_RG34XX_CLEAN_EXIT_FILESELECT_UI_R3.patch) | Later integration | Combines quit handling, conditional post-shutdown _Exit and legacy hint/L-action suppression. |
| [P10_3_RG34XX_SEAMLESS_HIGH_REFRESH_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_RG34XX_SEAMLESS_HIGH_REFRESH_R1.patch) | Historical integration | Adds MENU+L2/R2 routes and seamless UI; initial double-rate timing is historical. |
| [P11_1_RG34XX_TIMING_INPUT_PRESENT_TRACE_R3.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_1_RG34XX_TIMING_INPUT_PRESENT_TRACE_R3.patch) | Instrumentation | Defines tick/input/presentation trace rows. |
| [P11_2_RG34XX_HIGH_REFRESH_VSYNC_OFF_AB_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_2_RG34XX_HIGH_REFRESH_VSYNC_OFF_AB_R1.patch) | Timing experiment | Changes selected high-refresh VSync policy. |
| [P11_3_RG34XX_PPU_PHASE_SPLIT_TRACE_R3.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_3_RG34XX_PPU_PHASE_SPLIT_TRACE_R3.patch) | Instrumentation | Adds presentation-phase markers used in the reanalysis. |
| [P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch) | Timing policy | Changes presentation period to the logical period in the selected path. |
| [P11_7_RG34XX_PRODUCTION_LIKE_RUNTIME_POLICY_R1.patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_7_RG34XX_PRODUCTION_LIKE_RUNTIME_POLICY_R1.patch) | Runtime policy | Separates production-like settings from diagnostic pacing behaviour. |

## What this proves—and what it does not

The patches show which instructions/configuration paths were changed. Exit diagnostics and later session output provide additional execution evidence. A build-source filename containing a room name is not evidence of an original gameplay-bug fix. Instrumentation and experimental patches must not be presented as released features merely because they are stored here (Raposo, 2026a, 2026b).

The P11.4 captured result is quantified in [Validation](VALIDATION.md). The audio comparison retained a machine regression verdict. The final accepted configuration is identified separately by executable hash and runtime settings. The exact final source environment has not been reconstructed by this audit.

## Reconstruction use

Use the pinned upstream, review a patch's preimage and purpose, apply only a compatible conceptual change in a separate worktree, then build and validate the target. Do not apply these files blindly in filename order: some overlap, supersede earlier changes or add diagnostics. See [REPRODUCTION.md](REPRODUCTION.md).

## References

Raposo, M. (2026a). *Archived development records for The Minish Cap—RG34XX (27 August–5 September 2026)* (Evidence extract 1.0) [Data set]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/ede6e9090e7ca78c6c3a8c3d324d8c1de881f8b3/docs/evidence/2026-09-07

Raposo, M. (2026b). *H700 integration patches for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/90fd77a82d579de9460f2de1167a95ec264e57c3/patches
