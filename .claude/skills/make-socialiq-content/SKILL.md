---
name: make-socialiq-content
description: Generate Social IQ lesson content matching Jonathan's quality bar. Scenarios, READ/THINK/SPEAK questions, answer explanations.
---

# Make Social IQ Content

Generate lesson content for the Social IQ app. Each lesson follows the READ → THINK → SPEAK format. This skill encodes the specific patterns Jonathan applies when revising AI-generated lesson drafts.

## Lesson Structure

Every lesson has this exact format:

```
## Lesson [N]: [Title]
Category: [workplace / dating / friendships / family / strangers]
Difficulty: [beginner / intermediate / advanced]

### Scenario
[2-4 sentences. Second person. Names, sensory details, specific setting.]

### READ — What's going on?
Question: [What is this person feeling / what's the dynamic?]
A) [option]
B) [option]
C) [option]
D) [option]

Correct: [letter]
Explanation: [Why correct.]

Wrong: [letter]
Explanation: [What would happen if you read it this way.]

Wrong: [letter]
Explanation: [Same.]

Wrong: [letter]
Explanation: [Same.]

### THINK — What do they need from you?
[Same structure as READ]

### SPEAK — What do you say?
[Same structure, but options are actual quotes the user would say]

Correct: [letter]

### Explanations per answer:
A) [consequence]
B) [consequence]
C) [consequence]
D) [consequence]
```

---

## Priority 1: Answer Option Wording — Be Strategic and Specific

The most frequent category of revision. Jonathan rewrites answer options to be more strategically precise about what the user is actually doing, not just what they're feeling.

### Rule: Frame correct answers as tactical moves, not passive descriptions

The correct answer should name the STRATEGY, not just describe the behavior. Use action-oriented language that tells the user what they're doing and why.

**Before (AI-generated):**
> C) Receive it calmly, acknowledge it briefly, and follow up with her one-on-one

**After (Jonathan's revision):**
> C) Agree to validate and disarm her, then follow up during your one on one

**Why:** "Receive it calmly" is passive. "Agree to validate and disarm her" names the tactic. The user learns the MOVE, not just the posture. "Validate and disarm" is a transferable concept they can apply elsewhere.

### Rule: Correct SPEAK answers should include explicit agreement/validation language

**Before:**
> D) "Noted. I'll fix it and send an updated version by end of day."

**After:**
> D) "You're right. I'll fix it and send an updated version by end of day."

**Why:** "Noted" is neutral. "You're right" is a deliberate tactical choice — it validates the other person's authority and disarms them. Jonathan adds the strategic element that makes the response a move, not just a reaction.

### Rule: Wrong answer options must be things a real person would actually say

Don't write obviously stupid wrong answers. Every option should be something a reasonable person might choose. The learning happens in the explanation of WHY it's wrong, not in making the wrong answer obviously bad.

---

## Priority 2: Explanation Tone — Sharp Friend, Not Robot Teacher

Ren (the mascot) sounds like the sharp friend in your group who's naturally good with people and breaks things down for you casually. Not a therapist. Not a professor. Not a life coach. Not WikiHow.

The bar: if you read the explanation out loud and it sounds like something a school assignment would say, rewrite it. If it sounds like your socially sharp friend leaning over and going "okay here's the thing," it's right.

### Rule: Validate first, then redirect

Never open with "Wrong because..." or "This doesn't work because..." The user just made a choice they thought was right. Lead by acknowledging their logic before showing them the better move.

**Pattern:** "Totally get why you'd go with that — here's what actually happens when you do."

### Rule: 2-3 sentences max per explanation

If an explanation needs more than 3 sentences, the insight isn't sharp enough. Compress. One clean observation beats three paragraphs of analysis. Users will skip anything that looks like a wall of text.

### Rule: No hedging, no academic language

Kill these on sight:
- Hedging: "it might be," "consider that," "one could argue," "it's possible that"
- Academic: "mismatch in register," "the optics are," "signals that you're [abstract noun]"
- Teacher voice: "it's important to," "you should have," "here's why that didn't land"

Be direct and confident like a friend who's done this before. State what happens, not what "might" happen.

### Rule: Corrections should feel like insider tips, not grades

The user should feel smarter after reading, not dumber. Frame it as "here's something most people don't see" not "here's what you got wrong." The tone is conspiratorial — you're letting them in on how the game works.

### Rule: Correct answer explanations must name the effect on the OTHER person

Add what the other person experiences when you give the correct response. This is what makes the insight feel like a real unlock — seeing the game from the other side.

### Rule: Wrong answer explanations must predict the specific cascade

Don't just say it's wrong. Say what happens NEXT. The explanation should feel like watching the future play out in 1-2 sentences.

### Before/After Examples (from actual lesson content)

**Example 1 — Lesson 1, READ step, wrong answer A (old academic tone → new friend tone):**

Before:
> If Sandra had genuinely lost her composure, she'd show more emotion. Raised voice, visible frustration, maybe cutting you off more aggressively. This was controlled. She named the issue, referenced a prior conversation, and moved on. If you read this as her getting upset, it makes you more likely to respond emotionally yourself.

After:
> Totally see why you'd read it that way, but if she'd actually lost her cool you'd see it — raised voice, cutting you off harder. She was calm and specific. Read it as emotional and you'll respond emotionally. Bad move.

**Example 2 — Lesson 2, THINK step, wrong answer B (old therapy tone → new friend tone):**

