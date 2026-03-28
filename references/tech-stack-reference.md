# Tech Stack Reference

Social IQ App

---

## Stack

| Tool | Purpose |
|------|---------|
| SwiftUI | UI framework (iOS only) |
| Supabase | Database + auth |
| Superwall | Paywalls + A/B testing |
| Mixpanel | In-app analytics |
| Adjust | Attribution |
| OpenAI API | AI features (future — secondary actions only) |
| SF Symbols 6 | Icons |

## Architecture
- MVVM
- iOS 17.0 minimum deployment target
- iPhone only — iPad, Mac, and Vision targets removed
- No cross-platform. Native SwiftUI only.

## Why These Choices

### iOS 17.0 Minimum
The App Mafia playbook recommends not using the latest iOS version as the minimum. iOS 17.0 maximizes the addressable install base. The default Xcode minimum (currently 18.5+) excludes too many devices.

### iPhone Only
iPad/Mac/Vision targets must be removed immediately — once shipped with those targets, removing them requires a new app listing. Single platform focus until the app is proven.

### Superwall Over Custom Paywalls
Use Superwall templates until $1M+ ARR. Over-optimizing paywalls early is wasted time. Quittr didn't change their paywall until $1.5M revenue. Superwall provides built-in A/B testing and the transaction_abandoned event for free.

### Adjust From Day One
Attribution cannot be retroactively added. Every marketing channel needs tracking links before any spend. This is a day-one requirement, not a "set up later" item.

### Mixpanel Over Firebase Analytics
Mixpanel provides deeper funnel analysis and user-level event tracking needed for paywall optimization and age-segmented routing.

## Dependencies Not Yet Configured
No package manager (SPM or CocoaPods) is configured yet. All of the above will need to be added as dependencies before development begins.
