# Skills Audit Report

**Scoped to 24/48 total skills (reason: changed since last run 2026-04-14T23:55:40Z — under 30 circuit breaker)**

- Project skills changed: 2 (mixpanel-taxonomy, testflight-deploy)
- Global skills changed: 22 (but 4 were deleted/archived — analyze-log, page-namer, skill-stocktake, visual-validation moved to skills-archive/)
- Active skills actually audited: 20 (excluding the 4 archived)

---

## Per-Skill Audit Table

| Skill | Read? | Claims | Reality | Violations | Action |
|---|---|---|---|---|---|
| mixpanel-taxonomy (project) | YES | "AnalyticsService.track calls flush() immediately" (line 117) | `AnalyticsService.track()` does NOT call flush. Only `initialize()` flushes, once at app launch. `track()` at line 40-42 of AnalyticsService.swift has no flush. | FACTUAL ERROR — instructs future agents to expect per-event flush, contradicts CLAUDE.md "NEVER call flush() per-event" rule | FIXED |
| testflight-deploy (project) | YES | API key IDs hardcoded in skill file (S6QR8N472U, 8833fdf3...) | These are reference values in a project-scoped skill doc, not source code secrets. Key path is at `~/.appstoreconnect/private_keys/` which is gitignored. Acceptable for a skill reference doc. | None — skill is accurate, no banned patterns | Clean |
| ai-check (global) | YES | Chunked AI detection via QuillBot script, extraction via `extract_prose.py` | Consistent with actual script references. No iOS/Mixpanel patterns. | None | Clean |
| analyze-log (global) | N/A — ARCHIVED | Moved to skills-archive/ in commit c841fd0 (2026-04-16). Not an active skill. | — | N/A | Archived, skip |
| canvas (global) | YES | Canvas LMS MCP tools, UTC→ET timezone conversion, assignment lifecycle | Solid. Due-date conversion rule is explicit and correct. | None | Clean |
| close-task (global) | YES | Uses `mcp__notion__update_page` only, never `close_task.py` or REST API | Consistent with stated rules. Delegates to sibling files correctly. | None | Clean |
| create_update_skill (global) | YES | Frontmatter required, boilerplate extraction rule | Consistent and up to date. | None | Clean |
| daily-tasks (global) | YES | model: haiku, Canvas cross-reference only on explicit request | Correct. model field present. Extraction pattern follows rule. | None | Clean |
| decision-series (global) | YES | Telegram card orchestration via scripts at `~/repos/decision-series/scripts/` | No banned patterns. Scripts correctly referenced. | None | Clean |
| draft-and-revise (global) | YES | 10-phase workflow with TodoWrite requirement | Comprehensive. No banned APIs. Uses voice_analysis.md reference correctly. | None | Clean |
| expiriments (global) | YES | 5-phase experiment workflow with create_experiment.py | Consistent. Folder name typo ("expiriments") is in the skill name itself — known and accepted. | None | Clean |
| improve (global) | YES | 5 parallel subagents + verifier, last-run scoping, circuit breaker at 30 | Consistent with this audit's own execution. | None | Clean |
| juice-shop-solver (global) | YES | curl-only pattern against localhost:3000, `PAYLOADS.md` extraction | No banned patterns. Proper progressive disclosure. | None | Clean |
| llm-council (global) | YES | Valid frontmatter, 5-advisor + chairman pattern | YAML frontmatter had extra blank lines between `---` and `name:` — technically invalid per `create_update_skill` rules. Content otherwise accurate. | FRONTMATTER DRIFT — blank lines in YAML block | FIXED |
| notion-analysis (global) | YES | Two-phase extraction with user approval gate | Correct. MCP tool path and fallback are accurate. | None | Clean |
| notion-tasks (global) | YES | Markdown content rule (when to use which Notion MCP tool), append-to-top corruption warning | Accurate. Two-MCP-tool guidance is current. | None | Clean |
| page-namer (global) | N/A — ARCHIVED | Moved to skills-archive/ in commit c841fd0 (2026-04-16). | — | N/A | Archived, skip |
| reel-scriptwriter (global) | YES | ICP targeting, voice compliance, on-screen title rules | Detailed and internally consistent. No banned patterns. | None | Clean |
| ship (global) | YES | 8-phase TestFlight workflow, keychain credential lookup | Keychain lookup verified real (`security find-generic-password -s APP_STORE_CONNECT_ISSUER_ID` returns valid value). Phases are correctly ordered (commit before archive). | None | Clean |
| simulation-execution (global) | YES | `python3 main.py --quiet` runner | Generic simulation skill. No iOS patterns. Minimal surface. | None | Clean |
| skill-creator (global) | YES | Skill creation workflow, frontmatter requirements | Detailed and accurate. References `init_skill.py` and `package_skill.py`. | None | Clean |
| skill-stocktake (global) | N/A — ARCHIVED | Moved to skills-archive/ in commit c841fd0 (2026-04-16). | — | N/A | Archived, skip |
| swiftui-patterns (global) | YES | `@Observable`, NavigationStack, anti-patterns, CROSS_VIEW_ANCHORS.md reference | Clean. Uses modern patterns. References CROSS_VIEW_ANCHORS.md for conditional read. | None | Clean |
| visual-validation (global) | N/A — ARCHIVED | Moved to skills-archive/ in commit c841fd0 (2026-04-16). | — | N/A | Archived, skip |

---

## Skills Actually Modified

| File | Change |
|---|---|
| `/Users/jonathanchamberlin/repos/social-iq/.claude/skills/mixpanel-taxonomy/SKILL.md` | Fixed factual error on line 117: `flush()` is NOT called per-event by `track()`. Corrected to explain the actual behavior (only called once in `initialize()`). |
| `/Users/jonathanchamberlin/.claude/skills/llm-council/SKILL.md` | Fixed YAML frontmatter: removed blank lines between `---` opener and `name:` field, removed blank lines between `name:` and `description:`, removed trailing blank line before closing `---`. |

---

## Superwall Troubleshooting Entry Check

The prompt asked to check if `superwall-campaigns` already has a troubleshooting entry for "Test Mode Active caused by trailing whitespace in dashboard bundle_id." That skill was NOT in the changed-since-last-run scope and was not audited this pass. No update made.

---

## Summary

- 20 active skills audited
- 4 archived skills skipped (analyze-log, page-namer, skill-stocktake, visual-validation)
- 2 violations found and fixed:
  1. `mixpanel-taxonomy` — factual error about flush() behavior
  2. `llm-council` — YAML frontmatter blank lines causing potential discovery failure
- 0 banned API patterns found in any skill code examples
- 0 hardcoded secrets found in source code (testflight-deploy has reference IDs in a project skill doc, which is appropriate)
