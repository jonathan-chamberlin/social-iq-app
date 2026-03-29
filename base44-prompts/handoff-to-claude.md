# Social IQ — Session Handoff

## What happened this session

Built a working MVP of Social IQ using Base44 (no-code web app builder) for a hackathon. The hackathon category is "consumer AI products that deliver personalized intelligence" with $1500 prize.

## What Social IQ is

An social intelligence trainer app. It teaches users what to say in real social situations using a 3-step framework: READ (identify the person's emotional state), THINK (decide what they need from you), SPEAK (pick the right words). The core differentiator is that every answer, right or wrong, gets an explanation of WHY it works or what would happen if you said it.

## Key product decisions made

1. **Primary action**: Read a scenario, pick a response, get a score + explanation. Not an AI advisor chatbot, not voice roleplay. See `decisions/001-primary-action.md`.
2. **The Social IQ Loop was simplified** from a 5-level flowchart to READ → THINK → SPEAK. See `references/social-iq-loop.md` and `decisions/002-simplified-loop.md`.
3. **Fake calendar integration**: The app pretends to connect to Google Calendar and shows hardcoded "upcoming events" matched to practice scenarios. This sells the "personalized intelligence" angle without any actual integration.
4. **Labeling technique**: The THINK step teaches users to label the other person's emotion (e.g., "You must be so frustrated"). Based on the principle that naming someone's emotion out loud calms the reactive part of their brain and makes them feel seen.
5. **App name decided**: Social IQ (not Decoded or Calibrate).

## What was built

A web app on Base44 with this flow:
- Onboarding (3 questions about social life, challenges, goals)
- Fake "analyzing your profile..." screen
- Fake Google Calendar connect + "scanning your week..." screen
- Home page showing "your week" with 3 calendar events matched to scenarios (only 1 active)
- One working scenario: "The Frustrated Coworker" (Alex got passed over for a promotion)
  - READ: identify he's frustrated (not angry, defensive, or anxious)
  - THINK: label his emotion (not advice, distraction, or validation)
  - SPEAK: "You must be so frustrated." (not hollow reassurance, premature advice, or dismissal)
- Wrong answers show yellow hint banners explaining consequences
- Correct answers show green explanation banners with a Next button
- Results page with score and percentile

## Files created this session

All in the Social IQ repo:

- `decisions/001-primary-action.md` — why scenario quiz beats AI advisor and voice roleplay
- `references/design-reference.md` — restructured, primary action at top, mascot content extracted
- `references/mascot-reference.md` — Ren's full spec (appearance, voice, personality)
- `references/viral-growth-reference.md` — challenge share mechanic and viral loop
- `references/social-iq-loop.md` — simplified READ → THINK → SPEAK framework
- `base44-prompts/01-initial-build.md` — first Base44 prompt (full app spec)
- `base44-prompts/02-image-and-wrong-answer-hints.md` — added image + wrong answer explanations
- `base44-prompts/03-labeling-and-image-fix.md` — changed to labeling technique + image crop fix
- `base44-prompts/04-simplify-explanations-and-fix-onboarding.md` — simpler explanations + onboarding bug fix
- `base44-prompts/05-fix-C-and-D-explanations.md` — fixed missing hint banners for options C and D
- `base44-prompts/demo-video-script.md` — 3-5 min demo video script

## Hackathon submission description

COVID isolation left a generation worse at connecting, and AI is replacing everything except the one skill that still matters: human interaction. People want to get better at emotional intelligence but the advice out there is vague ("just be yourself"). After 3 years in sales I learned that social skills aren't a personality trait, they're a system you can practice, so I built Social IQ, an app that connects to your calendar, finds the real conversations you'll have this week, and lets you rehearse them with step-by-step feedback on how to read people and what to say.

## What still needs to happen

- Record and edit the demo video (script is in `base44-prompts/demo-video-script.md`)
- The demo video script hook section needs updating based on "ritwik pitch suggestion" (not yet provided)
- Submit the hackathon entry
