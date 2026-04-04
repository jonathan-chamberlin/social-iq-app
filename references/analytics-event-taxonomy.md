# Analytics Event Taxonomy

Social IQ App — Mixpanel

---

## Naming Convention

Use snake_case. Format: `{category}_{action}` (e.g., `onboarding_step_completed`, `scenario_answered`).

---

## Onboarding Events

| Event | Properties | Status | Purpose |
|-------|-----------|--------|---------|
| onboarding_started | (none yet) | **LIVE** | Track entry point |
| onboarding_step_completed | step, step_name, duration_seconds, answer (quiz only) | **LIVE** | Drop-off by screen name + time spent |
| onboarding_completed | (none yet) | **LIVE** | Conversion to app |
| onboarding_abandoned | last_step, last_step_name, duration_seconds | **LIVE** | Where people leave (fires on background) |
| onboarding_step_skipped | step_number, step_name | NOT YET | Track which steps users skip |

### Onboarding Step Names (enum-driven, safe to reorder)
`quiz_challenge`, `quiz_meet_new`, `quiz_underperform`, `name_age_gender`, `social_context`, `calculating`, `scare`, `uplift`, `social_proof`, `chart`, `goal_selection`, `referral_code`, `discovery_source`, `rating_prompt`, `bridge_to_paywall`

---

## Lesson Events

| Event | Properties | Status | Purpose |
|-------|-----------|--------|---------|
| lesson_started | lesson_id | **LIVE** | What content is being consumed |
| question_answered | lesson_id, question_number, question_type (READ/THINK/SPEAK), answer_index, is_correct, time_to_answer_seconds | **LIVE** | Per-question difficulty + engagement |
| lesson_completed | lesson_id | **LIVE** | Completion tracking |
| lesson_locked_tap | (defined, not wired) | NOT YET | Paywall trigger signal |

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

| Property | Type | Set When | Status |
|----------|------|----------|--------|
| first_name | string | Onboarding completion | **LIVE** |
| age | number | Onboarding completion | **LIVE** |
| gender | string | Onboarding completion | **LIVE** |
| social_context | string | Onboarding completion | **LIVE** |
| goals | string (comma-separated) | Onboarding completion | **LIVE** |
| discovery_source | string | Onboarding completion | **LIVE** |
| quiz_challenge | string (answer text) | Onboarding completion | **LIVE** |
| quiz_meet_new | string (answer text) | Onboarding completion | **LIVE** |
| quiz_underperform | string (answer text) | Onboarding completion | **LIVE** |
| age_group | string (under_18, 18_22, 23_28, 29_35, 36_plus) | Onboarding — used for age-segmented paywalls | NOT YET |
| signup_source | string | First app open | NOT YET |
| subscription_status | string (free, trial, subscribed, churned) | On change | NOT YET |
| current_streak | number | Daily | NOT YET |
| referral_code_used | string | Onboarding | NOT YET |

---

## Key Funnels to Build in Mixpanel

1. **Onboarding → Paywall → Purchase**: onboarding_started → onboarding_completed → paywall_presented → paywall_purchase_completed
2. **Scenario → Share → Conversion**: scenario_completed → challenge_shared → challenge_link_opened → challenge_signup_converted
3. **Transaction Abandoned Recovery**: paywall_purchase_abandoned → paywall_discount_shown → paywall_discount_converted
4. **Re-engagement**: streak_broken → push_notification_received → push_notification_opened → app_opened → scenario_started
