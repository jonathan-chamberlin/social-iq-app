//
//  Lesson6Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson6 = Lesson(
        id: "lesson-6",
        title: "Guy You Like Teases You Mid-Flirt",
        category: .dating,
        difficulty: .intermediate,
        scenarioText: "You're at the climbing gym with Leo. You've been flirting with him for weeks at the bouldering wall and this is the first time you're there together on a weekend. In the last hour he's bumped into you at least six times, and mentioned he saw your Instagram story this morning. You ask him to film you doing a climb. He laughs. 'Aw, look at you being a little influencer.'",
        steps: [
            LessonStep(
                id: "lesson-6-read",
                label: "READ",
                question: "What's actually going on with that tease?",
                options: [
                    LessonOption(
                        id: "lesson-6-read-A",
                        prefix: "A",
                        label: "He's making fun of you for being cringey. Time to play it cool and pull back",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Makes sense if you only heard the words. But he hasn't left your side all hour.",
                            text: "Pulling back now reads like you misread the whole day. You'd go cold right as he was warming up. He'd drive home wondering what he did wrong."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-read-B",
                        prefix: "B",
                        label: "He thinks posting climbing content is embarrassing and is giving you honest feedback",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Fair instinct, but a tease with a laugh isn't honest feedback.",
                            text: "Real criticism doesn't come with a smile and six shoulder-brushes. If he thought you were cringe, he wouldn't keep \"accidentally\" bumping into you or bringing up your story."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-read-C",
                        prefix: "C",
                        label: "The tease plus everything else this hour, that's him flirting without saying it out loud",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            researcher: "Moore - Webster University",
                            renText: "Clean read. Moore's research found that teasing with a laugh is one of the clearest ways people flirt when they want to keep it playful.",
                            text: "Six bumps, the IG mention, those are the data. The tease is too. He's just flirting."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-read-D",
                        prefix: "D",
                        label: "He's just joking around. It doesn't really mean anything either way",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Safe read. But safe reads cost you the moment.",
                            text: "Treating clear interest as ambiguous lets the vibe default to friends. Now he has to work twice as hard to flirt, and most guys won't."
                        )
                    )
                ],
                correctIndex: 2
            ),
            LessonStep(
                id: "lesson-6-think",
                label: "THINK",
                question: "What's the move when he teases you like that?",
                options: [
                    LessonOption(
                        id: "lesson-6-think-A",
                        prefix: "A",
                        label: "Deny it. Tell him you're not trying to be an influencer, you just wanted the video for yourself",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Bad move. Denying a playful frame reads insecure, not modest.",
                            text: "He handed you a fun label. Turning it down tells him the teasing is closed. The vibe goes formal and you both feel it. The flirt cools a full degree."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-think-B",
                        prefix: "B",
                        label: "Explain the video is for your climbing coach to give tips on your form",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Explaining kills flirting every time.",
                            text: "\"It's for my coach\" turns a playful moment into a report card. He wasn't asking why. He was testing if you could play. Justifying the video tells him no."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-think-C",
                        prefix: "C",
                        label: "Agree with him and exaggerate it",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            researcher: "Sartain - MOA Mentoring",
                            renText: "Yes. Dating coach Michael Sartain teaches this exact move, agree and exaggerate. He handed you a bit. Deny it and the game dies. Add to it and you're both still playing.",
                            text: "The frame he offered is you're a little vain in a cute way. Agreeing and pushing it further shows him you can play. That's way more attractive than defending yourself."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-think-D",
                        prefix: "D",
                        label: "Laugh it off and change the subject to something else",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Close, but you just walked away from the best moment of the day.",
                            text: "He handed you a bit. Dropping it means you missed it or you got nervous. Either way he notices and will be more nonchalant going forward."
                        )
                    )
                ],
                correctIndex: 2
            ),
            LessonStep(
                id: "lesson-6-speak",
                label: "SPEAK",
                question: "Pick the best response to his tease.",
                options: [
                    LessonOption(
                        id: "lesson-6-speak-A",
                        prefix: "A",
                        label: "\"Haha I'm not trying to be an influencer, I just wanted the clip.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Soft landing, but he just watched you back out of the moment.",
                            text: "Denying shrinks you. That was an opportunity to flirt but you rejected it. Not hurt, just recalibrating. The window narrows."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-speak-B",
                        prefix: "B",
                        label: "\"Yeah, and this little influencer needs a cameraman.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            researcher: "Johnstone - Status Transactions",
                            renText: "THAT. You played along and gave him a role in the bit. Now he's your camera boy.",
                            text: "Three things at once. You can play. The tease is now a two-person game. And you quietly set the frame that he's coming next time. Twelve words, three moves."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-speak-C",
                        prefix: "C",
                        label: "\"It's for form feedback actually, I send these to my coach.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "Even though this could be true, it hurts you socially.",
                            text: "You took a playful tease and turned it into a lecture about your coach. Guys don't flirt with someone who answers jokes with explanations."
                        )
                    ),
                    LessonOption(
                        id: "lesson-6-speak-D",
                        prefix: "D",
                        label: "\"I know right, I'm sorry, I'll stop posting I promise.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            researcher: nil,
                            renText: "You had the right idea, but self-deprecation right now is too much.",
                            text: "You agreed but overshot. Now you're teasing yourself for him. It reads as insecurity dressed up as humor. The move is to exaggerate."
                        )
                    )
                ],
                correctIndex: 1
            )
        ]
    )
}
// swiftlint:enable line_length
