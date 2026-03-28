# Analytics Event Taxonomy

Social IQ App — Mixpanel

---

## Naming Convention

Use snake_case. Format: `{category}_{action}` (e.g., `onboarding_step_completed`, `scenario_answered`).

---

## Onboarding Events

| Event | Properties | Purpose |
|-------|-----------|---------|
| onboarding_started | source (organic, challenge_link, ad) | Track entry point |
| onboarding_step_completed | step_number, step_name | Identify drop-off points in the funnel |
| onboarding_step_skipped | step_number, step_name | Track which steps users skip |
| onboarding_completed | duration_seconds, source | Conversion to app |
| onboarding_abandoned | last_step_number, last_step_name, duration_seconds | Where people leave |

---

## Scenario Events

| Event | Properties | Purpose |
|-------|-----------|---------|
| scenario_started | scenario_id, difficulty, loop_level (L1-L5), category | What content is being consumed |
| scenario_answered | scenario_id, answer_chosen, is_correct, time_to_answer_seconds | Core engagement metric |
| scenario_explanation_viewed | scenario_id, duration_seconds | Are people reading the explanations |
| scenario_completed | scenario_id, score, percentile | Completion tracking |
| scenario_skipped | scenario_id | Content quality signal — high skip rate = bad scenario |

---

## Paywall Events

| Event | Properties | Purpose |
|-------|-----------|---------|
| paywall_presented | paywall_variant, trigger (onboarding, in_app, timer_discount, delete_attempt) | Which paywall and why |
| paywall_plan_selected | plan (annual, weekly) | What users are choosing |
| paywall_purchase_started | plan, price | Entered Apple payment flow |
| paywall_purchase_completed | plan, price, is_trial | Revenue tracking |
| paywall_purchase_abandoned | plan, price | Transaction abandoned trigger |
| paywall_discount_shown | discount_percent, trigger | Track discount effectiveness |
| paywall_discount_converted | discount_percent, trigger, plan | Discount revenue attribution |
| paywall_dismissed | paywall_variant, time_on_paywall_seconds | Drop-off from paywall |

---

## Viral / Share Events

| Event | Properties | Purpose |
|-------|-----------|---------|
| challenge_share_prompted | scenario_id, user_score | How often the share prompt appears |
| challenge_shared | scenario_id, user_score, share_method (imessage, link, other) | Actual shares |
| challenge_link_opened | scenario_id, sharer_user_id | Recipient opened the link |
| challenge_completed | scenario_id, recipient_score, sharer_score | Challenge completion |
| challenge_signup_converted | scenario_id | Recipient signed up after playing challenge |

---

## Retention Events

| Event | Properties | Purpose |
|-------|-----------|---------|
| app_opened | source (push_notification, organic, challenge_link), days_since_last_open | Session tracking |
| daily_session_completed | scenarios_played, total_score, session_duration_seconds | Daily engagement depth |
| streak_milestone | streak_days | Retention milestone tracking |
| streak_broken | previous_streak_days | Churn signal |
| push_notification_received | notification_type (streak, challenge, re_engagement) | Notification delivery |
| push_notification_opened | notification_type | Notification effectiveness |

---

## User Properties (Set Once or Updated)

| Property | Type | Set When |
|----------|------|----------|
| age | number | Onboarding |
| age_group | string (under_18, 18_22, 23_28, 29_35, 36_plus) | Onboarding — used for age-segmented paywalls |
| signup_source | string | First app open |
| subscription_status | string (free, trial, subscribed, churned) | On change |
| current_streak | number | Daily |
| total_scenarios_completed | number | On scenario complete |
| average_score | number | On scenario complete |
| social_iq_loop_step | string (READ, THINK, SPEAK) | On progression |
| referral_code_used | string | Onboarding |

---

## Key Funnels to Build in Mixpanel

1. **Onboarding → Paywall → Purchase**: onboarding_started → onboarding_completed → paywall_presented → paywall_purchase_completed
2. **Scenario → Share → Conversion**: scenario_completed → challenge_shared → challenge_link_opened → challenge_signup_converted
3. **Transaction Abandoned Recovery**: paywall_purchase_abandoned → paywall_discount_shown → paywall_discount_converted
4. **Re-engagement**: streak_broken → push_notification_received → push_notification_opened → app_opened → scenario_started
