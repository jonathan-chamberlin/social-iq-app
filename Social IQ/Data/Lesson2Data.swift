//
//  Lesson2Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson2 = Lesson(
        id: "lesson-2",
        title: "First Date Conversation Dies",
        category: .dating,
        difficulty: .intermediate,
        scenarioText: "You're thirty minutes into a first date Mia at an arcade. The conversation has been solid. You've been playing pool and talking between shots. But it's been a full minute of silence. She looks at you and gives a calm smile. You can feel the urge to fire off the next question, but you've been talking a lot and you're running out of stuff to say.",
        steps: [
            LessonStep(
                id: "lesson-2-read",
                label: "READ",
                question: "What does this silence actually mean?",
                options: [
                    LessonOption(
                        id: "lesson-2-read-A",
                        prefix: "A",
                        label: "The date is going poorly and she's looking for an exit",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "30 minutes of good conversation and then one pause? That's not a red flag. If she wanted out she'd be checking her phone and giving one-word answers. She smiled at you. Relax."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-read-B",
                        prefix: "B",
                        label: "You're both in a natural rhythm and silence is normal",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "She smiled. That's not boredom, that's comfort. Most guys panic and rush to fill every silence, and she can feel that energy shift. The pause is fine. She's enjoying being with you."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-read-C",
                        prefix: "C",
                        label: "She's bored and waiting for you to entertain her",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "\"She needs me to entertain her\" puts you in performer mode. That's not how good dates work. If you start scrambling to fill the silence, she'll sense the desperation. Not attractive."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-read-D",
                        prefix: "D",
                        label: "She's nervous and needs you to keep the energy up",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "People don't give calm smiles when they're anxious. If you read her as nervous, you'll start second-guessing yourself and overcompensating. That's when you start talking too much."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-2-think",
                label: "THINK",
                question: "What's the best move in this moment?",
                options: [
                    LessonOption(
                        id: "lesson-2-think-A",
                        prefix: "A",
                        label: "Ask her the most interesting question you can think of",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "You've been asking questions for 30 minutes. You're already in interview mode. Another question, even a great one, keeps that dynamic going. Nobody wants to feel like they're being interviewed."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-think-B",
                        prefix: "B",
                        label: "Let the silence breathe, then offer something deep about yourself",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Going deep on a first date kills the mystery. That's what makes her want to see you again. Keep it light and fun. You can go deeper once she actually knows you."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-think-C",
                        prefix: "C",
                        label: "Let there be silence, then make a joke",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Women love to laugh. A joke right now keeps the vibe playful, which is exactly where you want a first date to be."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-think-D",
                        prefix: "D",
                        label: "Suggest moving somewhere else to change the energy",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "She just smiled at you. Things are going well. There's no energy to \"change.\" Moving locations right now is solving a problem that doesn't exist."
                        )
                    )
                ],
                correctIndex: 2
            ),
            LessonStep(
                id: "lesson-2-speak",
                label: "SPEAK",
                question: "Pick the best response to the silence.",
                options: [
                    LessonOption(
                        id: "lesson-2-speak-A",
                        prefix: "A",
                        label: "\"Okay, I've been asking all the questions. Your turn.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "\"Your turn\" makes the conversation feel like a transaction. She'd probably ask some surface-level question back, which doesn't build attraction."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-speak-B",
                        prefix: "B",
                        label: "\"So what's something most people don't figure out about you until way later?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Decent question, but you're still in interview mode. You're asking, not vibing."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-speak-C",
                        prefix: "C",
                        label: "\"I hope you don'y cry yourself to sleep with how bad I'm beating you.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Playful tease. She's obviously not going to cry about losing at pool. That's what makes it funny. The absurd exaggeration keeps things light and flirty."
                        )
                    ),
                    LessonOption(
                        id: "lesson-2-speak-D",
                        prefix: "D",
                        label: "\"I feel like we've covered the basics. What do you actually care about?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Still an interview question, and way too deep for a first date at an arcade. Keep it playful."
                        )
                    )
                ],
                correctIndex: 2
            )
        ]
    )
}
// swiftlint:enable line_length
