//
//  Lesson7Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson7 = Lesson(
        id: "lesson-7",
        title: "He Tells You He's Into Raves",
        category: .dating,
        difficulty: .intermediate,
        scenarioText: "You're on a second date with Alex. It's been going well, he's funny, listens, asks real questions. Over a coffee date he mentions he's flying to Orlando in June for a week-long rave festival. You ask which one. 'Electric Daisy Carnival,' he says. 'EDC.' 'I go every year with the same crew. Rave culture is kind of my thing.' He takes a sip of water and waits for your reaction.",
        steps: [
            LessonStep(
                id: "lesson-7-read",
                label: "READ",
                question: "What is he actually telling you?",
                options: [
                    LessonOption(
                        id: "lesson-7-read-A",
                        prefix: "A",
                        label: "He's warning you he parties hard and probably does drugs. Red flag confirmed",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "That's your overbearing parent's voice. Not everyone is like that.",
                            text: "Matching 'raves' to 'drugs and red flags' is too broad of an assumption. Everyone is different. He said the same crew every year. That's community. You'd miss a good man by reading the label."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-read-B",
                        prefix: "B",
                        label: "He's just making small talk about summer travel plans",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Travel plans don't come with \"it's my thing.\"",
                            text: "He framed it as part of his identity. Miss the frame and you answer the wrong layer. He hears you ignore what he just offered, and he'll close off from you."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-read-C",
                        prefix: "C",
                        label: "He's showing you a deep part of himself. Your reaction decides whether he shows you more",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            researcher: "Altman - Social Penetration Theory",
                            renText: "You saw it. Altman's research says people open up in layers, and each reaction decides whether they go deeper. He's checking if you're safe to know.",
                            text: "When a guy tells you something early that could get him judged, he's filtering, not confessing. The good ones show you the real stuff up front. He's looking for someone who accepts this part of him."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-read-D",
                        prefix: "D",
                        label: "He's bragging about his travel plans to impress you",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Makes sense, some guys do brag. But this doesn't fit the pattern.",
                            text: "Bragging sounds like \"I went to the sickest festival last year, you wouldn't believe the lineup.\" He said \"rave culture is kind of my thing\" and waited. That's not a flex, that's a disclosure."
                        )
                    )
                ],
                correctIndex: 2
            ),
            LessonStep(
                id: "lesson-7-think",
                label: "THINK",
                question: "What's the move?",
                options: [
                    LessonOption(
                        id: "lesson-7-think-A",
                        prefix: "A",
                        label: "Ask him how he stays safe at raves with all the drugs around",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Fair question, but he will read this as judgemental.",
                            text: "Leading with \"how do you stay safe with the drugs\" tells him you already decided what raves are. He'll answer politely and never bring it up again. You just failed his filter."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-think-B",
                        prefix: "B",
                        label: "Get curious about what he actually loves about it, without signaling approval or disapproval",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            researcher: "Gottman - UW",
                            renText: "Yes. Gottman calls this turning toward. When someone shares something that matters to them, leaning in is what builds connection.",
                            text: "Curiosity without judgement is the most attractive response to someone's identity. You don't have to love raves. You just have to love that he loves something, and want to see why."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-think-C",
                        prefix: "C",
                        label: "Pretend you've been to raves too so he feels understood",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Makes sense you want to connect, but if he asks you any follow-up questions about your rave experiences he'll figure out you were making it up.",
                            text: "Faking shared interest buys five minutes of rapport and a lifetime of maintenance. When he asks which festivals, you're stuck performing. When he finds out, it reads worse than being a non-raver who was curious."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-think-D",
                        prefix: "D",
                        label: "Nod, say \"that's cool,\" and move to the next topic",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Safe. Huge missed opportunity. He'll feel like you dismissed something important to him.",
                            text: "\"That's cool\" plus a subject change makes him feel like you don't care. He'll assume you're bored or judging, and retreat to small talk. Coffee date finishes fine, but it will be harder for him to open up."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-7-speak",
                label: "SPEAK",
                question: "Pick the best response.",
                options: [
                    LessonOption(
                        id: "lesson-7-speak-A",
                        prefix: "A",
                        label: "\"Oh wow, how do you stay safe at those? I've heard they can get crazy.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Even if you're curious, this can come across as too judgemental.",
                            text: "Safety questions frame the scene as dangerous before he's described it. He hears the judgement inside the question. Now he's defending the scene, not sharing it. You're the reason."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-speak-B",
                        prefix: "B",
                        label: "\"Oh nice, I love raves too. Where's your favorite one?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "If you aren't actually into raves, you just signed up to play a character for the rest of the relationship.",
                            text: "It's okay to show curiosity about something you aren't too familiar with."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-speak-C",
                        prefix: "C",
                        label: "\"Oh cool, what is it about that scene that makes you go back every year?\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            researcher: "Voss - FBI Negotiation",
                            renText: "Perfect. You gave him the opportunity to open up about something important to him. People love talking about their interests.",
                            text: "Notice what you didn't do. You didn't approve or judge. You gave him the floor. Now he's telling you about his crew, the feeling on the floor, why Orlando hits different. You're seeing the man, not the label."
                        )
                    ),
                    LessonOption(
                        id: "lesson-7-speak-D",
                        prefix: "D",
                        label: "\"That's cool. So what else are you up to this summer?\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Polite. Also a closed door.",
                            text: "Changing the subject tells him this one wasn't welcome. He'll comply, coffee will feel fine, and on the drive home he'll downgrade you from \"she gets me\" to \"she's nice.\""
                        )
                    )
                ],
                correctIndex: 2
            )
        ]
    )
}
// swiftlint:enable line_length
