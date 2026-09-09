# ~120 Hz display mode on the RG34XX

The launcher selects a **119.455 Hz display mode** for the RG34XX with muOS. Game logic keeps its **59.7275 Hz** cadence.

The display rate is twice the logic rate. The game keeps its original pace; this is not 120 FPS game logic.

## Why 119.455 Hz rather than exactly 120?

Twice 59.7275 is 119.455. This gives the configured display and logic rates a 2:1 relationship without changing the game's update rate.

The original 240 × 160 image is scaled to 720 × 480 at an exact 3×. The higher display mode does not add detail to the artwork.

## How the mode is applied

The launcher reads the existing display geometry and timings with `fbset`. It stores those timings before selecting the higher-refresh mode for the game session.

The switch is limited to the expected RG34XX geometry. The launcher checks that the reported rate is between 119.3 and 119.6 Hz.

If the check fails, it restores the earlier timings and disables the high-refresh flag. On exit, cleanup restores the captured display timings. A separate watchdog covers unexpected loss of the launcher process.

The wrapper changes runtime display timings, not the boot configuration. This setup belongs to the tested RG34XX/muOS integration; it is not a general specification for every RG34XX firmware.

[Display wrapper source](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh#L121-L198)

## What was recorded?

| Item | Recorded value |
| --- | --- |
| Display mode during the final monitored session | 119.455 Hz |
| Monitoring samples | 874 |
| Samples meeting the high-refresh check | 874 / 874 |
| Display mode after the session | 60.005 Hz |
| Game-logic rate | 59.7275 Hz |

These are software-reported display timings and runtime records. They are not a separate optical measurement of the panel or of button-to-screen latency.

[Monitoring results](evidence/2026-09-07/final_machine_summary.json) · [Reanalysis and source hashes](evidence/2026-09-07/reanalysis.json) · [Session evidence](VALIDATION.md#what-did-the-final-monitoring-record)

## Display refresh and frame presentation

P11.4 schedules presentation at one logic period. Display refresh and software presentation calls are different operations.

The recorded P11.4 capture contains ticks with zero, one or two presentation calls. A configured 2:1 rate relationship does not guarantee that each game image reaches the panel exactly twice.

The P11.3/P11.4 timing comparison concerns presentation scheduling within the high-refresh setup. It is not a controlled 60-versus-120 Hz benchmark.

[Presentation patch](../patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch) · [Timing measurements](VALIDATION.md#did-presentation-timing-improve)
