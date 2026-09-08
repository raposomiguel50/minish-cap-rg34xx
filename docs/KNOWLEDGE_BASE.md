# Learn from the port

A guide to the problems, decisions and evidence behind the RG34XX integration.

**Use it to:** understand a change before copying an approach into another project. Each entry separates a result from a rule or open question.

**Reviewed:** 7 September 2026. **Scope:** the recorded RG34XX/muOS work, not every device or game version.

## Find a topic

| Your question | Start here |
| --- | --- |
| Where did the source come from? | [Foundation](#kb-mc-001) |
| How were menus and controls adapted? | [Controls](#kb-mc-004) |
| Did timing and audio improve? | [Timing](#kb-mc-005) · [Audio](#kb-mc-007) |
| Why use lower clocks? | [Energy evidence](#kb-mc-010) |
| What happened on exit? | [Shutdown](#kb-mc-013) |
| Can I rebuild or distribute it? | [Reconstruction](#kb-mc-015) · [Distribution](#kb-mc-016) |
| How do preservation decisions work? | [Principles](#kb-mc-021) |

**Reading key:** source = code inspection; record = archived observation; policy = a decision rule. Website-maintenance notes are grouped separately at the end.

[Glossary](GLOSSARY.md) · [Full results](VALIDATION.md) · [Open log questions](AUDIT_SUPPLEMENT_2026-09-07.md)

<a id="kb-mc-001"></a>
## KB-MC-001 — Which work is upstream?

**Type: source provenance.** The foundation is [EstebanPdN's Project Picori-derived fork](https://github.com/EstebanPdN/zelda-tmc-3ds/tree/e72663ca4059dabf9dbf7f03c36fc791d90b8db5). Its README credits the Android port, Project Picori and zeldaret.

This integration adds the H700 build configuration and handheld runtime setup.

**Use the lesson:** identify inherited code before describing your contribution. [Exact source pin](../SOURCE_BASELINE.json).

<a id="kb-mc-002"></a>
## KB-MC-002 — Does a host build prove the handheld works?

**Type: method.** No. Compiling on a development computer does not test the handheld's timing, audio or shutdown behaviour.

The [manual-session record](evidence/2026-09-07/final_acceptance.json) provides separate device observations.

**Use the lesson:** track build success and target-device acceptance separately.

<a id="kb-mc-003"></a>
## KB-MC-003 — What does the launcher set up?

**Type: source change.** The launcher loads PortMaster control helpers and selects an SDL2-backed shim where applicable. Its renderer preferences include opengles2/software.

These are platform-integration choices, not proof of compatibility with every firmware.

**Use the lesson:** inspect the runtime around the executable. [Pinned launcher](https://github.com/raposomiguel50/minish-cap-rg34xx/blob/90fd77a82d579de9460f2de1167a95ec264e57c3/launcher/The%20Minish%20Cap.sh).

<a id="kb-mc-004"></a>
## KB-MC-004 — How can port controls stay separate from the game?

**Type: integration choice with source and session evidence.** The reference keeps port instructions off the game image. The existing settings menu remains available through `MENU+R2`.

`MENU+L2` exits to muOS. These shortcuts use controls beyond the GBA set, leaving the original buttons assigned to gameplay.

The launcher selects Console-Parity and 3× scale. Port settings remain separate from the game's own interface.

**Use the lesson:** document where players find the function, why it is separate from gameplay and how that access was checked. [Patch map](PATCH_SERIES.md) · [Session excerpts](evidence/2026-09-07/log_excerpts.json).

<a id="kb-mc-005"></a>
## KB-MC-005 — Why separate game speed from screen refresh?

**Type: reanalysis.** The screen can refresh at about 119.455 Hz while game logic stays near 59.7275 Hz. They are different clocks.

P11.3/P11.4 recorded p95 tick lateness of **5.790787/0.027887 ms**. Their maxima were **70.186618/64.134375 ms**.

**Use the lesson:** explain the measured clock before calling a result “faster”. These are two captures, not a 120 FPS gameplay result. [Timing data](evidence/2026-09-07/reanalysis.json).

<a id="kb-mc-006"></a>
## KB-MC-006 — Does a one-present policy mean one present every tick?

**Type: source and record.** [P11.4](../patches/P11_4_RG34XX_SINGLE_PRESENT_119HZ_AB_R1.patch) sets `renderPeriodNs` to `tickPeriodNs` in the selected path.

The capture still has zero- and two-present ticks. Exactly-one-present ticks increased from **84.534% to 99.014%**.

**Use the lesson:** distinguish the scheduling rule from actual execution. [Full comparison](VALIDATION.md).

<a id="kb-mc-007"></a>
## KB-MC-007 — Can a later listening test cancel an earlier regression?

**Type: two recorded observations.** The P11.5 machine verdict was `AUDIO1600_MACHINE_AUDIO_REGRESSION`. The largest callback gap increased from **62.2 to 168.8 ms**.

The later manual session reports audio `OK`. The observations answer different questions and both remain relevant.

**Use the lesson:** retain instrumentation and listening results together. [Machine result](evidence/2026-09-07/audio_summary.json) · [Later acceptance](evidence/2026-09-07/final_acceptance.json).

<a id="kb-mc-008"></a>
## KB-MC-008 — Why does the launch context matter?

**Type: archived method and limitation.** AutoLab notes distinguish direct-SSH tests from a normal muOS Ports launch. Background conditions can differ.

The later procedure must not be assigned retrospectively to the earlier P11 timing pair. Matched scenes and randomised order were not established for that pair.

**Use the lesson:** record the actual test context. [Dated workflow notes](https://github.com/raposomiguel50/minish-cap-rg34xx/tree/5c306562615b1595ed49c7388dc768c8348b1296/docs/evidence/2026-09-07).

<a id="kb-mc-009"></a>
## KB-MC-009 — What did automation test?

**Type: recorded acceptance.** The records describe two automated soak runs and one manual gameplay session. Visual and audio acceptance are `OK` in that manual session.

Those are not three independent full playthroughs.

**Use the lesson:** name each test and what it can establish. [Acceptance record](evidence/2026-09-07/final_acceptance.json).

<a id="kb-mc-010"></a>
## KB-MC-010 — Is 33.9% less CPU frequency 33.9% less energy?

**Type: settings and records.** No. The comparison reduces the CPU ceiling from **1,416 to 936 MHz**. It does not measure the same percentage in energy.

GPU ceiling **420 MHz** was retained. Stage A energy fields are null/ineligible.

**Use the lesson:** report the variable actually measured. [Energy fields](evidence/2026-09-07/stage_a_winner.json) · [Baseline details](VALIDATION.md#efficiency-objective-versus-measurement).

<a id="kb-mc-011"></a>
## KB-MC-011 — Why keep worse results?

**Type: recorded result.** One P13.1 comparison has maximum temperature **5.3 °C higher** and median RSS ratio **1.003497**.

RSS is resident process memory. These values do not support a general reduction in heat or memory use.

**Use the lesson:** show trade-offs beside favourable measurements. [Winner record](evidence/2026-09-07/runtime_winner.json).

<a id="kb-mc-012"></a>
## KB-MC-012 — Did the experimental GPU renderer ship?

**Type: recorded selection.** The selected backend is `SDL_RENDERER`; `fullscreen_clear_skip=false`.

The existence of renderer experiments does not make them features of the selected build.

**Use the lesson:** distinguish investigated, rejected and selected approaches. [Selection record](evidence/2026-09-07/runtime_winner.json).

<a id="kb-mc-013"></a>
## KB-MC-013 — What was changed to avoid the exit crash?

**Type: patch and diagnostics.** D2 records signal 11 after subsystem shutdown. The target-specific route uses `_Exit(0)` after that shutdown; a later session exits with code 0.

This is a port workaround. The exact failing finalizer was not isolated.

**Use the lesson:** state which failure path was addressed. [Detailed exit case](EVIDENCE_AUDIT.md#2-exit-handling-a-port-defect-not-an-original-game-bug).

<a id="kb-mc-014"></a>
## KB-MC-014 — What does the executable hash prove?

**Type: metadata.** The acceptance record gives a SHA-256 fingerprint for private V1.

That identifies file contents. It does not prove a successful rebuild or correct gameplay.

**Use the lesson:** pair file identity with a build and test record. [Private V1 identity](REPRODUCTION.md#what-identifies-private-v1).

<a id="kb-mc-015"></a>
## KB-MC-015 — Is a patch archive a rebuild recipe?

**Type: publication limit.** No. Historical patches can overlap or supersede one another. Some exist only to measure behaviour.

A working rebuild needs target-device testing. A byte-identical rebuild also needs the complete source and toolchain environment. [Reconstruction status](REPRODUCTION.md) lists the missing inputs.

**Use the lesson:** check the required inputs first. [Reconstruction guide](REPRODUCTION.md).

<a id="kb-mc-016"></a>
## KB-MC-016 — Does private acceptance permit redistribution?

**Type: distribution boundary.** No. A working private executable and permission to distribute its dependencies are different requirements.

The recorded VirtuaAPU restriction remains unresolved.

**Use the lesson:** check dependency rights before packaging. [Recorded legal status](LEGAL_STATUS.md).

<a id="kb-mc-017"></a>
## KB-MC-017 — Can knowledge be shared without the executable?

**Type: publication policy.** Yes. Cleared patches, measurement definitions and selected evidence can explain the work without distributing the private binary.

The complete private archive is not automatically safe to publish.

**Use the lesson:** review documentation and binary distribution separately. [Available material](REPRODUCTION.md#what-is-available).

<a id="kb-mc-021"></a>
## KB-MC-021 — What is native execution for?

**Type: scope and policy.** It gives the port control over its build and integration. Linux, SDL and software models of GBA graphics/audio behaviour remain.

The available measurements compare configurations of the native port. A native-versus-emulator comparison would require matched workloads and separate measurements.

**Use the lesson:** use native execution to serve fidelity, not as an automatic performance claim. [Implementation limits](EVIDENCE_AUDIT.md#interpretation-and-limits).

<a id="kb-mc-022"></a>
## KB-MC-022 — Can restoration include original bug fixes?

**Type: approved policy.** A demonstrated technical bug is eligible for correction when compatible with the creative work.

Identify the defect, establish how to reproduce it, then test the correction against that case. Preserve ambiguous behaviour until its origin is understood.

**Use the lesson:** document the reproduction case, patch and test before reporting a completed fix. [Preservation principles](PHILOSOPHY.md).

<a id="kb-mc-023"></a>
## KB-MC-023 — Why choose defaults instead of exposing every adjustment?

**Type: policy with source examples.** A reference configuration gives the player an intentional starting point.

The reference separates port settings from gameplay and provides device-specific shortcuts. Each retained option needs a clear purpose within that setup.

**Use the lesson:** keep useful options accessible without requiring them to assemble the intended experience. [Current control changes](#kb-mc-004).

<a id="kb-mc-024"></a>
## KB-MC-024 — Why leave hardware capacity unused?

**Type: priority and recorded settings.** Fidelity and stability come first. Spare capacity can remain a reserve rather than become extra effects.

The accepted record uses CPU/GPU ceilings of **936/420 MHz**. Lower power and heat were goals; those settings alone do not establish savings.

**Use the lesson:** pursue efficiency without weakening the tested experience. [Acceptance](evidence/2026-09-07/final_acceptance.json) · [Energy limits](#kb-mc-010).

<a id="kb-mc-025"></a>
## KB-MC-025 — Must every historical defect become a user option?

**Type: approved policy.** No. Historical behaviour may be kept for comparison or research without becoming a normal play mode.

**Use the lesson:** preserve useful evidence without overwhelming the player with settings.

## Website and workflow maintenance

These three entries concern the publication workflow, not features or performance of the game.

<a id="kb-mc-018"></a>
## KB-MC-018 — Does local website QA mean the live site is fixed?

**Type: website-maintenance lesson, not a game test.** No. Candidate testing, repository publication, deployment and live verification are separate steps.

**Use the lesson:** verify the published artifact before closing a live issue.

<a id="kb-mc-019"></a>
## KB-MC-019 — When is automation useful?

**Type: workflow policy.** Use it for repeatable work or a clear reduction in risk. A small operation may be safer as a direct, auditable step.

**Use the lesson:** test the tool before asking someone to run it. Do not make the tool more complex than the task.

<a id="kb-mc-020"></a>
## KB-MC-020 — Should a missing result trigger another download or test?

**Type: workflow policy.** First inspect known local files and earlier results. The required artifact may already exist.

**Use the lesson:** verify and reuse existing evidence before repeating work.

## Improve an article

Report the entry ID, unclear passage and missing information through [GitHub issues](https://github.com/raposomiguel50/minish-cap-rg34xx/issues).

[How articles are maintained](DEVELOPMENT_METHOD.md) · [Inspect the detailed report](EVIDENCE_AUDIT.md)
