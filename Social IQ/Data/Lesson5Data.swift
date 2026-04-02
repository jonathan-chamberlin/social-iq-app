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
                            text: "\"Taking advantage\" makes it sound like he's scheming. He's not. He's just taking the easiest path. That's different from not caring. If you read this as him using you, you'll come in angry when what you actually need is boundaries."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-read-B",
                        prefix: "B",
                        label: "Danny genuinely needs help and doesn't have other options",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "That's probably what Danny would tell you. But four times in eight months? He has other options. They're just harder than calling you. If you buy this framing, you become the permanent solution to a problem you can't fix."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-read-C",
                        prefix: "C",
                        label: "Danny has learned you're a safe ask and conflates the relationship with financial access",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "This isn't a crisis. It's a system. He's found his path of least resistance and it runs through you. The three weeks of silence after you said no last time? That was him recalibrating, not punishing you. The relationship is real. The money pattern is also real. You have to handle them separately."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-read-D",
                        prefix: "D",
                        label: "Danny is testing whether you'll show up for family when it counts",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "This isn't a loyalty test. Danny needs rent money. But if you frame it that way, you'll feel guilty saying no, and that guilt is exactly what keeps the cycle going."
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
                            text: "Now you're an auditor. He gives a reason, you evaluate it, he gets defensive, and suddenly you're arguing about the past. Plus you just signaled that the right excuse could unlock more cash."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-think-B",
                        prefix: "B",
                        label: "Separate the relationship from the request: love him, decline the loan, keep them distinct",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Separate the love from the money. That's the move. He can't guilt you with \"I guess you don't care about family\" if you've already named the relationship as its own thing. No audit, no repayment plan he won't follow, no \"last time\" ultimatum you can't enforce."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-think-C",
                        prefix: "C",
                        label: "Offer a smaller amount with a written repayment plan",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Sounds like a reasonable compromise, but now you're a lender with terms Danny won't meet. When he doesn't pay, you've added financial resentment on top of the existing pattern. Half-measures make this worse."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-think-D",
                        prefix: "D",
                        label: "Tell him you'll help this time but this is the last time",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Be honest. You've probably said some version of \"this is the last time\" before. Danny knows it too. Ultimatums you can't enforce just teach people to ignore your boundaries."
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
                            text: "He gives you a reason, you evaluate it, and now you're negotiating instead of holding a boundary."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-speak-B",
                        prefix: "B",
                        label: "\"Okay, but this is the last time. I need you to figure out a better system.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "\"Last time\" is a soft boundary he'll test again. \"Figure out a better system\" is homework he's never going to do."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-speak-C",
                        prefix: "C",
                        label: "\"I'm not going to lend you money right now and I love you. You got this.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Two clear things: the no is real and the love is real. They don't cancel each other out. He can't pull the \"you don't care about family\" card because you already named the relationship separately."
                        )
                    ),
                    LessonOption(
                        id: "lesson-5-speak-D",
                        prefix: "D",
                        label: "\"I can do $150 if you pay me back by the 15th.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
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
