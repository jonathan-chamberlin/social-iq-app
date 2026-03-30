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

Below that, a single button: "start your first scenario"

### Page 2: Home (scenario list)

Header shows "Social IQ" as the app name and a greeting like "ready to practice?"

Show 3 scenario cards in a vertical list. Each card has a title, a short description, and a difficulty tag.

Card 1 (ACTIVE — this is the only clickable one):
- Title: "The Frustrated Coworker"
- Description: "Your coworker just got passed over for a promotion. They're venting to you at lunch. What do you do?"
- Tag: "Beginner"
- Has a "Start" button

Card 2 (LOCKED, grayed out, not clickable):
- Title: "The Quiet Friend"
- Description: "Your friend has been distant lately. You're at a group dinner and they're barely talking."
- Tag: "Intermediate"
- Show a small lock icon

Card 3 (LOCKED, grayed out, not clickable):
- Title: "The First Date Silence"
- Description: "Conversation just died. They're looking at their phone. You have 5 seconds."
- Tag: "Advanced"
- Show a small lock icon

### Page 3: Scenario (3 steps — READ, THINK, SPEAK)

This is the core of the app. When the user clicks "Start" on "The Frustrated Coworker" scenario, they go through 3 sequential screens. Each screen has a step indicator at the top showing "READ → THINK → SPEAK" with the current step highlighted.

**Step 1 — READ**

Show the scenario text at the top in a card:

"Your coworker Alex just found out they didn't get the promotion they'd been working toward for 6 months. They sit down across from you at lunch and say: 'I honestly don't even know why I try anymore. I've been here longer than half the managers and they just gave it to someone who started last year.'"

Below the scenario text, ask: "what emotional state is Alex in right now?"

Display the scenario image (a realistic portrait of a young man in an office break room, sitting across from you at a table, looking defeated — slumped shoulders, eyes cast down, food untouched). I will upload this image as a static asset.

4 options as tappable cards:
- A) Angry — wants someone to blame
- B) Frusterated — has lost belief that effort matters
- C) Defensive — feels threatened and overlooked
- D) Anxious — worried about their future

The correct answer is B (Frusterated). Store which answer the user picks. After they tap, immediately go to Step 2.
 LEFTOFF READING. 
**Step 2 — THINK**

Show a brief reminder: "You identified Alex as: [their answer from step 1]"

Then ask: "based on their state, what do they need from you right now?"

3 options as tappable cards:
- A) Advice — tell them how to get the next one
- B) Label - Tell them how they are likely feeling right now
- C) A distraction — change the subject to lighten the mood

The correct answer is B (Label. Store which answer the user picks. After they tap, immediately go to Step 3.

**Step 3 — SPEAK**

Show a brief reminder: "You think Alex needs: [their answer from step 2]"

Then ask: "what would you actually say?"

4 options as tappable cards:
- A) "You'll get it next time, don't worry about it."
- B) "That sounds really frustrating. Six months is a long time to work toward something and not get it."
- C) "Maybe you should talk to your manager about what you could improve."
- D) "At least you still have a job, right?"

The correct answer is B. Store which answer the user picks. After they tap, go to the Results page.

### Page 4: Results

Show a score out of 3 (how many of the 3 steps the user got correct). Display it prominently like "2/3" or "3/3" with a large number.

Below the score, show a percentile: "you read this situation better than 74% of people" (hardcoded, just display this text).

Then show an explanation section with a card for EACH of the 3 steps. Each card shows:
- The step name (READ / THINK / SPEAK)
- Whether the user got it right or wrong (green checkmark or red X)
- What the correct answer was
- A short explanation paragraph of WHY that answer is correct

Use these exact explanations:

READ explanation: "Alex is defensive — not just angry. The key tell is 'I've been here longer than half the managers.' They're comparing themselves to others and asserting their worth. That's a defensive posture. When someone is defensive, they feel their value is being questioned. You can't give advice until you first make them feel seen."

THINK explanation: "When someone feels frusterated, the protocol is: validate before content. Don't correct them, don't redirect, don't advise — not yet. First, agree on something small. Acknowledge their experience. Once they feel heard, their guard drops and they can actually receive what you want to say."

SPEAK explanation: "Option B works because it does two things: it names the emotion ('that sounds really frustrating') and it validates the effort ('six months is a long time'). It doesn't minimize ('you'll get it next time'), it doesn't pivot to solutions ('talk to your manager'), and it doesn't dismiss ('at least you have a job'). The person needs to feel heard before they can hear you."

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
- The entire flow should be: Onboarding (3 questions) → Fake analysis → Home (3 cards, 1 active) → Scenario (3 steps) → Results → Back to Home.
