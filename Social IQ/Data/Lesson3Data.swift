//
//  Lesson3Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson3 = Lesson(
        id: "lesson-3",
        title: "Entering a Group at a Party",
        category: .friendships,
        difficulty: .intermediate,
        scenarioText: "You're at a house party at Jordan's place. You know Jordan but not most of the people here. Across the room, there's a group of four people (two guys, two women) laughing about something. The guy with the cool shirt gestures and the group cracks up again. You want to join. You don't know any of them.",
        steps: [
            LessonStep(
                id: "lesson-3-read",
                label: "READ",
                question: "What's the social dynamic in that group right now?",
                options: [
                    LessonOption(
                        id: "lesson-3-read-A",
                        prefix: "A",
                        label: "They're closed off and not interested in meeting new people",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "They're laughing and being loud. That's not \"closed off.\" Closed-off groups face inward, give short answers, avoid eye contact. This group has open energy. You just need to time your approach right."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-read-B",
                        prefix: "B",
                        label: "They're mid-story, and the group has a clear center of mass",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Cool shirt guy is clearly running the show right now. The group has a rhythm. Walk up mid-punchline and you kill the moment. Wait for the natural pause after the laugh."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-read-C",
                        prefix: "C",
                        label: "They're bored and would welcome anyone who walks up with confidence",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "They're clearly entertained already. Walking up assuming they need you is the wrong frame. That's how you come across as the guy who interrupts instead of integrates."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-read-D",
                        prefix: "D",
                        label: "They're testing whether strangers can break in without an introduction",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Nobody at a house party is running entrance exams. If you approach like you're being evaluated, you'll come across as a try-hard. People pick up on that instantly."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-3-think",
                label: "THINK",
                question: "What approach actually works here?",
                options: [
                    LessonOption(
                        id: "lesson-3-think-A",
                        prefix: "A",
                        label: "Walk up to the center of the group, make eye contact with the group's leader (cool shirt guy), and introduce yourself",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Sounds like solid advice, but in practice you're interrupting someone's story to announce yourself. People will think \"this guy thinks he's the center of the world.\""
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-think-B",
                        prefix: "B",
                        label: "Walk up to the edge of the group, listen and make eye contact with whoever is talking for 10-15 seconds, then build on something someone just said",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Listen for 10-15 seconds, then build on what they're already talking about. Now you look like someone who was paying attention, not someone barging in. People love feeling like others are interested in them. Most people miss this."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-think-C",
                        prefix: "C",
                        label: "Ask Jordan to introduce you so you have social proof going in",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "At a high-status event, sure. But this is a house party. Everyone's on the same level. Asking Jordan for an intro is an unnecessary crutch, and it depends on him being free."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-think-D",
                        prefix: "D",
                        label: "Walk up, make a comment about something in the room to create a natural opener",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "\"Nice playlist\" or \"cool couch\" has nothing to do with what they're talking about. You're starting a new thread nobody asked for instead of joining the one that's working."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-3-speak",
                label: "SPEAK",
                question: "The group just finished laughing at a story about their flight to Texas being delayed. Pick the best entry.",
                options: [
                    LessonOption(
                        id: "lesson-3-speak-A",
                        prefix: "A",
                        label: "\"Hey, I'm [name], what's everyone laughing about?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Now they have to stop and recap the whole thing for you. You just killed the energy."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-speak-B",
                        prefix: "B",
                        label: "\"Sorry to interrupt, do you guys know Jordan?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "You've announced yourself as an outsider and apologized for showing up. Wrong energy."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-speak-C",
                        prefix: "C",
                        label: "\"Okay that story, I had the exact same thing happen in Denver, it was brutal\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "You just redirected the conversation to yourself. The guy who was telling the story feels dismissed."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-speak-D",
                        prefix: "D",
                        label: "\"You must've been pissed, what airline was it?\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "\"You must've been pissed\" shows you were listening. People love that. One short question that extends their story, not yours. You're in the conversation naturally. Share your own story after they've accepted your presence."
                        )
                    )
                ],
                correctIndex: 3
            )
        ]
    )
}
// swiftlint:enable line_length
