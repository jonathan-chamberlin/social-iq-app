# Session 20 — In-Person (Holly)

**Date:** 2026-04-23
**Participant:** Holly
**Context:** Suffolk University student, pre-vet track (studying to become a veterinarian). Woman. In-person session.
**Device:** Jonathan's phone (TestFlight build).
**ICP Classification:** TBD — female college student in the ICP-B adjacent demographic (social-anxiety / overthinker segment expanded by Session 16). Not Greek life but same age and gender profile.

---

## What Happened

Holly did the rave lesson (Lesson 7 — "He Tells You He's Into Raves"). She went through the scenario, picked answers, and got through the core loop.

## Feedback

**Didn't know what EDC was.**
- The scenario text says Alex is flying to Orlando for "EDC." Holly didn't recognize the acronym — EDC = Electric Daisy Carnival, the largest rave festival in the US. Without that context, the scenario loses a chunk of its specificity (Orlando, June, week-long, the same crew every year — that's a whole identity marker if you know what EDC is, and just noise if you don't).
- Fix: spell it out on first reference in the scenario — "Electric Daisy Carnival (EDC)" — so users who aren't in rave culture can still follow the scenario.

**Didn't read the answer explanations.**
- Same pattern as Lauren, Sana, Phoebe, Nishanth, Tamok (and more — see the updated synthesis explanations-skipping section). She answered, saw whether she was right or wrong, and moved on without reading the justification text.
- This is now the dominant behavior across female testers and a meaningful chunk of the overall sample. The explanations are the product's core credibility mechanism and users are skipping past them.

**"Yay" when she got an answer correct.**
- Audible positive reaction on correct answers. This is a clean behavioral signal that the feedback loop is producing a dopamine hit — the "correct" moment feels good enough to verbalize. Whatever the correct-answer affordance is doing (visual confirmation, haptic, whatever combination), it's working.
- Contrast with the skipped explanations: she cared about being right, she did not care about why she was right. That's a product signal — the reward is in the verdict, not the reasoning.

---

## Real Situation Holly Brought to AI for Advice

Holly volunteered — unprompted — that she already uses AI to help her figure out social situations. This is direct validation of Social IQ's core thesis: the hard moments aren't first meetings, they're navigating the ambiguous behavior of people you already know.

**The situation she described:**
- Holly lives in Boston, about an hour from her hometown.
- Her best friend since third grade still lives in the hometown.
- They made plans over text to hang out. That plan was the **primary reason** Holly was making the trip home.
- The morning of the trip, Holly texted to confirm.
- The friend responded: "oh sorry the plans weren't concrete."
- Holly's read: the plans *were* concrete. The friend is rewriting history to back out without taking ownership.

**Why this is the exact problem Social IQ is for:**
- Not a stranger. Not a first meeting. A ~15-year friendship.
- The ambiguity isn't about what to say in the moment — it's about **what this behavior means** and **what to do with a person who does this**.
- Holly can't control her friend's behavior. What she can control is her interpretation and her response. That's the entire product surface.
- She already went to AI for this. The demand is proven; the question is whether our surface is better than ChatGPT for it.

**Product implications:**
- Lessons on "known-relationship ambiguity" are underweighted in the current library (most scenarios are dating-forward / early-stage). Friendship-with-history dynamics — flaking, backing out, soft rewrites of shared history — are a real content gap.
- The "interpretation" layer (what does this behavior actually mean about this person and the relationship) is at least as valuable as the "what do I say next" layer. Current lessons emphasize response; Holly's use case emphasizes diagnosis.
- If a user is already opening ChatGPT for this, our bar isn't "build the feature," it's "be a better, more trustworthy, more specific place to bring this than a general-purpose chatbot."

---

## Key Signals

1. **"EDC" clarity bug.** Simple content fix. Lesson 7 needs the festival name spelled out for users outside rave culture. Holly was the first tester to surface it; likely not the last.
2. **Skipped explanations — another data point.** Joins the growing pattern. At this point skipping is the norm among female testers, not the exception.
3. **"Yay" on correct answer.** Positive emotional signal. The correct-answer moment is rewarding enough to trigger verbal response. Protect whatever is creating this during any feedback redesign.
4. **Uses AI for real social advice — with long-term friends.** Core-thesis validation. Holly already goes to AI to interpret ambiguous behavior from a ~15-year friendship (friend rewrote concrete plans as "not concrete" the morning of the trip). This is exactly the "people you know, not first meetings" problem Social IQ is built for. Current lesson library is weighted toward dating / early-stage scenarios; friendship-ambiguity content is a real gap.

---

## Action Items

- [ ] Update Lesson 7 scenario text: replace first "EDC" with "Electric Daisy Carnival (EDC)"
- [ ] In the synthesis, count and dedicate a section to how many users skipped explanations — this is now one of the strongest patterns in the dataset
- [ ] Preserve the correct-answer affordance that produced Holly's "yay" during any explanation-format redesign — the verdict moment is a working reward
- [ ] Audit lesson library for "known-relationship ambiguity" coverage — friend flaking, soft rewrites of shared history, last-minute back-outs from someone you've known for years. Holly's scenario (best friend of 15 years, morning-of flake, "plans weren't concrete" gaslight) is a concrete starter prompt.
- [ ] In synthesis, add a "AI already being used for this" section tracking any user who mentions using ChatGPT/Claude/etc. for social situations. Holly is now a data point. This is validation that the demand exists and we're competing with general-purpose chatbots, not a greenfield category.
