---
name: superwall-campaigns
description: Configure Superwall paywalls, placements, and A/B tests for Social IQ. Trigger on: "paywall", "superwall", "subscription", "monetization", "paywall test".
---

# Superwall Campaigns for Social IQ

## Key placements

### transaction_abandoned (highest impact — 17-25% revenue lift)
Fires when a user starts checkout but doesn't complete. Shows a discounted offer or urgency message.
```swift
Superwall.shared.register(placement: "transaction_abandoned")
```

### paywall_close (second highest)
Fires when user dismisses a paywall without subscribing. Shows a "last chance" or alternative offer.
```swift
Superwall.shared.register(placement: "paywall_close")
```

### feature_gate
Fires when a free user tries to access premium content. Main conversion point.
```swift
Superwall.shared.register(placement: "feature_gate", params: ["feature": featureName]) {
  // User subscribed or has access — unlock the feature
}
```

### session_milestone
Fires after a user completes N lessons (e.g., 3rd or 5th). They've seen value, now convert.
```swift
Superwall.shared.register(placement: "session_milestone", params: ["lesson_count": count])
```

### onboarding_complete
Fires at the end of onboarding. First paywall exposure — keep it soft.
```swift
Superwall.shared.register(placement: "onboarding_complete")
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

## Post-task reflection (run after every completed task)

Before marking the Notion task Done, answer these four questions:
1. Did I do anything differently from what this skill instructed?
2. Did I encounter an error this skill didn't anticipate?
3. Did I find a faster or better method?
4. Did the human override my approach at any decision point?

If YES to any: format a skill update proposal:
  SKILL UPDATE PROPOSED — superwall-campaigns
  Change: [what to add/modify/remove]
  Reason: [why this would have helped]
  Diff: [exact before/after lines]

Send via ccgram as a decision card (same format as Layer 1).
Wait for approval before modifying the skill file.
If approved: apply the diff. Commit: "skill: superwall-campaigns update — [one-line reason] [agent]"
If rejected: log the reasoning in DECISIONS.md and do not retry.
