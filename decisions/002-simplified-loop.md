# Decision 002: Simplify the Social IQ Loop from 5 Levels to 3 Steps

**Date:** 2026-03-27
**Status:** Decided

---

## Context

The original Social IQ Loop had 5 named levels (L1–L5), a 6-branch emotion tree at L3, and a feedback loop with multiple arrows. It was designed as a comprehensive framework — useful as a developer reference, but too complex for the target user (young, socially anxious, potentially neurodivergent) to learn and internalize.

Key problems with the original:
- **Too many branches.** L3 had 6 emotion-specific protocols (calm, anxious, defensive, angry, excited, stubborn) displayed as parallel paths. A first-time learner sees a flowchart, not a skill.
- **Too much text.** Each level had detailed descriptions that made the loop feel academic rather than actionable.
- **Not memorable.** "L1 Self-Awareness → L2 Observation → L3 State ID + Response Protocol → L4 Reaction Prediction → L5 Calibrated Response" can't be recalled mid-conversation.
- **Violates App Mafia KISS rule.** If a 7-year-old can't use it and a 70-year-old can't remember it, it's too abstract.

The founder sketched a simplification (observe → identify state → what they need → think of words → say it) but felt it was still clunky because steps 3 and 4 blurred together.

---

## Decision

**Replace the 5-level loop with 3 steps: READ → THINK → SPEAK.**

The emotion-specific protocols (anxious → lower stakes, defensive → validate first, etc.) move out of the loop itself and become **State Protocol reference cards** — progressive content the app teaches over time, applied within the THINK step.

---

## The New Loop

### READ — Check yourself, then read them.
- Am I calm enough to do this? (If no, pause.)
- What's their face, body, tone saying?
- What state are they in?

### THINK — What do they need right now?
- Based on their state, what would make them feel heard / important / seen?
- If I say this, will it land?

### SPEAK — Say it. Then watch.
- Words + tone + timing.
- Watch their reaction. Loop back to READ.

---

## Reasoning

### Three words you can remember mid-conversation
The original loop required memorizing 5 level names and understanding a branching flowchart. READ → THINK → SPEAK can be recalled in the moment it matters — during an actual conversation.

### Self-awareness merges into READ, not dropped
The founder's sketch dropped self-awareness (old L1). That's actually the highest-leverage step for the target audience — people with social anxiety are usually reacting from their own noise. In the new loop, "Am I calm enough to do this?" is the first check inside READ, preserving its importance without giving it a separate level.

### Emotion protocols become content, not structure
The 6-branch emotion tree was the biggest complexity driver. By pulling protocols into separate reference cards, the loop stays stable as a universal process. New emotional states (sad, lonely, jealous) can be added over time as app content without redesigning the core framework.

### Maps cleanly to app screens
Each step maps to one screen type in scenario practice:
- **READ screen:** Observe a face/clip, pick the emotion
- **THINK screen:** Given the state, pick what they need
- **SPEAK screen:** Pick the best response

One primary action per screen. Follows CalAI's "one button" principle.

### Enables progressive depth (gamification)
Beginners learn the 3-step loop. As they level up, the app introduces State Protocols as unlockable skills within the THINK step. This is gamification that actually teaches — complexity earned through play, not dumped upfront.

---

## What Changed

| Before | After |
|--------|-------|
| 5 levels (L1–L5) | 3 steps (READ → THINK → SPEAK) |
| 6-branch emotion tree in L3 | Emotion protocols as separate reference cards |
| Flowchart with arrows | Linear loop with one feedback arrow |
| Academic framework | Memorable, actionable process |

---

## Previous Version

The original 5-level loop is archived at [archives/social-iq-loop-v1.md](../archives/social-iq-loop-v1.md).
