# Detailed evidence report

**Scope:** H700/RG34XX integration of *The Minish Cap*.  
**Evidence review:** 7 September 2026. **New device tests:** 0.

Use this report to inspect the method, exact source changes and full numerical results. For a shorter explanation, start with [Tests and results](VALIDATION.md).

## Summary

The material comprises 15 historical patches, a launcher and selected development records. The sections below describe the source changes and their recorded results.

The records support build changes, menu/input integration, a targeted exit workaround and a later accepted device session. Timing and audio results remain mixed.

Test coverage is limited to the recorded RG34XX/muOS sessions. Energy measurements and a complete build recipe remain unavailable.

## Method

### Scope and sources

The source reference is commit `90fd77a82d579de9460f2de1167a95ec264e57c3`.

Source inspection covered all 15 patches by changed file and hunk, followed by a separate examination of the launcher. Git blob identifiers matched the archive copies.

Test outputs came from the archived sessions. The numerical analysis used those existing records; no test scripts were rerun.

[Patch inventory](PATCH_SERIES.md) · [Pinned launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh) · [Source index and calculations](evidence/2026-09-07/reanalysis.json)

The supplied archive contains **3,593 entries**. Its SHA-256 is:

`07ae7e1be8aed80dc9494c084d3ac5bfb5b60be186f6778344bec8fb7393ca10`

The source index identifies the archive and selected members. Matching hashes establishes consistency of the files reviewed, not independent authentication of the original sessions.

### Evidence categories

| Category | Meaning |
| --- | --- |
| Source change | Visible in a specified patch or launcher |
| Recorded observation | Present in a named archived output |
| Reanalysis | A statistic recalculated from archived rows |
| Policy | An approved decision rule |
| Not established | Insufficient evidence for the proposed claim |

A patch does not prove successful execution or inclusion in every later build.

### Timing analysis

The P11.3 and P11.4 captures are dated **30 August 2026**. All `X` records were included. No warm-up rows or outliers were removed.

**Tick lateness:** recorded tick-closure time minus its scheduled deadline, bounded at zero. Nanoseconds were converted to milliseconds.

**Quantiles:** linear interpolation at sorted position `(n − 1)q`.

**Presentation duration:** elapsed time between matched `PRESENT_BEGIN` and `PRESENT_END` markers with the same sequence identifier.

[Instrumentation definitions](PATCH_SERIES.md) · [Calculation script](evidence/2026-09-07/reanalyse.py)

There is **one capture per variant on one device**. Ticks are repeated observations within each capture, not independent experiments.

Randomisation, identical gameplay sequences and matched scenes were not established. The comparison is descriptive: no significance test or causal effect estimate is reported.

## Results

### 1. Build and architecture integration

**P04 link completeness:** adds `port/port_cloud_tops_fight.c` to `tmc_pc`. It also links EGL/GLESv2 on Linux/Android without the earlier GPU-renderer condition.

**P04 header order:** moves `fmt/format.h` before project headers.

**P06 targeting:** adds `-march=armv8-a+simd` and `-mtune=cortex-a53` to C/C++ flags in its Linux, non-x86 condition.

The [patch map](PATCH_SERIES.md) links each build change at its exact revision.

