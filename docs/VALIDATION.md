# Validation: archived observations and current evidence limits

**Audit date: 7 September 2026. New hardware sessions in this audit: 0.** The values below come from archived development outputs, with timing and selected monitor statistics recalculated from the original numerical rows. See [EVIDENCE_AUDIT.md](EVIDENCE_AUDIT.md) for the complete method and interpretation (Raposo, 2026a).

## Build identity and acceptance scope

The final acceptance JSON dated 5 September identifies executable SHA-256 `787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`. The winner record gives size 8,858,736 bytes, backend `SDL_RENDERER`, no fullscreen-clear skip, and `TMC_RENDER_THREADS=3`. It records two automated soaks. The final acceptance separately records **one manual session**, operator visual `OK`, audio `OK` and machine QA `PASS`. These records do not establish a complete playthrough, independent multi-operator replication or leak-free execution (Raposo, 2026a).

## Timing comparison — 30 August 2026

**Table 1**  
*Recalculated capture statistics*

| Measure | P11.3 | P11.4 |
| --- | ---: | ---: |
| Ticks, n | 10,203 | 10,449 |
| Tick-lateness median, ms | 0.015637 | 0.002659 |
| Tick-lateness p95, ms | 5.790787 | 0.027887 |
| Tick-lateness maximum, ms | 70.186618 | 64.134375 |
| Presentation-call maximum, ms | 46.450584 | 60.917250 |
| Exactly one present per tick, % | 84.534 | 99.014 |

*Note.* Source: Raposo (2026a). Tick lateness is closure minus scheduled deadline, bounded at zero. Quantiles use linear interpolation at `(n − 1)q`; all rows are retained. There is one historical capture per variant, not n independent test runs. Identical gameplay sequences and randomisation were not established. The 1,920-frame audio setting in these captures differs from the later retained 1,600-frame setting.

The P11.4 patch changes the presentation scheduling period to the logical period. The capture supports a higher proportion of one-present ticks, not an invariant of one presentation on every tick. The reported 119.455 Hz panel mode is distinct from 59.7275 Hz game logic. No input-to-photon latency or complete stutter-removal result is claimed (Raposo, 2026a, 2026b).

## Audio comparison — 30 August 2026

The earlier P11.5 summary says **`AUDIO1600_MACHINE_AUDIO_REGRESSION`**. At 48 kHz, nominal buffer intervals changed from 40.000 ms (1,920 frames) to 33.333 ms (1,600 frames). The p95 of window-maximum work changed from 30.79 to 26.53 ms, while the maximum callback gap changed from 62.2 to 168.8 ms; logging windows numbered 172 and 228 respectively (Raposo, 2026a).

Heuristic event counts are not a count of audible defects. The later operator audio `OK` is reported alongside, not in place of, the earlier regression. Nominal buffer duration is not measured end-to-end audio latency.

## Runtime and temperature — final manual session, 5 September 2026

The selected ceilings are CPU 936 MHz and GPU 420 MHz. Reanalysis of **874 monitor samples** reproduced maximum temperature **52.6 °C** and confirmed matching CPU/GPU ceilings and reported 119.455 Hz in those samples. This is a session-specific maximum, not a temperature limit valid for all gameplay (Raposo, 2026a).

The post-session display was reported at 60.005 Hz. CPU/GPU maximum restoration markers passed; the CPU governor changed from pre-session `powersave` to post-session `ondemand`, so not every captured state variable was restored identically. The session logged game exit code 0 (Raposo, 2026a).

## Efficiency: objective versus measurement

The 1,416 → 936 MHz comparison is a **33.9% frequency-ceiling reduction**, not a power or battery-life percentage. The launcher's stock-maximum guard of 1,512 MHz is a different baseline. The Stage A record marks energy measurement ineligible and stores energy as null. A P13.1 comparison reports maximum temperature **+5.3 °C** and median RSS ratio **1.003497**. These data do not substantiate a general thermal or energy improvement (Raposo, 2026a, 2026c).

## Exit workaround and presentation scope

The archived D2 log ends with signal 11 after explicit subsystem shutdown. D3 reaches the `_Exit(0)` marker, and the later final session records exit code 0. The patched route is specific to the port's seamless target profile; the exact failed finalizer was not isolated (Raposo, 2026a, 2026b).

Source evidence documents menu shortcuts, hint suppression and quit handling. The launcher and final-session log document selected configuration. They are not substitutes for exhaustive perceptual conformance or a demonstration that an original GBA gameplay bug was fixed.

## What remains unestablished

No original-ROM gameplay-bug correction was identified in the reviewed material. There is no new device replication in this audit, universal device/CFW guarantee, measured native-versus-emulator advantage, measured battery saving or bit-for-bit rebuild of private V1. The source material, private executable, policy approvals and historical acceptance are separate authorities.

## References

Raposo, M. (2026a). *Archived development records for The Minish Cap—RG34XX (27 August–5 September 2026)* (Evidence extract 1.0) [Data set]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/ede6e9090e7ca78c6c3a8c3d324d8c1de881f8b3/docs/evidence/2026-09-07

Raposo, M. (2026b). *H700 integration patches for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/tree/90fd77a82d579de9460f2de1167a95ec264e57c3/patches

Raposo, M. (2026c). *Reference launcher for The Minish Cap—RG34XX* (Commit `90fd77a82d579de9460f2de1167a95ec264e57c3`) [Source code]. GitHub. https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh
