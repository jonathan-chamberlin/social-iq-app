---
name: superwall-campaigns
description: Configure Superwall paywalls, placements, and A/B tests for Social IQ. Trigger on: "paywall", "superwall", "subscription", "monetization", "paywall test".
---

# Superwall Campaigns for Social IQ

## Current Live Setup

**Paywall:** Social IQ Pro (ID 203822) — used by both campaigns below
- Annual: $29.99/year — primary product (`com.jonathanchamberlin.socialiq.annual`)
- Weekly: $4.99/week — secondary product (`com.jonathanchamberlin.socialiq.weekly`)

**Active Campaigns:**
| Campaign | ID | Placement | Paywall |
|----------|-----|-----------|---------|
| Onboarding Paywall | 78286 | `onboarding_complete` | 203822 (100%) |
| Lesson Locked | 78288 | `lessons_locked` | 203822 (100%) |
| Transaction Abandoned | 78289 | (no placement yet) | (no paywall yet) |
| Example Campaign | 75153 | `campaign_trigger` | 195191 (100%) |

## Superwall MCP

The Superwall MCP (`mcp__superwall__*`) manages campaigns, placements, products, and entitlements programmatically. Use it as the first approach before falling back to the dashboard.

**Key MCP tools:**
- `mcp__superwall__whoami` — verify auth is working
- `mcp__superwall__list_projects` — list projects (use to get project ID)
- `mcp__superwall__list_paywalls` — list paywalls
- `mcp__superwall__get_paywall` — get paywall details
- `mcp__superwall__list_campaigns` — list campaigns
- `mcp__superwall__get_campaign` — get campaign details
- `mcp__superwall__list_products` — list products
- `mcp__superwall__list_entitlements` — list entitlements

**MCP cannot edit paywall visual content** (text, layout, design). Paywall copy is edited in the Superwall dashboard visual editor only.

**MCP cannot publish paywalls.** After editing a paywall in the dashboard, it stays in draft until manually published. There is no `publish_paywall` MCP tool. If a paywall isn't showing in production/TestFlight, this is the first thing to check - see "Troubleshooting: Paywall Not Showing" below.

**If MCP auth fails** (expired OAuth token error like `"exp" claim timestamp check failed`):
1. Don't waste time removing/re-adding the MCP — the token is cached in the session
2. Fall back to the **Superwall dashboard** directly for the task
3. If the user has Claude Chrome available, generate step-by-step browser instructions

**Known MCP bugs (as of 2026-04-04):**
- `get_paywall` and `list_paywalls` may fail with a schema error on the `products` field (expects string, gets object)
- `create_paywall` has the same products type mismatch

## Paywall Template Variables

Superwall paywall templates use `{{ products.<slot>.<variable> }}` syntax. Products are referenced by slot: `primary` (annual) and `secondary` (weekly).

### Period variables (critical for non-monthly products)

| Variable | Weekly result | Annual result | Use for |
|----------|--------------|---------------|---------|
| `period` | `"week"` | `"year"` | Display period name - USE THIS ONE |
| `periodWeeks` | `1` | `52` | Numeric weeks |
| `periodMonths` | `0` | `12` | Numeric months - BROKEN for weekly |
| `localizedPeriod` | `"1 wk"` | `"1 yr"` | Compact localized string |

**NEVER use `periodMonths` for weekly products** — it rounds 0.25 months to 0, producing "0 Months".

### Correct template patterns

```
# Weekly product (secondary)
Header:  {{ products.secondary.period }}          → "week" (use "Words" case for "Week")
Price:   {{ products.secondary.price }} / {{ products.secondary.period }}  → "$4.99 / week"

# Annual product (primary)
Header:  {{ products.secondary.period }}          → "year"
Price:   {{ products.primary.price }} / {{ products.primary.period }}      → "$29.99 / year"
```

### Case settings in the editor
- "Words" case → capitalizes: "Week", "Year"
- "UPPER" case → all caps: "WEEK", "YEAR"
- Default → lowercase: "week", "year"

### Fix checklist for broken period display
1. Open Superwall dashboard → Paywalls → click the paywall
2. In the visual editor, click each text element showing "0 Months" or wrong period
3. In the element settings panel, find the template text
4. Replace `{{ products.secondary.periodMonths }} Months` with `{{ products.secondary.period }}`
5. Replace `/ {{ products.secondary.periodMonths }} months` with `/ {{ products.secondary.period }}`
6. Set text case to "Words" if you want "Week" capitalized
7. Preview in editor to confirm
8. Publish the paywall
9. Repeat for every paywall using the same template

## Paywall Copy Source

Paywall copy decisions should be informed by user research. Read `user-research/synthesis.md` for:
- What ICP users validated (positive signals to protect)
- The #1 complaint ("feels like a test" — 50%) — avoid quiz/test language on paywalls
- ICP-B paywall demand signal (Pattern 14) — Lauren, Sana, Phoebe were disappointed by locked lessons
- Gender-neutral copy requirement (Pattern 12) — "people" not "guys"

## Identity Management

**CRITICAL: Always call `SuperwallService.identify(userId:)` after sign-in.** Without it, Superwall uses device-level identity. A new account on the same device inherits the previous user's subscription state, causing paywalls to silently skip.

```swift
// In Social_IQApp.swift checkOnboarding():
AnalyticsService.identify(userId: userId)
SuperwallService.identify(userId: userId)  // Must pair with analytics identify
```

On sign-out/account deletion, call `SuperwallService.reset()` to clear cached state.

## Troubleshooting: Paywall Not Showing

When a paywall doesn't appear after tapping a button that calls `Superwall.shared.register(placement:)`, check these in order:

### 1. Stale StoreKit subscription on device (MOST COMMON for developer testing)
If the developer's Apple ID ever completed a sandbox purchase, Superwall sees them as subscribed and silently skips ALL paywalls. This is the #1 cause of "works on simulator, fails on TestFlight."
- **Diagnosis:** Check `SuperwallService.isSubscribed` - if true, this is the issue
- **Fix:** Use the "Reset Subscription" button in Settings (toggle `AppConfig.showResetSubscriptionButton = true`), then delete account and create fresh
- **Why simulator works:** Simulator has no real StoreKit transactions; device has Apple ID transaction history
- **NEVER use `getPresentationResult()` as a pre-check before `register()`** - it consumes campaign evaluations (counts as "matched") without assigning variants, making the problem worse

### 2. Paywall has unpublished changes
Superwall's visual editor creates drafts. If the paywall was edited but never published, TestFlight/production builds won't see the update. The simulator may still show it because sandbox can serve drafts.
- **MCP can't publish paywalls** - there is no `publish_paywall` tool
- **Fix:** Open Superwall dashboard -> Paywalls -> click the paywall -> click the teal "Publish" button in the editor
- **Tell the user** this requires the dashboard (or generate a Chrome agent prompt)

### 3. Campaign is not active
Check via MCP: `mcp__superwall__get_campaign` with the campaign ID. Look for status/active fields.
- If paused or draft, the placement event fires but no paywall is served

### 4. Placement event name mismatch
The placement string in code must exactly match the campaign's placement on the dashboard. Check for typos, camelCase vs snake_case differences.

### 5. Simulator vs TestFlight environment
Superwall treats builds differently:
- **Simulator** = sandbox environment (no real StoreKit, may show draft/test paywalls)
- **TestFlight** = production environment (real StoreKit with Apple ID history, only published paywalls)
- **App Store** = production environment

Key differences that cause "works on sim, fails on device":
- StoreKit transactions tied to Apple ID persist across app deletion
- iOS Keychain survives app deletion (Supabase session restores unexpectedly)
- `Superwall.shared.reset()` clears Superwall state but NOT StoreKit transactions
- `#if DEBUG` logging is invisible on TestFlight - use configurable UI diagnostics instead

### 6. Audience filters or entitlements blocking
Check the campaign's audience rules - filters like "show once," device type, or entitlement status can silently suppress the paywall.

