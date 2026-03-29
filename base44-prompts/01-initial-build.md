# Base44 Prompt — Social IQ MVP

Copy everything below the line and paste into Base44.

---

Create a web app called "Social IQ" — an AI-powered social intelligence trainer that teaches users exactly what to say in real social situations. It uses a 3-step framework (READ → THINK → SPEAK) to break down social interactions into learnable skills. Dark theme, vibrant gamified aesthetic, modern and clean.

## FLOW

The app has 4 pages in this exact order:

### Page 1: Onboarding (3 questions, one per screen with a progress bar at the top)

Screen 1 — "what best describes your social life right now?"
Options (single select, large tappable cards):
- "I have a few close friends but want more"
- "I'm mostly alone and want to change that"
- "I'm social at work but struggle outside of it"
- "I have friends but conversations feel surface-level"

Screen 2 — "what's the hardest part for you?"
Options (single select, large tappable cards):
- "I never know what to say"
- "I come across as awkward or boring"
- "I can't keep conversations going"
- "People don't seem to want me around"

Screen 3 — "what does success look like for you?"
Options (single select, large tappable cards):
- "Having a close group of friends who actually reach out to me"
- "Being someone people enjoy talking to"
- "Feeling confident in any social situation"
- "Building deeper relationships with people I already know"

After the 3rd question, show a brief "analyzing your profile..." loading screen (fake, 2 seconds with an animated spinner), then transition to a personalized result screen that says:

"based on what you told us, here's where to start."

Show a card that says: "Your #1 skill gap: Reading emotional states" and a subtitle: "Most people say the wrong thing because they don't notice what the other person is feeling. Let's fix that."

Below that, a single button: "connect your calendar"

### Page 2: Calendar Connect

Show a screen with the heading "Social IQ works best when it knows your week."

Subtitle: "We'll scan your upcoming events to recommend scenarios for situations you'll actually be in."

Show two buttons styled to look like real OAuth buttons:
- A Google Calendar button (white background, Google logo, text: "Connect Google Calendar") — this is the only clickable one
- An Apple Calendar button (grayed out, text: "Apple Calendar — coming soon")

When the user clicks the Google Calendar button, do NOT actually connect to anything. Just show a fake loading screen that says "scanning your week..." with an animated spinner for 3 seconds. Then transition to the Home page.

### Page 3: Home (your week)

Header shows "Social IQ" and a subheading: "your week — 3 situations to prepare for"

Show 3 scenario cards in a vertical list. Each card has a CALENDAR EVENT at the top (gray text showing a date/time and event name), then a matched scenario title, description, and tag below it. This makes it look like the app analyzed their actual calendar and recommended specific practice scenarios.

Card 1 (ACTIVE — this is the only clickable one):
- Calendar event: "Tomorrow, 12:00 PM — Lunch with Alex"
- Title: "The Frustrated Coworker"
- Description: "Alex just got passed over for a promotion. They're going to vent to you at lunch tomorrow. Practice before you go."
- Tag: "Recommended for you"
- Has a "Practice now" button

Card 2 (LOCKED, grayed out, not clickable):
- Calendar event: "Wednesday, 6:00 PM — Gym session"
- Title: "Starting a Conversation Cold"
- Description: "You'll be around new people. Practice how to break the ice without being awkward."
- Tag: "Upcoming"
- Show a small lock icon

Card 3 (LOCKED, grayed out, not clickable):
- Calendar event: "Friday, 8:00 PM — Dinner with Sam, Jordan, and Mike"
- Title: "The Quiet Friend"
- Description: "Group settings are tricky. Practice reading who's checked out and how to pull them back in."
- Tag: "Upcoming"
- Show a small lock icon

### Page 4: Scenario (3 steps — READ, THINK, SPEAK)

This is the core of the app. When the user clicks "Start" on "The Frustrated Coworker" scenario, they go through 3 sequential screens. Each screen has a step indicator at the top showing "READ → THINK → SPEAK" with the current step highlighted.

**Step 1 — READ**

Show the scenario text at the top in a card:

"Your coworker Alex just found out they didn't get the promotion they'd been working toward for 6 months. They sit down across from you at lunch and say: 'I honestly don't even know why I try anymore. I've been here longer than half the managers and they just gave it to someone who started last year.'"

Below the scenario text, ask: "what emotional state is Alex in right now?"

Display the scenario image (a realistic portrait of a young man in an office break room, sitting across from you at a table, looking frustrated — jaw tight, brow furrowed, leaning back with arms crossed, food untouched). I will upload this image as a static asset.

