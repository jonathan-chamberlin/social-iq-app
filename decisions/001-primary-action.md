# Decision 001: Primary Action — Scenario Quiz, Not AI Advisor or Voice Roleplay

**Date:** 2026-03-27
**Status:** Decided

---

## Context

Three candidate primary actions were evaluated for Social IQ's core user experience:

1. **Lesson + Quiz + Score** — Duolingo/Impulse model. Read a short scenario, answer questions about what to say and why, get a score.
2. **AI Advisor** — User types in their real-life situation, gets back exactly what to say based on principles of persuasion and relationship building. Motivated by the tagline "always know what to say."
3. **Voice Roleplay** — Use the OpenAI real-time API to practice conversations verbally. Modeled on how the founder actually developed his own social skills: read a chapter, recall a past conversation, visualize saying different words, internalize the new behavior.

The founder's initial lean was toward Option 1, then considered pivoting to Option 2 because the research showed people want long-term friends and don't want to come across as weird — which felt more like an on-demand advice tool than a lesson format. Option 3 was explored but deprioritized after competitive analysis showed no successful education apps using that model.

---

## Decision

**Primary action: Read a scenario, pick a response, get a score + explanation.**

The explanation is the core differentiator — it breaks down:
- Why the chosen answer would land poorly (what effect it would have on the other person)
- Why the correct answer works (what effect it has on the other person's emotional state)
- The underlying principle from the Social IQ Loop (READ → THINK → SPEAK) that makes it work

---

## Reasoning

### Option 2 (AI Advisor) fails the App Mafia design test

- A text input box is a blank canvas. Blank canvases create decision paralysis — the exact problem the target audience already has. The person who "doesn't know what to say" also can't articulate their situation in a text box.
- CalAI succeeded because the primary action was one button (take a photo), not "describe what you ate." The constraint IS the product.
- A 7-year-old can't use a freeform text advisor. Violates the KISS rule.

### Option 3 (Voice Roleplay) is the best learning tool but the worst product

- Voice requires a quiet environment, microphone permissions, long sessions, and carries social embarrassment risk (someone overhears you practicing conversations).
- Produces no shareable output — can't screenshot it, can't challenge a friend, influencer content can't demonstrate it in 15 seconds.
- The most successful education apps aren't the most educational. They're the most addictive. Duolingo isn't the best way to learn a language; it's the most gamified.

### Option 1 (Scenario Quiz) is the only format that enables the viral loop

- A discrete scenario produces a discrete score — the viral payload for the challenge share mechanic ("I scored 87/100 reading this situation — bet you can't beat me").
- Option 2 produces a wall of personalized text (not shareable, not competitive). Option 3 produces nothing visual.
- Score + percentile + identity label = shareable, competitive, and signals intelligence rather than deficiency.

### "Always know what to say" is the marketing hook, not the UX

- The tagline resonates because it captures the desire. But the product delivers on that promise through repeated pattern recognition practice, not real-time advice.
- This is the 10% rule: solving 10% of "I never know what to say" (building intuition through scenarios) beats trying to solve 100% of it (real-time advice for every situation).

### The founder's unique advantage is embedded in the scenario format

- The Social IQ Loop (READ → THINK → SPEAK) is encoded into every scenario and explanation — each step maps to a screen type where users practice one skill at a time.
- Current social skills teaching gives vague advice like "just be yourself." These scenarios give concrete situations with concrete right answers and explain exactly WHY each response works based on the other person's emotional state.
- Ren (the mascot) delivers the explanation — warm, specific, mechanism-first. Never "wrong," always "here's what the pause was telling you."

---

## Future Consideration

Option 2 (AI Advisor) could become a secondary feature ("Ask Ren") after traction — targeting paying subscribers as a retention feature, not the primary action. The App Mafia playbook says: don't add secondary features until after $100K MRR.

Option 3 (Voice Roleplay) could become a premium feature much later, but only after the core game loop is proven and monetizing.