The foundation is [EstebanPdN's `zelda-tmc-3ds` fork](https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5). Its README credits the Android port, Project Picori and zeldaret.

The [pinned upstream](https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5) already contains EstebanPdN's Cloud Tops regional-flag change for its PC-port/multi-region path.

The H700 patch adds that existing upstream source to the build.

[Source baseline](../SOURCE_BASELINE.json) · [Link-completeness patch](../patches/P04_AARCH64_LINK_COMPLETENESS_R1.patch)

<a id="2-exit-handling-a-port-defect-not-an-original-game-bug"></a>
### 2. Shutdown handling

**D2, lines 302–303:** `MENU+L2`, completed subsystem-shutdown markers, `BEFORE_RETURN_0`, then `RAW_CRASH sig=11`.

**D3, lines 186–187:** the same shutdown sequence reaches `BEFORE_RG34XX__EXIT_0`, without that crash marker.

**Later final session:** `RG34XX_GAME_EXIT_RC=0`.

The patches propagate a quit request through waits and main loops. The seamless RG34XX profile then uses `_Exit(0)` after explicit subsystem shutdown.

This supports a targeted workaround and successful exit in those recorded sessions. The exact failing finalizer was not identified.

`D3_EXIT_VERDICT.txt` is empty. The observations above come from the D2/D3 traces and the later session log.

[Diagnostic excerpts](evidence/2026-09-07/log_excerpts.json) · [Exit patches](PATCH_SERIES.md)

### 3. Presentation and controls

P10.3 introduces `MENU+R2` for settings and `MENU+L2` for exit. The final session reports those mappings.

P10.3.2 suppresses a host-port file-selection hint and its L-button sidebar action in the seamless profile. The settings implementation remains available through the handheld shortcut.

The [patch map](PATCH_SERIES.md#interface-provenance) distinguishes the upstream keyboard prompt from that separate file-selection path. Neither belongs to the original GBA interface.

Port settings remain accessible without instructional messages over the game.

The launcher selects `--window_scale=3 --console-parity`. The final log reports widescreen disabled, pacing at 59.7275 Hz and three OpenMP scanline threads.

It also describes save states as inert. Later autosave messages require the qualification in the [diagnostic supplement](AUDIT_SUPPLEMENT_2026-09-07.md).

The screen is 720 × 480. Scaling the game's 240 × 160 image by three fits those dimensions.

These source and log observations are not an exhaustive pixel, sound or control-conformance test.

[Patch map](PATCH_SERIES.md) · [Session excerpts](evidence/2026-09-07/log_excerpts.json)

### 4. Timing comparison

**Table 1**  
*Recalculated statistics from two historical captures*

| Measure | P11.3 | P11.4 |
| --- | ---: | ---: |
| Recorded ticks, n | 10,203 | 10,449 |
| Tick-lateness median, ms | 0.015637 | 0.002659 |
| Tick-lateness p95, ms | 5.790787 | 0.027887 |
| Tick-lateness maximum, ms | 70.186618 | 64.134375 |
| Matched presentation calls, n | 10,187 | 10,426 |
| Presentation-call median, ms | 7.469125 | 0.569417 |
| Presentation-call p95, ms | 13.489475 | 2.028771 |
| Presentation-call maximum, ms | 46.450584 | 60.917250 |
| Ticks with exactly one presentation, % | 84.534 | 99.014 |

*Note.* Source paths, hashes and unrounded values are in [reanalysis.json](evidence/2026-09-07/reanalysis.json). Values are rounded for display. Both captures used 1,920 audio frames, not the later 1,600-frame setting.

P11.3 contains 798 zero-present, 8,625 one-present, 778 two-present and 2 three-present ticks.

P11.4 contains 63 zero-present, 10,346 one-present and 40 two-present ticks.

The lower p95 coexists with a **higher maximum presentation-call duration** in P11.4. Delays remain in the data.

[P11.4](../patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch) sets the presentation period to one logical tick rather than half a tick in the selected profile.

“Single-present policy” describes that scheduling change. It does not mean exactly one presentation occurred on every tick.

The reported panel mode is about 119.455 Hz, not 120 FPS game logic. These are not button-to-screen latency or complete stutter-removal results.

### 5. Audio comparison

At 48,000 samples/s, 1,920 frames represent 40.000 ms; 1,600 frames represent 33.333 ms. These are nominal buffer intervals, not end-to-end latency.

The P11.5 machine summary reports **`AUDIO1600_MACHINE_AUDIO_REGRESSION`**. It contains 172 baseline and 228 candidate logging windows.

The p95 of per-window maximum audio work fell from **30.79 to 26.53 ms**. The largest callback gap rose from **62.2 to 168.8 ms**.

Heuristic event counts are not literal audible-underrun counts.

The 5 September acceptance later records operator audio `OK` with the 1,600-frame configuration. It does not erase the earlier regression or cover every possible scene.

[Machine comparison](evidence/2026-09-07/audio_summary.json) · [Later acceptance](evidence/2026-09-07/final_acceptance.json)

The [audio patch](../patches/P10_3_1_RG34XX_A53_AUDIO_R1.patch) selects linear resampling in one RG34XX enhanced-audio branch. The `gbaAccurate` branch retains nearest resampling.

That conditional change does not establish the same resampler in every mode.

### 6. Final configuration and acceptance

**Table 2**  
*Selected private build and runtime settings*

| Item | Recorded value |
| --- | --- |
| Executable size | 8,858,736 bytes |
| CPU ceiling | 936 MHz |
| GPU ceiling | 420 MHz |
| Audio configuration | 1,600 frames requested |
| Rendering threads | `TMC_RENDER_THREADS=3` |
| Backend | `SDL_RENDERER` |
| Fullscreen-clear skip | Not selected |

*Note.* Sources: [final acceptance](evidence/2026-09-07/final_acceptance.json) and [winner record](evidence/2026-09-07/runtime_winner.json). The requested audio size is distinct from the negotiated device value.

Executable SHA-256:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

Acceptance includes one manual session with visual/audio `OK`. Two recorded automated soaks are not two additional human playthroughs.

### 7. Monitoring and efficiency

The final monitor has **874 samples**. Recorded CPU/GPU ceilings and 119.455 Hz mode match the selected configuration throughout those samples.

Maximum recorded temperature is **52.6 °C**. The recorded CPU-governor ratio is **0.993135**, not 1.0.

After the session, the display reports 60.005 Hz. CPU/GPU maximum-restoration markers report success.

The governor changes from `powersave` before the session to `ondemand` afterwards. Restoration of every system setting is therefore not established.

[Monitor reanalysis](evidence/2026-09-07/reanalysis.json) · [Machine summary](evidence/2026-09-07/final_machine_summary.json)

The earlier 1,416-to-936 MHz ceiling comparison is a **33.9% frequency reduction**. The launcher's expected stock maximum of 1,512 MHz is a different baseline.

Stage A stores `energy_eligible=false` and `energy_mwh=null`.

One P13.1 comparison reports maximum temperature **5.3 °C higher** and median RSS ratio **1.003497**.

Lower power and heat remain engineering objectives. These records do not establish measured energy savings or a general temperature reduction.

[Stage A](evidence/2026-09-07/stage_a_winner.json) · [P13.1 comparison](evidence/2026-09-07/runtime_winner.json)

### 8. Acceptance and promotion are separate events

The earlier acceptance JSON says `stable_promotion=false`.

Later V1 marker files dated 5 September record promotion identity, one visible game tree/menu entry and `STABLE_V1_VERIFY=PASS`.

These are different stages, not interchangeable status messages. Both remain in the record.

[Acceptance JSON](evidence/2026-09-07/final_acceptance.json) · [Marker excerpts](evidence/2026-09-07/log_excerpts.json)

## Interpretation and limits

The source changes concern build configuration, shutdown handling, menus, audio and presentation timing. The timing comparison describes two captures on one device.

Coverage is limited to the recorded sessions. No end-to-end input-latency test, energy measurement or full playthrough is included. Additional devices and firmware require separate validation.

A byte-identical rebuild still requires the missing source and toolchain inputs listed in [Reconstruction](REPRODUCTION.md).

Native game logic uses Linux, SDL and software reproduction of GBA graphics/audio behaviour. The available performance measurements compare configurations of this native path.

Future original-game bug corrections remain eligible under the approved policy. Each needs its own symptom, reproduction case, source change, build identity and before/after test.

## Data access

The public patch archive is not the complete final build tree. This analysis used archived outputs rather than a new build or device session.

Selected machine records, hashes and the analysis script are public. Full raw traces remain in the private development archive.

This is an archival technical review, not independent peer review or hardware replication.

**Next:** [Inspect unresolved log questions](AUDIT_SUPPLEMENT_2026-09-07.md) or [return to the learning guide](KNOWLEDGE_BASE.md).


[RG34XX hardware specifications](https://anbernic.com/en-fr/products/rg34xx)
