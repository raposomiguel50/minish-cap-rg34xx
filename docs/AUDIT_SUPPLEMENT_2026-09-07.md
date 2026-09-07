# Open diagnostic questions

**Purpose:** identify conflicts in the archived logs without guessing their cause.

**Reviewed:** 7 September 2026. These are documentary findings, not new device tests or new fixes.

The source is the [pinned launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh), plus the P13.1 log and monitor.

[Original paths and hashes](https://github.com/raposomiguel50/minish-cap-rg34xx/tree/e0f8c056bb94e8112a4b142b6addce78c9deb53b/docs/evidence/2026-09-07) identify the records. Line numbers below refer to the original log.

<a id="audio-buffer"></a>
## Was the audio buffer 1600 or 1920?

**Recorded:** the launcher requests `SDL_AUDIO_DEVICE_SAMPLE_FRAMES=1600`. It also prints `RG34XX_AUDIO_BUFFER_FRAMES=1920`. Log lines 2–3 repeat the mismatch.

**Known:** 1600 is the requested value. The printed message disagrees.

**Still needed:** the effective buffer size returned by the audio device. Neither string proves that value alone.

## Were save states fully inactive?

**Recorded:** line 22 describes save states as inert. Lines 94–95 and 101–102 record quicksave/autosave writes to ring slots 5 and 6.

**Known:** the same session contains both messages.

**Still needed:** which code paths govern manual save states and background autosave. They may differ, but the review did not establish that explanation.

## Did every system setting return to its old value?

**Recorded:** the CPU governor was `powersave` before the session and `ondemand` afterwards.

CPU maximum was 1,512,000 kHz before and after. GPU maximum was recorded as 0 before and after. The reported display mode returned to 60.005 Hz from 119.455 Hz.

**Known:** the reported limits and display mode matched their earlier values. The governor did not.

**Still needed:** the component responsible for the governor change. GPU maximum 0 is a recorded setting, not a physical running frequency of zero.

## What do the pointer warnings mean?

**Recorded:** lines 103–104 report `ResolveRomPtr` addresses `0x80034678` and `0x8003C28C` outside the ROM.

**Known:** the warnings occur in the accepted session.

**Still needed:** their origin and effect. The record alone does not prove harmlessness, a specific gameplay defect or a completed correction.

## Was first-run extraction instant?

**Recorded:** line 81 reports extraction completed in **102,799 ms**.

**Known:** this session does not support a claim of instant extraction. It is one observation, not a general startup benchmark.

## How should these findings be used?

The same log records `MENU+L2` exit and return code 0 at lines 131 and 135. The final manual acceptance records visual/audio `OK`.

Keep those observations alongside the conflicting messages. Acceptance does not erase a diagnostic conflict; a conflict does not establish its own diagnosis.

A later investigation must identify the effective value and relevant code path before claiming a cause or fix.

## Supporting files

[Log excerpts with original line numbers](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/e0f8c056bb94e8112a4b142b6addce78c9deb53b/docs/evidence/2026-09-07/P13_1_LOG_EXCERPTS.txt)

[Monitor calculations: `p13_1_monitor`](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/e0f8c056bb94e8112a4b142b6addce78c9deb53b/docs/evidence/2026-09-07/REANALYSIS.json)

[Final acceptance](evidence/2026-09-07/final_acceptance.json)

## Revision note

The earlier supplement retained the concurrent audit revision `d222705dad4ba8c5030fae49e64f2555c286a229`. The older competing draft did not replace it.

This editorial revision retains those observations and their evidence. It changes neither private V1 nor source patches, launcher, configuration pins or licences.

GitHub publication does not update the separate Honor project record. That local synchronization remains pending until verified.

**Next:** [Return to tests and results](VALIDATION.md).
