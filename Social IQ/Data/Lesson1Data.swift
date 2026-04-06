//
//  Lesson1Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson1 = Lesson(
        id: "lesson-1",
        title: "Critical Feedback in Front of the Team",
        category: .workplace,
        difficulty: .intermediate,
        scenarioText: "You're on a video meeting for the weekly standup. Fifteen people on the call. Your manager, Sandra, interupts you mid-update and says, \"I need to be honest, the format of this report isn't working for the client. We talked about this last week.\" Your face goes hot. You know the rest of the team is watching to see how you handle it.",
        steps: [
            LessonStep(
                id: "lesson-1-read",
                label: "READ",
                question: "What's driving Sandra's behavior in this moment?",
                options: [
                    LessonOption(
                        id: "lesson-1-read-A",
                        prefix: "A",
                        label: "She's genuinely frustrated and lost her composure",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "fair read - but lost composure looks different. she was calm and specific, not heated.",
                            text: "Totally see why you'd read it that way, but if she'd actually lost her cool you'd see it: raised voice, cutting you off harder. She was calm and specific. Read it as emotional and you'll respond emotionally. Bad move."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-read-B",
                        prefix: "B",
                        label: "She's trying to demonstrate authority in front of the group",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "you saw it. managers who just want to correct you pull you aside. she did it on the call for a reason.",
                            text: "Here's the thing: managers who just want to correct you do it in private. She did it on the call because there's a performance element. She's showing the team she holds people to standards. Once you see that, the right response becomes obvious."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-read-C",
                        prefix: "C",
                        label: "She's trying to embarrass you to establish dominance over the team",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "close, but \"embarrass you\" makes it personal. she's managing her image, not targeting yours.",
                            text: "Makes sense on the surface, but \"embarrass you\" assumes she's out to get you. She's managing how the team sees her, not targeting you. If you read this as an attack, you'll get defensive or shut down, and both of those lose."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-read-D",
                        prefix: "D",
                        label: "She's testing whether you can handle criticism professionally",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "solid instinct, but a test implies she planned this. she didn't - she had a real problem and went public with it.",
                            text: "\"Testing you\" means she planned this as a coaching moment. She didn't. She had a real issue and brought it up publicly. If you treat it like a test, you'll overperform and come across weird."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-1-think",
                label: "THINK",
                question: "What's the most effective move?",
                options: [
                    LessonOption(
                        id: "lesson-1-think-A",
                        prefix: "A",
                        label: "Explain your reasoning so the team understands your perspective",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "totally get why - your side of the story matters. but to 15 people watching, explaining right now just looks like you're arguing.",
                            text: "I get the instinct, but explaining yourself right now looks defensive to everyone watching. The team hears \"he's arguing with Sandra.\" Now a 10-second correction becomes a full debate."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-think-B",
                        prefix: "B",
                        label: "Apologize profusely to show accountability",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "accountability is right, but big apologies in public overshoot. she flagged a problem, not asked you to grovel.",
                            text: "Big apology in front of 15 people makes this way bigger than it needs to be. Sandra flagged a problem. She didn't ask you to grovel. Over-apologizing makes you look shook."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-think-C",
                        prefix: "C",
                        label: "Agree to validate and disarm her, then follow up during your one on one",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "THAT. you take the hit clean in public, then have the real conversation where it actually counts.",
                            text: "Everyone's watching how you handle pressure. Agree, move on, look like you can take a hit without drama. Sandra feels her authority is intact (even if you disagree). Then you have the real conversation in your 1-on-1 where you can actually push back."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-think-D",
                        prefix: "D",
                        label: "Push back gently to show you're not a pushover",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "the instinct to hold your ground is good - wrong room. gentle pushback in front of 15 people still forces her to dig in.",
                            text: "Even \"gentle\" pushback in front of the whole team reads as you challenging her publicly. If she's wrong, handle it in private. Doing it here forces her to double down."
                        )
                    )
                ],
                correctIndex: 2
            ),
            LessonStep(
                id: "lesson-1-speak",
                label: "SPEAK",
                question: "Pick the best response.",
                options: [
                    LessonOption(
                        id: "lesson-1-speak-A",
                        prefix: "A",
                        label: "\"I thought I made the changes we discussed, but I'll revisit it and get it right.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "\"i thought\" is a subtle push back. even when you're right, that phrasing makes everyone watch the argument instead of moving on.",
                            text: "\"I thought I made the changes\" is a subtle defense. Sandra and everyone else hears you questioning her. Now a quick correction becomes a back-and-forth."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-speak-B",
                        prefix: "B",
                        label: "\"I'm so sorry, Sandra, I should have caught this before the meeting.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "owning it is right, but this much apology in public signals you can't absorb a hit without falling apart.",
                            text: "Way too much apology. The team's watching. Over-apologizing tells them you can't take a hit without crumbling."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-speak-C",
                        prefix: "C",
                        label: "\"Can you clarify exactly what's not working? I want to make sure I understand.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "good question, wrong time. asking for details now keeps the whole call sitting in the awkward moment longer than it needs to be.",
                            text: "Asking for details right now drags out the awkward moment for everyone. Save that for when you follow up privately."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-speak-D",
                        prefix: "D",
                        label: "\"You're right. I'll fix it and send an updated version by end of day.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "clean read. agreed, committed, gave a deadline. meeting moves. that's exactly how you take a hit without losing ground.",
                            text: "Clean. You agreed, committed to a fix, gave a deadline. Meeting moves on. You look composed, Sandra feels respected (even if you don't actually agree). Handle the details later in private."
                        )
                    )
                ],
                correctIndex: 3
            )
        ]
    )
}
// swiftlint:enable line_length
