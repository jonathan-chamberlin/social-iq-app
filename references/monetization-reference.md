# Monetization Reference

Social IQ App

---

## Pricing

| Plan | Price | Purpose |
|------|-------|---------|
| Annual | $29.99/year | Primary conversion target |
| Weekly | $4.99/week | Anchor — makes annual feel like a deal |

Always show both options on the paywall. The weekly price exists to make the annual price look cheap by comparison.

---

## Revenue Levers (Ranked by Impact)

### 1. Transaction Abandoned
When a user backs out of the Apple payment sheet, show a 50-80% discount immediately. This is a built-in Superwall event — no custom code needed.

- Benchmark: 23.1% conversion rate on the discount offer
- CalAI saw +40% revenue from this single lever
- This is the highest-impact lever and should be implemented at launch

### 2. Age-Segmented Paywalls
Route users to different paywall variants based on age (collected during onboarding). The 23-28 age group converts at 17.6% — the highest of any segment. This data also tells you which demographic to target with paid ads.

- Requires: age collection in onboarding (already planned)
- Requires: Superwall audience segmentation

### 3. Discount After 5-Minute Timer
After onboarding, if the user doesn't convert on the paywall, start a local 5-minute timer. When it fires, send a local notification with a discount offer and show a discount button in-app.

- Benchmark: ~10% conversion on the discount
- Estimated impact: ~$1K/day extra at moderate volume

### 4. Free Trial on Long-Press Delete
When a user long-presses the app icon to delete it, iOS shows the app a callback. Use this to present a "Try for free" offer as a last-chance retention play.

- Benchmark: $12K in 90 days (from Quittr)
- Low effort, high ROI

### 5. A/B Test Paywalls
Test one variable at a time. Need 1K-3K users per variant for statistical significance. Optimize for ARPU (average revenue per user), not conversion rate — a lower-converting paywall with higher price can generate more total revenue.

---

## Paywall Design

Use Superwall templates until $100K+ MRR. Do not custom-design paywalls early.

Must-haves on every paywall:
- Benefits list (what the user gets)
- App preview screenshots
- Annual + weekly pricing options shown together
- Social proof (testimonial or user count)
- Free trial reminder if applicable

---

## What Not to Do

- Don't optimize the paywall before $100K MRR — Quittr didn't touch theirs until $1.5M
- Don't optimize for conversion rate — optimize for ARPU
- Don't A/B test multiple variables at once
- Don't skip transaction_abandoned — it's the single highest-impact lever
