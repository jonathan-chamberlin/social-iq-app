---
name: superwall-campaigns
description: Configure Superwall paywalls, placements, and A/B tests for Social IQ. Trigger on: "paywall", "superwall", "subscription", "monetization", "paywall test".
---

# Superwall Campaigns for Social IQ

## Current Live Setup

**Paywall:** Social IQ Pro (ID 203822) — used by both campaigns below
- Annual: $29.99/year (42% savings)
- 6 Months: $4.99/6mo (22% savings)
- Product ID: `com.jonathanchamberlin.socialiq.annual`

**Active Campaigns:**
| Campaign | ID | Placement | Paywall |
|----------|-----|-----------|---------|
| Onboarding Paywall | 78286 | `onboarding_complete` | 203822 (100%) |
| Lesson Locked | 78288 | `lessons_locked` | 203822 (100%) |
| Transaction Abandoned | 78289 | (no placement yet) | (no paywall yet) |
| Example Campaign | 75153 | `campaign_trigger` | 195191 (100%) |

## MCP API Limitations

The Superwall MCP can manage campaigns, placements, products, and entitlements — but **cannot edit paywall visual content** (text, layout, design). Paywall copy is edited in the Superwall dashboard visual editor only.

**Known MCP bugs (as of 2026-04-04):**
- `get_paywall` and `list_paywalls` fail with a schema error on the `products` field (expects string, gets object)
- `create_paywall` has the same products type mismatch

**Workaround for visual edits:** Generate a step-by-step prompt for Claude Chrome (browser) to click and replace text elements in the Superwall dashboard editor.

## Paywall Copy Source

Paywall copy decisions should be informed by user research. Read `user-research/synthesis.md` for:
- What ICP users validated (positive signals to protect)
- The #1 complaint ("feels like a test" — 50%) — avoid quiz/test language on paywalls
- ICP-B paywall demand signal (Pattern 14) — Lauren, Sana, Phoebe were disappointed by locked lessons
- Gender-neutral copy requirement (Pattern 12) — "people" not "guys"

## Key placements

### lessons_locked (live — primary conversion point)
Fires when a free user taps a locked lesson. This is where ICP-B showed visible demand.
```swift
Superwall.shared.register(placement: "lessons_locked")
```

### onboarding_complete (live — first paywall exposure)
Fires at the end of onboarding. Keep it soft — user hasn't seen value yet.
```swift
Superwall.shared.register(placement: "onboarding_complete")
```

### transaction_abandoned (not yet configured)
Fires when a user starts checkout but doesn't complete. Shows a discounted offer or urgency message. Highest impact placement (17-25% revenue lift) — configure once payment pipeline is live.
```swift
Superwall.shared.register(placement: "transaction_abandoned")
```

### paywall_close (future)
Fires when user dismisses a paywall without subscribing. Shows a "last chance" or alternative offer.
```swift
Superwall.shared.register(placement: "paywall_close")
```

### session_milestone (future)
Fires after a user completes N lessons (e.g., 3rd or 5th). They've seen value, now convert.
```swift
Superwall.shared.register(placement: "session_milestone", params: ["lesson_count": count])
```

## Age-segmented routing (App Mafia insight)
- 23-28 is the highest conversion bracket for self-improvement apps
- Route different paywall designs by age segment via Superwall's user attributes
```swift
Superwall.shared.setUserAttributes([
  "age_bracket": ageBracket, // "18-22", "23-28", "29-35", "36+"
  "subscription_status": status
])
```

## The 5 test levers (test ONE at a time)
1. **Price** — $4.99/wk vs $9.99/mo vs $39.99/yr
2. **Design** — Minimal vs feature-rich vs social proof heavy
3. **Messaging** — Pain-focused vs outcome-focused vs urgency
4. **Personalization** — Generic vs name/goal-specific
5. **Frequency** — How often paywalls appear (every 3rd feature vs every feature)

## Rules
- Never show a paywall before the user has completed at least 1 lesson
- Always track paywall_viewed and paywall_converted in Mixpanel alongside Superwall
- transaction_abandoned should fire ONCE per session, not repeatedly
- Test one lever at a time — simultaneous tests contaminate results

## Post-task reflection

After completing a Superwall task, check:
1. Did I encounter an MCP error this skill didn't anticipate? → Update the "MCP API Limitations" section.
2. Did the user override my approach? → Update the relevant section.
3. Did campaign/paywall IDs change? → Update the "Current Live Setup" table.
