# Base44 Prompt 2 — Add scenario image + wrong answer hints

Copy everything below the line and paste into Base44. Upload the Alex image in the same message.

---

Two changes:

## 1. Add the scenario image

I'm uploading an image of Alex (the frustrated coworker). Display this image at the top of the READ step screen, above the scenario text. It should be full-width within the card, with rounded corners, and a slight darkened overlay at the bottom edge so the text below it stays readable. The image should set the emotional tone before the user reads the quote.

## 2. Wrong answer hints during the scenario

Change the behavior when a user picks a WRONG answer on any of the 3 steps (READ, THINK, SPEAK). Instead of silently moving to the next step, show a yellow/amber hint banner that slides in below the selected option. The banner should:

- Have a warm yellow/amber background (like #2A2000 with a #F5A623 left border)
- Show a short explanation of what would happen if they went with that wrong choice
- Include a "try again" button that lets them re-pick

The user cannot advance to the next step until they pick the correct answer. When they pick the correct answer, show a green explanation banner below the selected option (same layout as the yellow hint banners but with a green left border and dark green background like #002A00 with a #4CAF50 left border). The green banner shows why that answer is correct. Include a green "Next" button at the bottom of the banner. The user must click "Next" to proceed to the next step — do NOT auto-advance.

Here are the exact texts for every answer — green explanations for correct, yellow hints for wrong:

### Step 1 — READ

If they pick B) Frustrated (CORRECT — green banner):
"'I don't even know why I try anymore.' That's the line. He's not blaming anyone. He's not worried about what happens next. He put in six months and got nothing, and now he's questioning whether effort even leads anywhere. That's frustration. Once you see it, the next step becomes obvious."

Wrong answers:

If they pick A) Angry:
"Angry people want someone to blame. But listen to what Alex is actually saying. He's not pointing at the person who got the promotion. He's questioning whether his own effort matters. That's about him, not about someone else."

If they pick C) Defensive:
"Defensive people assert their worth. 'I deserve this.' But Alex isn't doing that. 'I don't even know why I try' is the opposite. He's given up on asserting anything. That's resignation, not self-protection."

If they pick D) Anxious:
"Anxious people worry about what's coming. But Alex isn't asking 'what if I get fired?' He's stuck on what already happened. All his energy is pointed backward at wasted effort, not forward at future risk."

### Step 2 — THINK

If they pick B) Restore agency (CORRECT — green banner):
"When someone is frustrated, the link between effort and outcome feels broken. They put in the work and it didn't matter. So the move is to reconnect those two things. Remind them their effort was real. Then give them a reason to believe they still have options. You're not fixing the problem. You're restarting their engine."

Wrong answers:

If they pick A) Advice:
"Advice right now sounds like 'here's what you should have done differently.' Alex's brain is still processing the gap between effort and outcome. He can't hear a game plan yet. He's not there."

If they pick C) Distraction:
"Changing the subject tells Alex his frustration isn't worth sitting with. He'll stop venting to you, but he won't feel better. And next time something happens, he probably won't bring it to you."

If they pick D) Validation:
"'That really sucks' feels right. But here it actually confirms the helplessness. You're agreeing the situation is bad without showing him a way through it. Alex doesn't need agreement that things are broken. He needs to feel like he still has moves to make."

### Step 3 — SPEAK

If they pick B) "That's brutal..." (CORRECT — green banner):
"'That's brutal' acknowledges the pain. 'Six months is real work, that doesn't just disappear' validates the effort. And then 'what are you thinking about doing next?' is the move. That question gives him back control. It implies he has options without telling him what they are. You didn't give advice. You gave him back his sense of agency."

Wrong answers:

If they pick A) "You'll get it next time":
"This sounds encouraging but it's hollow. It skips over six months of real work with a generic reassurance. And it implies the only path forward is to sit and wait for another shot. That's the exact helpless feeling he's already stuck in."

If they pick C) "Maybe you should talk to your manager":
"This jumps straight to problem-solving before Alex feels heard. He's still stuck on the fact that his effort didn't pay off. He can't take action steps right now because he hasn't processed the emotion yet. Solutions before acknowledgment feel dismissive."

If they pick D) "At least you still have a job":
"This reframes his frustration as something he shouldn't have. It's a comparison designed to make you feel better, not him. He'll shut down after this. And next time something real happens, he won't tell you about it."
