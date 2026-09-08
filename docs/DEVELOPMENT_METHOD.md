# How work becomes reusable knowledge

**Purpose:** help readers understand a result, find its evidence and use the lesson without repeating avoidable mistakes.

**Owner:** project maintainer. **Reviewed:** 7 September 2026. These are the reporting rules for this project.

## Start with the reader's task

The overview answers what the project is and what is available. The learning guide explains decisions. The technical report preserves methods and evidence.

Readers should not need the full audit to understand the project. They should not lose access to the audit when a summary is shortened.

This approach adapts ITIL's focus on value and practical simplicity. Guidance on knowledge management also treats knowledge as something to review and improve, not merely store (PeopleCert, n.d.; Singh, 2026).

The article structure and review process below apply these principles to the project.

## Give each topic one main home

Keep the complete explanation in one maintained article. Use short summaries and links elsewhere.

Use stable article IDs, descriptive headings and ordinary search terms. Explain specialist words at first use or link to the [glossary](GLOSSARY.md).

Keep filenames and revision IDs in evidence links. Do not make the reader decode them before learning what the topic means.

## Check relevance and origin

Before publishing a claim, identify its layer: the released GBA game, inherited port software, an intermediate development step or the accepted handheld configuration.

Lead with what the reader can use or learn. An accurate patch description is not automatically a useful project headline.

Describe the final behaviour and its purpose. Keep provisional labels, discarded bindings and debugging steps in the patch history when they aid maintenance.

Do not present removing development scaffolding as repairing the original game. Do not attribute an inherited interface or fix to this integration.

Keep website-maintenance lessons separate from game results. Preserve their evidence without making them the public story of the port.

For each summary, ask: what question does this answer, which baseline supports it, and where can the reader check it?

## Capture the lesson during the work

Record the question, affected platform, source revision and observed symptom.

Then record the change, tested build, result and remaining uncertainty. Retain failed attempts when they explain why an approach was rejected.

Reuse an existing article when it already covers the topic. Do not create another account of the same result unless the context genuinely differs.

## Use a short article structure

**Question:** what does the reader need to understand or decide?

**Answer:** state the useful conclusion first.

**What changed:** describe the specific intervention or decision.

**Evidence and limits:** link the source and explain what the observation does not establish.

**Use this lesson:** give the next useful action or reading link.

Include only fields that help the reader. Do not add empty sections to satisfy a template.

## Keep the status clear

| Label | Meaning |
| --- | --- |
| Source change | Visible in a patch or configuration |
| Recorded result | Present in an archived test output |
| Reanalysis | Calculated again from existing data |
| Project policy | An approved rule, not a completed feature |
| Open question | Evidence is incomplete or conflicting |

A successful command does not prove every property of its output. A policy does not demonstrate that a feature was implemented.

## Review, publish and maintain

Draft the article from the evidence. Check it against the source, then review readability and scope before publication.

Keep the evidence date separate from the editorial review date. Revising prose does not create a new hardware test.

When evidence changes, update the main article and its summaries together. Mark superseded advice and link its replacement; retain the historical record.

A reader can flag an unclear passage through [GitHub issues](https://github.com/raposomiguel50/minish-cap-rg34xx/issues). Record what was unclear and whether the revision resolved it.

Assess usefulness through actual feedback and whether readers find the answer they need. File counts and paragraph lengths are checks, not proof of understanding.

## Write for understanding

Describe the project in its own voice. State the decision, implementation or measured result directly. Keep editorial review notes and writing corrections in the maintenance record.

Use short sentences and one idea per paragraph. Aim for one to three sentences per paragraph; keep technical detail in its own section.

Lead with the answer. Prefer “The session ended with code 0” to a general claim that shutdown is reliable.

Explain the purpose of a change before its implementation details. Keep a result and its important limitation together.

Use descriptive links, not repeated “click here” instructions. Avoid promotional claims, defensive disclaimers and unexplained abbreviations.

## Preserve attribution without self-citation

Use the project's own voice for its decisions. Link internal results directly to files, revisions, tables or log lines.

Do not turn the author's name or the Lab into a repeated bibliographic citation. Do not quote informal conversations as scholarly claims.

Use APA-style references for external works used in the text. Credit upstream contributions separately from this integration's changes.

## Check before publishing

Verify that links resolve, measurements retain their units, and summaries agree with the detailed evidence.

Check that limitations and negative results remain accessible. Confirm that shortening the text has not changed a policy into a completed result.

Search for reintroduced self-citations. Keep unrelated files, private builds, music and site styling outside an editorial change.

Test navigation and layout on a narrow screen. Readability checks cannot replace feedback from real readers.

## Responsibility and continuity

I define the goals, preservation criteria and acceptance decisions. ChatGPT assists with code, analysis and documentation. Generated output needs review before adoption.

Work on a separate copy. Preserve the prior revision and record actions, success, failure and the next step outside the conversation.

Repository publication, website deployment and local Honor records are separate states. Do not mark the Honor record as updated without a verified local write.

**Next:** [Apply this structure to the practical lessons](KNOWLEDGE_BASE.md).

## External references

PeopleCert. (n.d.). *ITIL 4: Guiding principle*. https://www.peoplecert.jp/ITIL4_c_gp.html

Singh, A. (2026, February 10). *How ITIL (Version 5) and AI are redefining the service desk*. PeopleCert Community. https://community.peoplecert.org/public/clubs/itil/blogs/how-itil-version-5-and-ai-are-redefining-the-service-desk-2026-02-05
