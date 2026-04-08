//
//  Lesson5Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson5 = Lesson(
        id: "lesson-5",
        title: "Sibling Asking for Money Again",
        category: .family,
        difficulty: .intermediate,
        scenarioText: "Your brother Danny calls on a Tuesday night. You know what's coming before he finishes his second sentence. He needs $300 to cover rent. This is the fourth time in eight months. You lent him money twice before. The third time you said no and he didn't call for three weeks. He's not a bad person. He's just stuck in a cycle and you're an easy option.",
        steps: [
            LessonStep(
                id: "lesson-5-read",
                label: "READ",
                question: "What's the real dynamic here?",
                options: [
                    LessonOption(
                        id: "lesson-5-read-A",
                        prefix: "A",
                        label: "Danny is taking advantage of you and doesn't care about the relationship",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Makes sense to go there, four times feels like scheming. But there's a difference between easy and malicious.",
                            text: "If you read this as him using you, you'll come in angry when what you actually need is boundaries."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-read-B",
                        prefix: "B",
                        label: "Danny genuinely needs help and doesn't have other options",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "That's the story he tells himself. Four times says he has options, they're just harder than you.",
                            text: "That's probably what Danny would tell you. But if you buy this framing, you become the permanent solution to a problem you can't fix."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-read-C",
                        prefix: "C",
                        label: "Danny has learned you're a safe ask and conflates the relationship with financial access",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "THAT. This isn't a crisis, it's a system. Gottman's research on relationship bids shows people unconsciously learn who will turn toward them. You saw it.",
                            text: "He's found his path of least resistance and it runs through you. The three weeks of silence after you said no last time? That was him recalibrating, not punishing you. The relationship is real. The money pattern is also real. You have to handle them separately."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-read-D",
                        prefix: "D",
                        label: "Danny is testing whether you'll show up for family when it counts",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Totally get it, family framing hits hard. But that guilt is exactly the lever keeping you in the cycle.",
                            text: "This isn't a loyalty test. Danny needs rent money. If you frame it that way, you'll feel guilty saying no."
                        )
                    )
                ],
                correctIndex: 2
            ),
            LessonStep(
                id: "lesson-5-think",
                label: "THINK",
                question: "What's the right approach for this call?",
                options: [
                    LessonOption(
                        id: "lesson-5-think-A",
                        prefix: "A",
                        label: "Ask what happened to the money from last time before deciding",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Solid instinct, but now you're the auditor. A good enough excuse and you're back on the hook.",
                            text: "He gives a reason, you evaluate it, he gets defensive, and suddenly you're arguing about the past."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-think-B",
                        prefix: "B",
                        label: "Separate the relationship from the request: love him, decline the loan, keep them distinct",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "Clean read. Gottman's research on turning toward vs. turning away shows you can honor a relationship while declining a request. You can't guilt-trip someone who already named the love out loud.",
                            text: "Separate the love from the money. That's the move. He can't guilt you with \"I guess you don't care about family\" if you've already named the relationship as its own thing. No audit, no repayment plan he won't follow, no \"last time\" ultimatum you can't enforce."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-think-C",
                        prefix: "C",
                        label: "Offer a smaller amount with a written repayment plan",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Looks like structure, but you're still in. And when he misses the deadline, now you've got debt and resentment.",
                            text: "Sounds like a reasonable compromise, but now you're a lender with terms Danny won't meet. When he doesn't pay, you've added financial resentment on top of the existing pattern. Half-measures make this worse."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-think-D",
                        prefix: "D",
                        label: "Tell him you'll help this time but this is the last time",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "You've said some version of this before. Danny knows it. Ultimatums you won't enforce just teach people to wait you out.",
                            text: "Empty ultimatums teach people your limits aren't real. Next time he calls, he already knows you'll fold."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-5-speak",
                label: "SPEAK",
                question: "Danny just asked for $300 for rent. Pick the best response.",
                options: [
                    LessonOption(
                        id: "lesson-5-speak-A",
                        prefix: "A",
                        label: "\"Danny, what happened to the $200 I gave you two months ago?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Asking for receipts feels fair, but now he just needs a good enough story and you're back in it.",
                            text: "He gives you a reason, you evaluate it, and now you're negotiating instead of holding a boundary."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-speak-B",
                        prefix: "B",
                        label: "\"Okay, but this is the last time. I need you to figure out a better system.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "You said yes, then softened it with rules he won't follow. That's not a boundary, that's a delay.",
                            text: "You gave him money and a lecture. He heard the money part."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-speak-C",
                        prefix: "C",
                        label: "\"I'm not going to lend you money right now and I love you. You got this.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "You caught that. Gottman's research shows you can turn toward the person while turning away from the request. No AND love in the same breath. That's exactly how you close the guilt door.",
                            text: "He can't pull the \"you don't care about family\" card because you already named the relationship separately."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-speak-D",
                        prefix: "D",
                        label: "\"I can do $150 if you pay me back by the 15th.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Half a no is still a yes. The 15th comes and goes, and now you're the one who feels weird about it.",
                            text: "Half a boundary, half a yes. You've lent money with a deadline he won't hit, and now you get to feel bad chasing it."
                        )
                    )
                ],
                correctIndex: 2
            )
        ]
    )
}
// swiftlint:enable line_length
