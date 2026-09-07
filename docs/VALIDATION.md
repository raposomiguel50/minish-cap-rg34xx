# What did the tests show?

The records show a targeted exit workaround, changes to menus and timing, and a later accepted device session.

They also contain delays, an earlier audio regression and unresolved diagnostic messages. This page keeps those results together.

**Evidence review:** 7 September 2026. **New hardware sessions in that review:** 0.

[Full method](EVIDENCE_AUDIT.md) · [Open questions](AUDIT_SUPPLEMENT_2026-09-07.md) · [Glossary](GLOSSARY.md)

## Which build was accepted?

The 5 September record identifies a private executable of **8,858,736 bytes**. It uses `SDL_RENDERER`, three rendering threads and no fullscreen-clear skip.

Its SHA-256 is:

`787ba3cb8c297ea44a0605745347fe5a6e792094f0be755b51a8200c1eadc710`

The records contain **one manual session**, visual/audio `OK`, machine checks `PASS`, and two preceding automated soak runs.

A soak is an automated run over time. It is not a human playthrough. These records do not establish a full-game, multi-operator or leak-free result.

[Acceptance record](evidence/2026-09-07/final_acceptance.json) · [Selected build](evidence/2026-09-07/runtime_winner.json)

## Did presentation timing improve?

**The recorded p95 improved; the largest presentation delay did not.**

A tick is one game-logic update. Tick lateness measures how late it ends relative to its scheduled deadline.

The p95 is the value at or below which about 95% of observations fall. It does not describe the worst case.

**Table 1**  
*Two timing captures from 30 August 2026*

| Measure | P11.3 | P11.4 |
| --- | ---: | ---: |
| Ticks recorded | 10,203 | 10,449 |
| Median tick lateness, ms | 0.015637 | 0.002659 |
| p95 tick lateness, ms | 5.790787 | 0.027887 |
| Maximum tick lateness, ms | 70.186618 | 64.134375 |
| Maximum presentation-call duration, ms | 46.450584 | 60.917250 |
| Ticks with exactly one presentation, % | 84.534 | 99.014 |

*Note.* Values come from [reanalysis.json](evidence/2026-09-07/reanalysis.json). All rows were retained. The calculation uses linear interpolation at `(n − 1)q`; [method and script](EVIDENCE_AUDIT.md#timing-analysis).

There is **one capture per variant**. The ticks are not independent test runs. Identical scenes and randomised order were not established.

Both captures used 1,920 audio frames. They must not be presented as tests of the later 1,600-frame configuration.

[P11.4](../patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch) changes the presentation period to one logic tick. The trace still contains ticks with zero or two presentations.

The screen mode is about 119.455 Hz; game logic remains about 59.7275 Hz. This is not 120 FPS gameplay or a button-to-screen latency measurement.

## What happened with audio?

The earlier P11.5 comparison received the machine verdict **`AUDIO1600_MACHINE_AUDIO_REGRESSION`**.

At 48 kHz, 1,920 and 1,600 frames represent nominal buffer intervals of 40.000 and 33.333 ms. These are not end-to-end sound latency measurements.

**Table 2**  
*Audio observations from 30 August 2026*

| Measure | Earlier setting | Candidate setting |
| --- | ---: | ---: |
| Logging windows | 172 | 228 |
| p95 of each window's maximum audio work, ms | 30.79 | 26.53 |
| Largest gap between callbacks, ms | 62.2 | 168.8 |

*Note.* Source: [audio_summary.json](evidence/2026-09-07/audio_summary.json). A callback supplies audio work. Warning counts are not literal counts of audible defects.

The later manual acceptance reports audio `OK`. That observation remains valid for its session; it does not erase the earlier regression.

[Later acceptance](evidence/2026-09-07/final_acceptance.json) · [Buffer-message discrepancy](AUDIT_SUPPLEMENT_2026-09-07.md#audio-buffer)

## What did the final monitoring record?

The selected ceilings were **CPU 936 MHz** and **GPU 420 MHz**.

Across **874 samples**, the recorded ceilings and 119.455 Hz mode matched the selection. The highest recorded temperature was **52.6 °C**.

This is a maximum from that session, not a guaranteed temperature limit for every scene.

After the session, the display reported 60.005 Hz. CPU/GPU limit-restoration markers passed, but the CPU governor changed from `powersave` to `ondemand`.

The game logged exit code 0. Not every recorded system setting returned to its original value.

[Monitor reanalysis](evidence/2026-09-07/reanalysis.json) · [Machine summary](evidence/2026-09-07/final_machine_summary.json) · [Log excerpts](evidence/2026-09-07/log_excerpts.json)

<a id="efficiency-objective-versus-measurement"></a>
## Did underclocking save energy?

**The records do not establish an energy saving.** Lower power and heat were goals of the selected configuration.

The change from 1,416 to 936 MHz is a **33.9% frequency-ceiling reduction**. It is not a battery-life percentage.

The launcher's 1,512 MHz stock-maximum guard is a different baseline. Do not mix these two comparisons.

Stage A records energy measurement as ineligible and energy as null. One P13.1 comparison records maximum temperature **5.3 °C higher**, with median RSS ratio **1.003497**.

RSS measures resident process memory. These observations do not establish generally lower heat or memory use.

[Stage A energy fields](evidence/2026-09-07/stage_a_winner.json) · [P13.1 comparison](evidence/2026-09-07/runtime_winner.json)

## Was the exit problem fixed?

D2 recorded signal 11 after explicit subsystem shutdown. D3 reached the new `_Exit(0)` route. The later accepted session ended with exit code 0.

This supports a **targeted workaround in the port**. The exact failing finalizer was not isolated. It is not evidence of fixing an original GBA bug.

[Exit evidence and source changes](EVIDENCE_AUDIT.md#2-exit-handling-a-port-defect-not-an-original-game-bug)

## What remains unproven?

The review does not establish an original-ROM gameplay-bug correction, measured native-versus-emulator gains, universal device support or a bit-for-bit rebuild.

These limits apply to the records reviewed. They do not replace the documented changes and session results above.

**Next:** [Read the unresolved diagnostic questions](AUDIT_SUPPLEMENT_2026-09-07.md).
