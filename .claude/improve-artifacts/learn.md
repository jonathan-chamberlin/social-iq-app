# Learn Report

**Run date:** 2026-04-21
**Window:** last 7 days (15 commits scanned: dac692f → 9fc7a45)

## Summary

One high-priority production-impacting finding from this session (Superwall "Test Mode Active" caused by ~85 invisible trailing spaces in the dashboard-registered bundle_id). Two 7-day-window patterns were already captured in CLAUDE.md during prior commits (68c319f captured coachmark + logging gotchas; 5567479 captured App Review 4.0 + simulator runtime gotchas) — no duplicate action needed.

The 3-strike rule means no new rule/skill files are created this run. One existing skill was extended (superwall-campaigns).

## Findings Table

| Pattern | Category | Times Seen | Action Taken | File Path |
|---|---|---|---|---|
| Superwall dashboard bundle_id trailing whitespace silently forces Test Mode in production (SDK uses strict `==`, UI renders trimmed, popup's `expected`/`got` strings both render trimmed so they look byte-identical) | framework-misunderstanding | 1 (this session) | Added Gotcha line to project CLAUDE.md; added "Troubleshooting: 'Test Mode Active' Overlay in Production" section to superwall-campaigns skill with diagnostic steps (query `mcp__superwall__list_projects`, inspect `repr()` + `len()`) and fix (retype in dashboard, don't paste) | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (line 166), /Users/jonathanchamberlin/repos/social-iq/.claude/skills/superwall-campaigns/SKILL.md (new section after "Debugging checklist" block) |
| App Review guideline 4.0 rejection from collecting a name TextField after Sign in with Apple | convention-gap | 1 (build 28 rejection) | Already captured by commit 5567479 prior to this run — no additional action | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (existing line 164) |
| iOS Simulator runtime build mismatch makes xcodebuild silently drop simulator destinations | framework-misunderstanding | 1 | Already captured by commit 5567479 prior to this run — no additional action | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (existing line 165) |
| `.ignoresSafeArea()` placed inside a GeometryReader offsets `.position()` math by safe-area inset | framework-misunderstanding | 1 (fixed by e1aa4c4) | Already captured by commit 68c319f prior to this run — no additional action | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (existing line 161) |
| `print()` is invisible to `start_sim_log_cap`; use UserDefaults + PlistBuddy round-trip or `os.Logger` | framework-misunderstanding | 1 | Already captured by commit 68c319f prior to this run — no additional action | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (existing line 163) |
| Screenshot eyeballing is insufficient verification for position-sensitive UI | recurring-anti-pattern | 2 (7d5a365 + 68c319f) | Already captured by commits 7d5a365 + 68c319f prior to this run — no additional action | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (existing lines 162, UI rule at bottom) |
| Launch/auth path network calls must use `withTimeout` + cached fallback | convention-gap | 1 (fixed by ff073fb) | Already captured in CLAUDE.md from previous /improve pass | /Users/jonathanchamberlin/repos/social-iq/CLAUDE.md (existing line 159) |
| App Store attribution links drift when agents reconstruct URLs | recurring-anti-pattern | 2+ | Jonathan self-fixed by committing a single-source-of-truth reference file (dc89bc2) — matches mechanical-mutations.md global rule | /Users/jonathanchamberlin/repos/social-iq/references/attribution-links.md |
| Internal dev testing polluting Mixpanel funnels | convention-gap | 1 (fixed by dac692f) | Self-fixed in commit — build_type + is_internal super properties registered in AnalyticsService.init | /Users/jonathanchamberlin/repos/social-iq/Social IQ/Services/AnalyticsService.swift |

## Files Actually Modified This Run

1. `/Users/jonathanchamberlin/repos/social-iq/CLAUDE.md` — appended Superwall trailing-whitespace gotcha (bottom of `## Gotchas`)
2. `/Users/jonathanchamberlin/repos/social-iq/.claude/skills/superwall-campaigns/SKILL.md` — inserted new `## Troubleshooting: "Test Mode Active" Overlay in Production` section between "Debugging checklist" and "Key placements"

## Files NOT Modified (and why)

- No new global rule files in `~/.claude/rules/` — no pattern hit the 3-strike threshold.
- No new skill files — existing skill (superwall-campaigns) was the correct home for the troubleshooting entry.
- Other 7-day patterns were already captured in CLAUDE.md by prior commits during the window (68c319f, 5567479, a0e824c) — not re-added.

## Observations / Meta

- Jonathan is now using in-commit gotcha-capture (`docs:` commits 68c319f, 7d5a365, 5567479) as a first-line learning loop before /improve runs. The /improve Learn phase should expect most 7-day patterns to be pre-captured and focus on surfacing session-fresh findings (like today's Superwall trailing-whitespace).
- The Superwall finding is a textbook framework-misunderstanding-that-is-not-our-fault: the remote SDK's strict string equality combined with the dashboard UI's visual trim makes this class of bug invisible by both standard diagnostics (popup text) and standard fixes (check Info.plist). The MCP-based diagnostic path (`list_projects` → `len()`) is the only reliable signal and is now documented.
