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
                            renText: "Makes sense, laughing loud can feel like a wall. But open groups leak energy outward. This one's doing exactly that.",
                            text: "They're laughing and being loud. That's not \"closed off.\" Closed-off groups face inward, give short answers, avoid eye contact. This group has open energy. You just need to time your approach right."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-read-B",
                        prefix: "B",
                        label: "They're mid-story, and the group has a clear center of mass",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "Yes. Center of mass. Social dynamics research shows every group has a speaker hierarchy. You saw where the gravity was.",
                            text: "Cool shirt guy is clearly running the show right now. The group has a rhythm. Walk up mid-punchline and you kill the moment. Wait for the natural pause after the laugh."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-read-C",
                        prefix: "C",
                        label: "They're bored and would welcome anyone who walks up with confidence",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Confidence is good, but boredom rescue is a story you're telling yourself. They're already having fun.",
                            text: "They're clearly entertained already. Walking up assuming they need you is the wrong frame. That's how you come across as the guy who interrupts instead of integrates."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-read-D",
                        prefix: "D",
                        label: "They're testing whether strangers can break in without an introduction",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "They're not testing you. That's anxiety narrating. No one's keeping score.",
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
                            renText: "Sounds right on paper. But walking into the center mid-story is just... Interrupting with extra steps.",
                            text: "Sounds like solid advice, but in practice you're interrupting someone's story to announce yourself. People will think \"this guy thinks he's the center of the world.\""
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-think-B",
                        prefix: "B",
                        label: "Walk up to the edge of the group, listen and make eye contact with whoever is talking for 10-15 seconds, then build on something someone just said",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "Edge, listen, build. Carl Rogers' active listening research shows people accept you faster when they feel heard first. Most people skip straight to talking.",
                            text: "Listen for 10-15 seconds, then build on what they're already talking about. Now you look like someone who was paying attention, not someone barging in. People love feeling like others are interested in them. Most people miss this."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-think-C",
                        prefix: "C",
                        label: "Ask Jordan to introduce you so you have social proof going in",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Totally get it, social proof feels safer. But you don't need backup here. It's a house party, not a gala.",
                            text: "At a high-status event, sure. But this is a house party. Everyone's on the same level. Asking Jordan for an intro is an unnecessary crutch, and it depends on him being free."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-think-D",
                        prefix: "D",
                        label: "Walk up, make a comment about something in the room to create a natural opener",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Solid instinct for cold openers, but they already have a thread going. You'd be talking past them, not with them.",
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
                            renText: "Introducing yourself first feels polite, but you just made them pause the fun to explain it to a stranger.",
                            text: "You just killed the energy. Now you're the guy who made everyone rewind."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-speak-B",
                        prefix: "B",
                        label: "\"Sorry to interrupt, do you guys know Jordan?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Apologizing for showing up sets the whole tone wrong. You've already shrunk before saying anything real.",
                            text: "You've announced yourself as an outsider and apologized for showing up. Wrong energy."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-speak-C",
                        prefix: "C",
                        label: "\"Okay that story, I had the exact same thing happen in Denver, it was brutal\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "Sharing your own story feels natural, but you just pulled focus. Their moment, not yours yet.",
                            text: "The guy who was telling the story feels dismissed. Wait until they've accepted your presence before sharing your own."
                        )
                    ),
                    LessonOption(
                        id: "lesson-3-speak-D",
                        prefix: "D",
                        label: "\"You must've been pissed, what airline was it?\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "That's it. Voss calls this labeling. You named what they felt, then handed it back with a question. Clean entry.",
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
