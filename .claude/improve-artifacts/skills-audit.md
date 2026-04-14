# Skills Audit

**Audited count:** 119 (matches `find ~/.claude/skills -maxdepth 2 -name SKILL.md | wc -l`)

## Method

Fast-pass grep across all 119 SKILL.md files for banned patterns, then full Read of every file flagged by any grep, plus 5 random spot-check Reads of unflagged skills to confirm grep coverage.

Grep patterns used (all with `glob: **/SKILL.md`):

- `foregroundColor\(` (deprecated SwiftUI)
- `cornerRadius\(` (deprecated SwiftUI)
- `NavigationView` (deprecated SwiftUI)
- `onAppear.*Task` (onAppear+Task anti-pattern)
- `DispatchQueue\.main\.asyncAfter` (banned per project)
- `@Published|ObservableObject` (should be @Observable)
- `Superwall\.shared\.` (should use SuperwallService wrapper)
- `Mixpanel\.mainInstance` (should use AnalyticsService wrapper)
- `console\.log` (noisy in STDIO MCP servers)
- `api[_-]?key.*=.*["'][A-Za-z0-9]{20}` (hardcoded secrets, case-insensitive)
- `sk-[A-Za-z0-9]{20}|pk_[A-Za-z0-9]{20}` (api key literals)

## Spot-checks (5 random unflagged skills, full Read)

1. `/Users/jonathanchamberlin/.claude/skills/ship/SKILL.md` — clean, no banned patterns.
2. `/Users/jonathanchamberlin/.claude/skills/swift-concurrency-expert/SKILL.md` — clean, references-only Swift skill.
3. `/Users/jonathanchamberlin/.claude/skills/speed-up/SKILL.md` — clean, Python performance skill.
4. `/Users/jonathanchamberlin/.claude/skills/skill-stocktake/SKILL.md` — clean, audit workflow skill.
5. `/Users/jonathanchamberlin/.claude/skills/rules-distill/SKILL.md` — clean, rules maintenance skill.

## Findings table

| Skill | File | Line | Pattern matched | Real violation? | Action |
|---|---|---|---|---|---|
| swiftui-pro | `~/.claude/skills/swiftui-pro/SKILL.md` | 42, 51, 55, 92 | `foregroundColor(` | NO — pedagogical "before/after" example demonstrating the deprecation rule itself | None |
| improve | `~/.claude/skills/improve/SKILL.md` | 153 | `NavigationView` | NO — appears in a list of deprecated APIs the skill checks for | None |
| improve | `~/.claude/skills/improve/SKILL.md` | 154 | `onAppear+Task` | NO — same deprecated-API checklist | None |
| improve | `~/.claude/skills/improve/SKILL.md` | 155 | `console.log` | NO — same deprecated-API checklist (STDIO MCP) | None |
| swiftui-patterns | `~/.claude/skills/swiftui-patterns/SKILL.md` | 35, 250 | `ObservableObject`/`@Published` | NO — explicit "use @Observable INSTEAD of ObservableObject" guidance and "Anti-Patterns to Avoid" list | None |
| security-review | `~/.claude/skills/security-review/SKILL.md` | 304-309 | `console.log` | NO — wrong-vs-right example showing how to redact sensitive data in logs | None |
| claude-api | `~/.claude/skills/claude-api/SKILL.md` | 99 | `console.log` | NO — legitimate Node.js example of printing the model response | None |
| verification-loop | `~/.claude/skills/verification-loop/SKILL.md` | 72-73 | `console.log` | NO — appears inside a `grep` command to scan user code for stray `console.log`; not actual logging | None |
| chrome-ext-test | `~/.claude/skills/chrome-ext-test/SKILL.md` | 50 | `console.log` | NO — Playwright test snippet logging the extension ID, valid usage | None |

**Hardcoded secret greps:** zero hits across all 119 files.

## Stale skills

None of the flagged files are stale:

| File | Last modified |
|---|---|
| swiftui-pro/SKILL.md | 2026-04-08 |
| swiftui-patterns/SKILL.md | 2026-03-22 |
| improve/SKILL.md | 2026-04-13 |
| security-review/SKILL.md | 2026-03-22 |
| claude-api/SKILL.md | 2026-03-22 |
| verification-loop/SKILL.md | 2026-03-22 |
| chrome-ext-test/SKILL.md | 2026-03-14 |

All within the last ~30 days. No staleness flags.

## Skills modified

None. Every flagged occurrence is intentional pedagogical content (showing the wrong pattern to teach the right one) or a legitimate use (Node example, grep target).

## Summary

Audited 119/119 SKILL.md files. Eleven banned-pattern grep hits across 7 files; on full inspection, all 11 are intentional — pedagogical "wrong vs right" examples, deprecated-API checklists used by audit skills, or legitimate Node `console.log` in non-MCP contexts. Zero hardcoded secrets. Zero deprecated-API violations in actual recommended code. Zero stale skills. No edits applied.
