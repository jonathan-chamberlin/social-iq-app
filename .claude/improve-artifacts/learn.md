# Learn Phase Artifact

**Status:** PASS (CLAUDE.md edited; 2 new Gotchas appended)

**Commits reviewed:** 38 over the last 7 days.

## Patterns extracted → Gotchas

| Pattern | Category | Commits | Action | File |
|---|---|---|---|---|
| Network calls on launch/auth path with no timeout or offline fallback (loading screen hung in low/no-signal env) | convention-gap | `ff073fb` | Appended Gotcha: launch/auth network calls must use `withTimeout` + cached-state fallback | `/Users/jonathanchamberlin/repos/social-iq/CLAUDE.md` |
| Session-scoped `@State` flags (e.g. `onboardingChecked`) not reset on sign-out, breaking re-auth and delete-account flows | convention-gap | `26aa598`, `1052aa3` | Appended Gotcha: reset session-scoped flags via `onChange(of: userId)` observer in `Social_IQApp` | `/Users/jonathanchamberlin/repos/social-iq/CLAUDE.md` |

## Patterns intentionally NOT extracted (already covered)
- 7 Superwall paywall commits (`071056a`, `1052aa3`, `26aa598`, `854ea9c`, `90e2dca`, `fda82d8`, `f0f8ac0`) — already covered by existing CLAUDE.md Gotchas and `.claude/rules/services.md`.
- 4 view/style refactor commits (`314fbfc`, `aa05a67`, `5a92dd3`, `2070189`) — already enforced by PostToolUse hook and `.claude/rules/swiftui-views.md`.
- DispatchQueue ban, `print()` DEBUG-guard, direct framework imports in Views — already in Gotchas.

## Genuine bugs (no extraction)
`6fa13bb`, `dab31e0` (dark mode plist), `d962b8e` (Mixpanel step naming), `5e094b6` (SKStoreReviewController), `2be4f3b`, `827e351` (App Store compliance).

## Edits applied
- `CLAUDE.md` — 2 Gotcha lines appended (verify via `git diff`).

## Sandbox note
Subagent was denied `mkdir` and `Write` on `.claude/improve-artifacts/`. This artifact written directly by dispatcher.