4 options as tappable cards:
- A) Angry — wants someone to blame
- B) Frustrated — feels like their effort didn't matter
- C) Defensive — feels threatened and overlooked
- D) Anxious — worried about their future

The correct answer is B (Frustrated). Store which answer the user picks. After they tap, immediately go to Step 2.

**Step 2 — THINK**

Show a brief reminder: "You identified Alex as: [their answer from step 1]"

Then ask: "based on their state, what do they need from you right now?"

4 options as tappable cards:
- A) Advice — tell them how to get the next one
- B) Restore agency — remind them their effort wasn't wasted and they have options
- C) A distraction — change the subject to lighten the mood
- D) Validation — just acknowledge how unfair it feels

The correct answer is B (Restore agency). Store which answer the user picks. After they tap, immediately go to Step 3.

**Step 3 — SPEAK**

Show a brief reminder: "You think Alex needs: [their answer from step 2]"

Then ask: "what would you actually say?"

4 options as tappable cards:
- A) "You'll get it next time, don't worry about it."
- B) "That's brutal. Six months is real work — that doesn't just disappear. What are you thinking about doing next?"
- C) "Maybe you should talk to your manager about what you could improve."
- D) "At least you still have a job, right?"

The correct answer is B. Store which answer the user picks. After they tap, go to the Results page.

### Page 5: Results

Show a score out of 3 (how many of the 3 steps the user got correct). Display it prominently like "2/3" or "3/3" with a large number.

Below the score, show a percentile: "you read this situation better than 74% of people" (hardcoded, just display this text).

Then show an explanation section with a card for EACH of the 3 steps. Each card shows:
- The step name (READ / THINK / SPEAK)
- Whether the user got it right or wrong (green checkmark or red X)
- What the correct answer was
- A short explanation paragraph of WHY that answer is correct

Use these exact explanations:

READ explanation: "Alex isn't angry — he's frustrated. The key tell is 'I don't even know why I try anymore.' Angry people want to blame someone. Frustrated people feel like their effort hit a wall — they put in the work and it didn't pay off. The comparison to the newer hire isn't about that person, it's about Alex feeling like the system doesn't reward what he's doing. If you treat this as anger, you'll try to calm him down. But he doesn't need calming — he needs to feel like his effort still counts."

THINK explanation: "When someone is frustrated, they feel like effort and outcome are disconnected. Validation alone ('that sucks') confirms the helplessness. Advice ('talk to your manager') skips past the emotion entirely. Distraction ('let's talk about something else') tells them their frustration doesn't matter. What they actually need is to feel agency again — a reminder that their effort was real and that they still have moves to make. You're not fixing the problem. You're reconnecting effort to outcome in their head."

SPEAK explanation: "Option B works because it does three things: it acknowledges the pain ('that's brutal'), it validates the effort as real ('six months is real work — that doesn't just disappear'), and it points them forward with a question ('what are you thinking about doing next?'). The question is critical — it restores agency by implying they have moves to make. 'You'll get it next time' is hollow and dismissive. 'Talk to your manager' is premature advice they can't hear yet. 'At least you have a job' invalidates everything they feel."

Below the explanations, show a button: "back to scenarios" that goes back to the Home page.

## VISUAL STYLE

- Dark background (near black, like #0D0D10)
- Cards with subtle borders and rounded corners (dark gray like #1A1A2E)
- Accent color: vibrant blue-purple gradient for buttons and highlights
- Text: white and light gray, clean sans-serif font
- The step indicator (READ → THINK → SPEAK) should use color to show progress: completed steps get the accent color, current step is bright, upcoming steps are dimmed gray
- Large tappable option cards with hover/selected states — when selected, the card gets an accent border glow
- Correct answers show a green highlight, wrong answers show a red highlight (only on the results page, NOT during the scenario)
- Overall vibe: feels like a game, not a textbook. Clean, modern, dark mode, slightly futuristic
- Mobile-responsive — should look good on phone screens since this is meant to be a mobile app prototype

## IMPORTANT CONSTRAINTS

- Do NOT use any mock data or placeholder text. Use the exact text I provided above for all scenarios, options, and explanations.
- Do NOT add authentication or sign-in. The app should work immediately with no login.
- Do NOT add a database. All state is local/in-memory for the session only.
- The onboarding answers don't need to change anything — just store them locally and display the same result screen regardless. This is an MVP.
- Keep it simple. No animations beyond the fake loading screen. No sound effects. No complex state management.
- The entire flow should be: Onboarding (3 questions) → Fake analysis → Calendar connect (fake) → Fake scanning → Home (your week, 3 cards, 1 active) → Scenario (3 steps) → Results → Back to Home.
