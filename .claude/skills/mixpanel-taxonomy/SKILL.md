---
name: mixpanel-taxonomy
description: Mixpanel event naming, super properties, and dashboard setup for Social IQ. Trigger on: "analytics", "mixpanel", "event tracking", "dashboard", "funnel".
model: sonnet
---

# Mixpanel Taxonomy for Social IQ

## Event naming convention
`object_action` in snake_case. Examples: `lesson_started`, `paywall_viewed`.

## Core events

### Acquisition
- `app_opened` — every app launch
- `onboarding_started` — first screen of onboarding
- `onboarding_completed` — finished onboarding flow
- `signup_completed` — account created

### Activation
- `lesson_started` — user begins a lesson (props: lesson_id, lesson_title, category)
- `lesson_completed` — user finishes a lesson (props: lesson_id, score, time_spent_seconds)
- `first_lesson_completed` — milestone event, fired once per user

### Engagement
- `practice_session_started` — began a practice drill (props: session_type)
- `practice_session_completed` — finished drill (props: session_type, score)
- `streak_maintained` — daily streak incremented (props: streak_count)
- `streak_broken` — streak reset to 0
- `achievement_earned` — unlocked an achievement (props: achievement_name)

### Revenue
- `paywall_viewed` — saw a paywall (props: placement, paywall_id)
- `paywall_converted` — subscribed from paywall (props: placement, product_id)
- `paywall_dismissed` — closed paywall without action (props: placement)
- `transaction_abandoned` — started checkout, didn't finish
- `subscription_started` — new subscription active (props: product_id, price)
- `subscription_cancelled` — subscription cancelled
- `trial_started` — free trial began

### Retention
- `notification_received` — push notification delivered
- `notification_opened` — user tapped notification

## Super properties (set at app launch)

**Important:** All Mixpanel calls go through `AnalyticsService` - never call `Mixpanel.mainInstance()` directly outside AnalyticsService.

```swift
// In AnalyticsService (the only place raw Mixpanel calls belong)
static func registerSuperProperties(_ properties: [String: MixpanelType]) {
    Mixpanel.mainInstance().registerSuperProperties(properties)
}

// Usage from anywhere else:
AnalyticsService.registerSuperProperties([
  "subscription_status": subscriptionStatus,
  "days_since_install": daysSinceInstall,
  "total_lessons_completed": totalLessons,
  "onboarding_completed": onboardingDone
])
```

## User properties (set on identify)
```swift
// Via AnalyticsService wrapper:
AnalyticsService.setUserProperties([
  "$name": displayName,
  "subscription_status": status,
  "streak_count": streak,
  "signup_date": signupDate
])
```

## Three essential dashboards

### 1. Acquisition Funnel
app_opened -> onboarding_started -> onboarding_completed -> signup_completed -> first_lesson_completed

### 2. Activation (Day 1)
signup_completed -> lesson_started (within 24h) -> lesson_completed (within 24h)
Target: 40%+ complete first lesson on day 1

### 3. Retention
- D1/D7/D30 retention with `lesson_completed` as activation event
- Cohort by signup week
- Segment by subscription_status

## Swift SDK integration
```swift
// Track event
AnalyticsService.track(event: .lessonCompleted, properties: [
  "lesson_id": lesson.id.uuidString,
  "score": score,
  "time_spent_seconds": timeSpent
])

// Identify user
AnalyticsService.identify(userId: user.id.uuidString)

// Set user properties
AnalyticsService.setUserProperties([
  "subscription_status": "premium",
  "streak_count": 15
])
```

## Debugging analytics events
1. **Check real-time first.** Use Mixpanel Live View (Events stream) or the Mixpanel MCP `Run-Query` with a short time range — NOT aggregate dashboard reports. Aggregate views have 30-60s ingestion delay that mimics "events not firing."
2. **Check the network layer.** Enable `loggingEnabled = true` (already on in DEBUG) and look for `Successfully inserted row` + `Sending batch of data` + API response in console logs. If those appear, the event was sent — the issue is query-side delay, not tracking code.
3. **Only then investigate code.** If the real-time stream and network logs confirm the event was never sent, trace the code path: caller → AnalyticsService.track() → Mixpanel.track() → flush().

## Rules
- Every new feature MUST add its events to this taxonomy before shipping
- Never track PII (email, phone) as event properties
- Use Mixpanel's built-in $device, $os, $app_version — don't duplicate
- Flush on every track call (AnalyticsService.track calls flush() immediately) — ensures events appear in real-time stream within seconds

## Post-task reflection (run after every completed task)

Before marking the Notion task Done, answer these four questions:
1. Did I do anything differently from what this skill instructed?
2. Did I encounter an error this skill didn't anticipate?
3. Did I find a faster or better method?
4. Did the human override my approach at any decision point?

If YES to any: format a skill update proposal:
  SKILL UPDATE PROPOSED — mixpanel-taxonomy
  Change: [what to add/modify/remove]
  Reason: [why this would have helped]
  Diff: [exact before/after lines]

Send via ccgram as a decision card (same format as Layer 1).
Wait for approval before modifying the skill file.
If approved: apply the diff. Commit: "skill: mixpanel-taxonomy update — [one-line reason] [agent]"
If rejected: log the reasoning in DECISIONS.md and do not retry.
