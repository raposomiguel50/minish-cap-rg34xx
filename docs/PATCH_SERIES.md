# What does each patch do?

A patch describes a source-code change. This map groups the **15 published patches** by purpose so you can find the relevant work.

**Do not apply them all in filename order.** They record different development stages. Some overlap, replace earlier approaches or only add diagnostics.

All patch links below use the fixed revision `90fd77a82d579de9460f2de1167a95ec264e57c3`.

## How to read the map

**Build** changes help create the target executable. **Instrumentation** adds measurements. **Experiments** test alternatives. A stored experiment is not automatically a selected feature.

The archive is not a complete final build recipe. Start with [Reconstruction](REPRODUCTION.md) before attempting a new executable.

## Interface provenance

The pinned upstream includes a [keyboard settings prompt](https://github.com/EstebanPdN/zelda-tmc-3ds/blob/e72663ca4059dabf9dbf7f03c36fc791d90b8db5/port/port_runtime_config.h#L284-L287): `Press F8 for settings`.

It also contains a separate [file-selection settings hint](https://github.com/EstebanPdN/zelda-tmc-3ds/blob/e72663ca4059dabf9dbf7f03c36fc791d90b8db5/src/fileselect.c#L1245-L1263), `L Settings`. These are different host-port interface paths, not elements of the original GBA game.

P09 and P10 record intermediate interface work. Their labels and bindings are historical, not recommended controls for the reference configuration.

For normal use, the relevant outcome is an unobstructed game image with settings available through `MENU+R2`. The patch history retains the intermediate labels and bindings.

## Build support

### P04_AARCH64_LINK_COMPLETENESS_R1

Adds the required source file and Linux/Android EGL/GLES links.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P04_AARCH64_LINK_COMPLETENESS_R1.patch)

### P04_FMT_PACKED_COLLISION_R1

Moves the fmt header before project headers.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P04_FMT_PACKED_COLLISION_R1.patch)

### P06_H700_CORTEX_A53_TARGET_R1

Adds ARMv8-A/SIMD and Cortex-A53 compiler targeting in its platform condition.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P06_H700_CORTEX_A53_TARGET_R1.patch)


## Controls and presentation

### P09_RG34XX_HANDHELD_POLISH_R1

Historical handheld input and menu labels; later work supersedes parts of it.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P09_RG34XX_HANDHELD_POLISH_R1.patch)

### P10_3_RG34XX_SEAMLESS_HIGH_REFRESH_R1

Adds MENU+L2/R2 routes and seamless UI. Its initial double-rate timing is historical.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_RG34XX_SEAMLESS_HIGH_REFRESH_R1.patch)

### P10_3_2_RG34XX_CLEAN_EXIT_FILESELECT_UI_R3

Combines quit handling, conditional post-shutdown _Exit and suppression of the host-port file-selection hint/L action.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_2_RG34XX_CLEAN_EXIT_FILESELECT_UI_R3.patch)


## Exit diagnosis and handling

### P10_3_1_EXIT_DIAG_R1

Adds exit/crash markers to locate a failure within the shutdown sequence.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1_EXIT_DIAG_R1.patch)

### P10_3_1D2_CLEAN_QUIT_UNWIND_R1

Propagates quit requests through main loops and waits.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1D2_CLEAN_QUIT_UNWIND_R1.patch)

### P10_3_1D3_RG34XX_POST_SHUTDOWN_EXIT_R1

Historical workaround: calls _Exit after shutdown. P10.3.2 refines the condition.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1D3_RG34XX_POST_SHUTDOWN_EXIT_R1.patch)


## Audio configuration

### P10_3_1_RG34XX_A53_AUDIO_R1

Selects linear resampling in one enhanced-audio branch; gbaAccurate retains nearest.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P10_3_1_RG34XX_A53_AUDIO_R1.patch)


## Timing measurement and scheduling

### P11_1_RG34XX_TIMING_INPUT_PRESENT_TRACE_R3

Defines tick, input and presentation trace records.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_1_RG34XX_TIMING_INPUT_PRESENT_TRACE_R3.patch)

### P11_2_RG34XX_HIGH_REFRESH_VSYNC_OFF_AB_R1

Tests a different high-refresh VSync policy.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_2_RG34XX_HIGH_REFRESH_VSYNC_OFF_AB_R1.patch)

### P11_3_RG34XX_PPU_PHASE_SPLIT_TRACE_R3

Adds presentation-phase markers used in the timing analysis.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_3_RG34XX_PPU_PHASE_SPLIT_TRACE_R3.patch)

### P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1

Sets the presentation period to the logical period in the selected path.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch)

### P11_7_RG34XX_PRODUCTION_LIKE_RUNTIME_POLICY_R1

Separates production-like settings from diagnostic pacing behaviour.

[Inspect this patch](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/patches/P11_7_RG34XX_PRODUCTION_LIKE_RUNTIME_POLICY_R1.patch)

## What additional evidence is needed?

A patch shows the code change. A test shows what happened when a particular build ran.

[Exit diagnostics](evidence/2026-09-07/log_excerpts.json) support the shutdown case. [Timing results](VALIDATION.md) describe the presentation comparison, including remaining delays.

The audio comparison retains a regression verdict. The final accepted build has its own identity and settings in the [acceptance record](evidence/2026-09-07/final_acceptance.json).

[Reconstruction](REPRODUCTION.md) lists the source and toolchain inputs still needed for a new build.

## How to study a patch safely

1. Check the pinned upstream source and the patch's original code context.
2. Read the purpose and related test before applying it.
3. Work in a separate copy, then build and test that change.

Keep the private V1 and saves untouched. Diagnostics and historical alternatives should not enter a release merely because they exist here.

**Next:** [Read the reconstruction requirements](REPRODUCTION.md).