Before:
> Forty minutes of questions makes you an interviewer. The silence is a natural moment to shift gears, to actually let her in on something. A small piece of real vulnerability creates more connection in one sentence than ten more questions.

After:
> On first dates, sharing deep information ruins your aura of mystery, which makes you interesting to women. It's better to keep things light and fun. You can get deeper after knowing her for longer.

**Example 3 — Lesson 3, THINK step, wrong answer A (old generic → new specific consequence):**

Before:
> Walking up confidently and introducing yourself sounds like good advice on paper. In practice, you're interrupting someone's story to announce yourself to a group that was focused on something else. Confidence doesn't override bad timing. The group now has to stop, acknowledge you, and try to get back to their flow.

After:
> Walking up confidently and introducing yourself sounds like good advice on paper. In practice, you're interrupting someone's story to announce yourself to a group that was focused on something else. People will think "This guy is way too cocky. He must think he's the center of the world."

**Example 4 — Lesson 4, READ step, wrong answer A (old analysis → new validation-first):**

Before:
> "Thinks you're making a bad decision" takes her words at face value. But she didn't say "this is a bad idea." She said "what happens if it doesn't work out." That's a fear question. If you read this as her evaluating your decision, you'll respond with logic when she needs reassurance.

After:
> "Thinks you're making a bad decision" takes her words at face value. Her body language reveals anxiety, so whatever she says isn't a well thought out criticism. She said "what happens if it doesn't work out." That's a fear question. If you read this as her evaluating your decision, you'll respond with logic when she needs reassurance.

**Example 5 — Lesson 2, SPEAK step, wrong answer A (old verbose → new punchy with consequence):**

Before:
> Flipping it to her with "your turn" can feel playful but also a bit like you've run out of things to say. The framing makes the conversation transactional. You've been trading questions, now it's her debt.

After:
> Flipping it to her with "your turn," makes the conversation transactional. You've been trading questions, now it's her debt. She would probably ask some surface level question, which doesn't build attraction.

---

## Priority 3: Scenario Writing — Grounded, Specific, Modern

### Rule: Scenarios must specify the medium (video call, in person, text, phone)

**Before:**
> You're in the weekly team standup. Fifteen people on the call.

**After:**
> You're on a video meeting for the weekly standup. Fifteen people on the call.

**Why:** "In the standup" is ambiguous. "On a video meeting" tells you exactly where you are, which changes what social signals are available (you can't read full body language on a video call).

### Rule: Use common names, not uncommon ones

**Before:** Priya
**After:** Mia

**Why:** The ICP is self-improvement guys 18-28. Names should feel like people they'd actually encounter. Don't use names that feel like diversity casting. Use whatever name feels natural for the scenario.

### Rule: Use active verbs for what the other person does

**Before:**
> Sandra, stops you mid-update

**After:**
> Sandra, interupts you mid-update

**Why:** "Stops" is neutral. "Interrupts" carries emotional weight — the user feels it. Use verbs that make the scenario feel like it's happening to them.

---

## Priority 4: Strategic Framing — The User Is Playing a Game, Not Being Coached

### Rule: Frame social interactions as having moves, not just feelings

Jonathan's revisions consistently add strategic language. Social skills are a game with moves, reads, and counterplays.

**Key phrases that signal the right framing:**
- "validate and disarm"
- "the move most guys miss"
- "that's the move"
- "she feels confident that her authority is strong, disarming her"

**Phrases to avoid (therapy/coaching framing):**
- "here's why that didn't land"
- "that wasn't the right approach"
- "you should have..."
- "it's important to..."

### Rule: Acknowledge the user might not actually agree — and that's fine

**Before:**
> You look composed.

**After:**
> You look composed, and Sandra feels validated that you respect her authority (even if you don't).

The parenthetical "(even if you don't)" is a signature move. It tells the user: we're not asking you to be a pushover. We're teaching you how to play the game. You can disagree internally while executing the right move externally. This is the self-improvement framing, not the therapy framing.

---

## Priority 5: Structural Patterns

### Rule: Every wrong answer gets its own "Wrong: [letter]" section with an explanation

The READ and THINK steps must have individual wrong answer explanations labeled with `Wrong: A`, `Wrong: B`, etc. The SPEAK step uses the `### Explanations per answer:` format where all four are listed together.

### Rule: Mark revisions with "REV" prefix when editing existing content

When revising a draft, prefix changed wrong-answer labels with `REV` to track what was modified: `REV Wrong: D` or `REV: Explanation:`. This is a workflow marker, not user-facing.

### Rule: Vary correct answer positions across lessons

Don't stack all correct answers on B. Distribute across A/B/C/D so users can't pattern-match.

---

## Quality Checklist

Before marking a lesson complete, verify:

- [ ] Scenario specifies the medium (video call, in person, text, phone)
- [ ] Scenario uses a common first name
- [ ] Scenario has at least one sensory detail (body language, tone, environment)
- [ ] Correct answer options name the TACTIC, not just the behavior
- [ ] SPEAK correct answer includes explicit validation/agreement language where applicable
- [ ] Every wrong answer explanation predicts a specific cascade, not just "this is wrong"
- [ ] Correct answer explanation names the effect on the OTHER person
- [ ] No abstract analysis phrases ("mismatch in register," "the optics are")
- [ ] Strategic framing, not therapy framing (moves, not feelings)
- [ ] "(even if you don't)" parenthetical used where user might resist the advice
- [ ] All 4 wrong answers are things a real person would actually say
- [ ] Correct answer position varies across the lesson set