### Debugging checklist (do these BEFORE changing code)
1. Check `SuperwallService.isSubscribed` - is the user seen as subscribed?
2. Check Superwall dashboard via MCP: `list_campaigns` -> verify placement name, paywall attached, campaign active
3. Check `integrated` field on `list_projects` - if `false`, SDK may not be connecting
4. Check if `identify(userId:)` is being called after sign-in
5. Only AFTER ruling out config/state issues should you modify code

## Troubleshooting: "Test Mode Active" Overlay in Production

Symptom: App Store / TestFlight build shows the red "Test Mode Active" banner with text like `Bundle ID mismatch: expected com.jonathanchamberlin.Social-IQ, got com.jonathanchamberlin.Social-IQ` — both strings look visually identical.

### Root cause: invisible trailing whitespace in the dashboard-registered bundle_id
The Superwall dashboard's bundle_id field stores the raw string you typed/pasted (including trailing spaces), but **renders it visually trimmed** in both the dashboard UI and the "Test Mode Active" error overlay. Superwall's SDK does strict `==` string equality with no trim, so even 1 trailing space forces the app into Test Mode.

This was observed in production with ~85 trailing spaces on the bundle_id, invisible everywhere except when inspected via the MCP API.

### Diagnostic (do this FIRST, before changing any code or Info.plist)
**Never compare the popup's rendered `expected` vs `got` visually — they are both trimmed.** Instead:

1. Query the dashboard-registered value via MCP:
   ```
   mcp__superwall__list_projects
   ```
   Find the project and inspect `applications[].bundle_id`.
2. Dump `repr()` and `len()` of that string. Compare length to `Bundle.main.bundleIdentifier` length. If they differ, you've found the bug — the extra chars are almost always trailing spaces/tabs.
3. Confirm by byte-diffing: the project's actual bundle ID is 32 chars (`com.jonathanchamberlin.Social-IQ`); anything longer is whitespace pollution.

### Fix
In the Superwall dashboard:
1. Open the project → Applications → click the bundle_id field.
2. `Cmd+A` to select all → `Delete`.
3. **Retype from scratch** (do not paste — the clipboard may still contain the polluted value).
4. Save. Re-query via `mcp__superwall__list_projects` and confirm `len() == 32`.
5. No app code change is needed. Next cold launch of the production build clears Test Mode.

### Why this keeps happening
- Dashboard paste events can include trailing whitespace from copied Xcode build-settings output.
- The dashboard UI CSS trims visually so the operator cannot see the garbage.
- The "Test Mode Active" overlay also renders trimmed, so the `expected` / `got` strings look byte-identical.
- Only the MCP API (and raw HTTP responses) expose the true stored value.

## Key placements

### lessons_locked (live — primary conversion point)
Fires when a free user taps a locked lesson. This is where ICP-B showed visible demand.
```swift
// Always use SuperwallService wrappers — never Superwall.shared directly in Views
SuperwallService.presentPaywall(placement: .lessonLocked)
```

### onboarding_complete (live — first paywall exposure)
Fires at the end of onboarding. Keep it soft — user hasn't seen value yet.
```swift
SuperwallService.presentPaywall(placement: .onboardingComplete)
```

### transaction_abandoned (not yet configured)
Fires when a user starts checkout but doesn't complete. Shows a discounted offer or urgency message. Highest impact placement (17-25% revenue lift) — configure once payment pipeline is live.
```swift
// Add to SuperwallPlacement enum + SuperwallService when ready
SuperwallService.presentPaywall(placement: .transactionAbandoned)
```

### paywall_close (future)
Fires when user dismisses a paywall without subscribing. Shows a "last chance" or alternative offer.
```swift
SuperwallService.presentPaywall(placement: .paywallClose)
```

### session_milestone (future)
Fires after a user completes N lessons (e.g., 3rd or 5th). They've seen value, now convert.
```swift
SuperwallService.presentPaywall(placement: .sessionMilestone)
```

## Age-segmented routing (App Mafia insight)
- 23-28 is the highest conversion bracket for self-improvement apps
- Route different paywall designs by age segment via Superwall's user attributes
```swift
// Add to SuperwallService as a static method when implementing
SuperwallService.setUserAttributes([
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
