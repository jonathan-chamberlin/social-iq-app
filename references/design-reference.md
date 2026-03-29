# Social IQ Design Reference

Date: March 22, 2026

---

## Primary Action (Decided)

**Goal:** Always know what to say and how to say it.

**Primary action:** Read a scenario, pick a response, get a score + explanation.

The explanation breaks down:
- Why the chosen answer would land poorly (what effect it has on the other person)
- Why the correct answer works (what effect it has on the other person's emotional state)
- The underlying Social IQ Loop principle (READ → THINK → SPEAK) behind it

See [decisions/001-primary-action.md](../decisions/001-primary-action.md) for full reasoning on why this was chosen over an AI advisor or voice roleplay model.

**Secondary actions (post-traction only):**
- Learn to read and identify someone's emotional state based on tone and nonverbals
- Learn to predict how someone will react based on what you say

Launch with only the primary action. All marketing should be built around it. Secondary actions exist to support it, not compete with it.

**Aha moment:** When the user answers a scenario question about what to say and why — they instantly see the value. This must be glanceable within 2 seconds. The value they're getting should be obvious, and the app name/logo should be clearly visible.

---

## App Name & Tagline

**Name: Social IQ** (decided) — signals intelligence + strategy, attracts smart guys who can't talk to people.

**Tagline and subtitle need to be finalized.** See ASO keyword strategy (not yet done) to determine the search-optimized subtitle vs. marketing tagline.

**ASO note:** The best-performing education apps keep subtitles extremely literal and keyword-rich — optimized for App Store search, not cleverness. "Learn Spanish, French, German" is boring but indexes hard. Aspirational subtitles are better for conversion once someone lands on your page, but won't help you get found organically. Consider two versions: one for the listing subtitle (search-optimized) and one for onboarding/marketing copy.

### Education App Subtitle Examples

| App | Title | Subtitle |
| --- | --- | --- |
| Duolingo | Duolingo – Language Lessons | Learn Spanish, French, German |
| Impulse | Impulse - Brain Training | *(title carries the full concept)* |
| Blinkist | Blinkist: Book Summaries Daily | Big Ideas in 15 Min |
| Headway | Headway | Daily Micro Learning |
| Lumosity | Lumosity | Brain Training Games |
| Imprint | Imprint | Visual Micro Learning |
| Brilliant | Brilliant | Learn Interactively |
| Mimo | Mimo | Learn Coding/Programming |

### Social Capital Framing

When someone sees you using this app, one of two frames activates:
- **Bad frame:** "They can't make friends" → social capital drops
- **Good frame:** "They're sharpening how they read people" → social capital rises

The name needs to signal **intelligence + strategy**, not deficiency. Think how "I go to therapy" became a flex — it reframed as self-awareness, not weakness.

---

## Brand & Identity

### Brand Aesthetic

Target audience: male, 18-28, self-improvement oriented. Reads about charisma, influence, and human nature. Adjacent to the looksmaxxing / self-improvement trend but wants the social edge, not just the physical one.

Visual language for this demographic:
- Clean, dark, masculine — confident without being aggressive
- Deep backgrounds (near-black), sharp contrast, minimal clutter
- Typography: strong, modern, no rounded playful fonts — this is a tool, not a toy
- No gamified or cute visual elements; closer to a high-end fitness app than a language learning app
- Lowercase copy still works — it reads as sharp and low-effort-cool, not goofy
- Imagery: real young men in social situations — confident, not staged-happy
- Gold or electric blue as accent colors signal intelligence and precision, not fun

Font rule: no more than 3 fonts total. Having a separate font for the logo vs. in-app text is fine.

---

## The Social IQ Loop (EQ Skill Tree)

The core loop is **READ → THINK → SPEAK.** Each step maps to a screen type in scenario practice (one primary action per screen):

- **READ** — Check yourself, then read them (face → body → tone → words → identify state)
    - Listening
    - Observing
- **THINK** — What do they need right now? Will this land?
    - State Protocols (anxious, defensive, angry, excited, stubborn — unlocked progressively)
    - Warmth, Confidence, Humor, Praise, Calibration (reading when to be blunt vs. soft)
- **SPEAK** — Say it. Watch their reaction. Loop back to READ.
    - Words + tone + timing + framing

---

## Competitive Benchmark: Primary Actions

| App | Core Action | Time |
| --- | --- | --- |
| **Duolingo** | Complete one bite-sized lesson — translate, match, speak a word | ~5 min |
| **Impulse** | Play one cognitive game — memory, attention, or math puzzle | ~5–7 min |
| **Blinkist** | Read or listen to one book "blink" — key ideas condensed | ~15 min |
| **Headway** | Read one daily micro book summary with visual cards | ~5 min |
| **Lumosity** | Play your personalized daily brain workout — 3 cognitive games | ~10 min |
| **Imprint** | Swipe through one visual infographic on a complex concept | ~5 min |
| **Brilliant** | Solve one interactive science/math problem through guided steps | ~10 min |
| **Mimo** | Fill in one line of code to complete a lesson | ~5 min |
| **Khan Academy** | Watch one short video explanation, then answer practice problems | ~10 min |

Every successful education app's core action is: under 15 minutes, produces a visible output (score/XP), and signals something positive about the user. The highest-revenue apps (Duolingo $35M, Impulse $2M) have the most gamified core action — not the most educational one.

Social IQ maps closest to **Impulse** — a short game that produces a score. The critical difference: the score signals *social intelligence*, not raw cognition. "You read that situation better than 84% of people" hits harder than "you scored 91/100."

---

## Onboarding

### Core Input/Output Quiz

**Inputs:**
- Sign in (Apple, Google, email)
- Name
- Age (generational framing)
- What area do you want to level up first? (career networking / dating / commanding a room / reading people)
- Current situation (e.g., "I'm forgettable in group settings" / "I freeze in high-stakes conversations" / "I can't tell if I'm landing")
- What's the next unlock you want? (e.g., "Get the promotion" / "Be the guy she can't stop thinking about" / "Own every room I walk into")
- What's held you back? (e.g., "I know the theory but freeze in the moment" / "Advice I find is too vague" / "I read wrong and say the wrong thing")
- Minutes per day available
- Permissions: notifications, microphone

**Outputs:**
- Personalized training path built around their stated goal
- Most relevant scenarios to start with (career, dating, social dynamics)
- XP bars across the Social IQ Loop steps (READ, THINK, SPEAK)

### Onboarding Length

Single-player experience with consistent rewards (like CalAI and Duolingo):
- **Long onboarding** for the standard download flow (drives sunk cost → paywall conversion)
- **Short onboarding** for the challenge link flow (recipient is already sold, maximize conversion speed)

### Onboarding Flow

Modeled on Quittr and CalAI: **Personal questionnaire → Calculate result → Scare screens → Uplift screens → Paywall**

**Phase 1 — Personal Questionnaire (Goal-focused)**
Ask questions that surface what the user is trying to unlock — career, dating, social status. Frame everything around competitive advantage, not deficiency. Language: "level up," "master," "unlock," "read," "command." The longer they spend here, the stronger the sunk cost effect. The calculating screen doesn't actually do anything — it just extends time on onboarding intentionally.

**Phase 2 — Analysis Result (Scare screen)**
Show a score or assessment that makes the cost of weak social skills feel real. This is not "you have a problem" — it's "here's what this has already cost you." Surface the specific losses: the promotion that went to someone less qualified, the girl who went cold after a great first impression, the group that stopped inviting you, the meeting where you said something smart and no one reacted. Dramatic visuals work here (e.g., Quittr's big red screen). Then follow with specific-situation questions that deepen the cost awareness.

**Phase 3 — Uplift Screens**
Reframe entirely: social skills are not a personality trait — they are a learnable system. Language: confident, direct, slightly edgy. Self-improvement YouTube, not therapy office.
- Lead with: *"Social skills aren't a personality trait. They're a system. And systems can be practiced."*
- Transformation framing: "guys who trained this got promoted, locked in the girl, became the guy people remember" — not "reduced anxiety"
- Testimonials framed around charisma gains and social outcomes, not emotional relief (e.g., "I started getting invited to things I didn't even know existed" / "My manager pulled me aside and said I'd changed — I hadn't changed, I'd just started paying attention")
- Chart: doing it alone vs. using a system (faster, more measurable progress)
- Goal selection framed as aspirational: the version of you who reads every room, every time

**Phase 4 — Pre-paywall priming**
Tell the user they now have a system — and it's time to start using it.

**Phase 5 — Referral code screen**
Ask if they have a referral code. Tracks which influencers drove traffic.

**Phase 6 — Rating screen**
Ask for a rating. Low conversion individually, significant at scale.

**Key principles:**
- Users want to feel the app was built for them: *"This app understands me and my situation."*
- Progress bar at the top so onboarding doesn't feel endless
- Switch up screen types — don't do ten questions in a row
- Use lottiefiles.com for animated screen illustrations

---

## Emotional Hooks & Core Human Drivers

The deepest driver for this audience isn't "learn social skills" — it's **"I want a competitive edge most guys don't have."**

**Hook hierarchy:**
- **Fear:** "I'm losing ground to guys who just get it — in rooms, in dating, at work"
- **Desire:** "I want to be the guy people remember, follow, and want around"
- **Identity:** "I read situations other people miss entirely"

**In-app trigger:** After a correct answer, don't say "Correct." Say something like *"You caught that. Most people miss it entirely."* — feeds the identity desire and makes them feel rare and perceptive.

---

## Paywall

People are already bought in by the time they reach the paywall. Keep it simple:
- List benefits upfront in text
- Show a spread of app screens visually
- Summarize features concisely and make it easy to pay
- Use a template — don't customize until $100k/month or more
- Reference Superwall for solid examples

---

## Social Proof

**Layer 1 — In-app signals:**
- "14,000 people completed this scenario today"
- Live counter on harder scenarios: "Only 23% of people got this right"

**Layer 2 — Shareable proof:**
- EQ archetype result card (shareable image) — positions user as self-aware, not deficient
- Score percentile: *"You're in the top 12% of people who've taken this"*

**Layer 3 — Aspirational testimonials:**
- Frame around life outcomes, not app features
- Example: *"I got promoted 3 months after starting this"* — not *"Great app!"*

---

## Magic Moments

- Use haptics at key moments (correct answer, score reveal, challenge sent)
- These are the micro-moments where the app feels alive and rewarding
- The aha moment is when the user answers a scenario question and sees exactly why their answer was right or wrong, with their percentile score displayed
