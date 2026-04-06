//
//  Lesson4Data.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
extension LessonData {
    static let lesson4 = Lesson(
        id: "lesson-4",
        title: "Parent Criticizing Your Career Choice",
        category: .family,
        difficulty: .beginner,
        scenarioText: "You told your mom last week that you're leaving your stable job to go freelance. Tonight at dinner she brings it up again: \"I just don't understand why you'd leave a good salary. You had benefits, you had stability. What happens if this doesn't work out?\" Her voice is tight. She's stirring her pasta more than necessary.",
        steps: [
            LessonStep(
                id: "lesson-4-read",
                label: "READ",
                question: "What's driving your mom's reaction?",
                options: [
                    LessonOption(
                        id: "lesson-4-read-A",
                        prefix: "A",
                        label: "She thinks you're making a bad decision and wants you to reconsider",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "her words sound like criticism, sure. but her body is doing something else entirely.",
                            text: "Easy to take her words at face value, but look at her body language: tight voice, stirring pasta nervously. She's not critiquing your plan. She's scared. If you respond with logic, you'll miss what she actually needs."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-read-B",
                        prefix: "B",
                        label: "She's scared about your financial security and expressing it as criticism",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "you caught the fear under the words. that's the whole game.",
                            text: "The word \"stable\" is the giveaway. She's not saying freelance is bad. She's saying the lack of security terrifies her. That tight voice and the pasta stirring? That's anxiety. She's scared for you and this is the only way she knows how to say it."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-read-C",
                        prefix: "C",
                        label: "She's worried what other family members will think",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "makes sense if you know families that run on appearances. but she never mentioned anyone else.",
                            text: "Nothing she's doing points to caring about what other people think. She's not mentioning relatives or friends. The tight voice and \"stability\" tell you this is her own fear, not a reputation thing."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-read-D",
                        prefix: "D",
                        label: "She doesn't trust your judgment based on past decisions",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "if she'd said \"you always do this\" you'd be right. she didn't. she's looking forward, not back.",
                            text: "If you hear this as a trust issue, you'll get defensive about your track record instead of addressing what's actually going on."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-4-think",
                label: "THINK",
                question: "What's the move that actually moves the conversation forward?",
                options: [
                    LessonOption(
                        id: "lesson-4-think-A",
                        prefix: "A",
                        label: "Walk her through your financial plan with specific numbers to ease her concern",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "the plan is real and it matters. but she can't hear it yet. feelings have to move first.",
                            text: "Spreadsheets don't work on someone who's scared. She won't absorb any numbers until she feels like you've actually heard her. Lead with the emotion first, then the plan has a shot."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-think-B",
                        prefix: "B",
                        label: "Label her fear, tell her you appreciate her concern, and that everything will be okay",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "name it first, then reassure. that order is everything.",
                            text: "Name what she's feeling: \"it sounds like you're worried I won't be able to support myself.\" Once she feels heard, her guard drops. Then you can reassure her things will be okay."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-think-C",
                        prefix: "C",
                        label: "Label the fear underneath the criticism before explaining that it's your life",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "solid start, but \"it's my life\" undoes it. you opened the door and then closed it in her face.",
                            text: "\"It's my life\" sounds respectful but it's actually a wall. She hears \"stop talking about this.\" She'll feel dismissed and bring it up again next dinner because nothing got resolved."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-think-D",
                        prefix: "D",
                        label: "Change the subject and revisit this when she's had time to process",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "avoidance feels peaceful in the moment. it just moves the tension to next time.",
                            text: "Every time you dodge this conversation, she has more time to worry and the next one gets harder."
                        )
                    )
                ],
                correctIndex: 1
            ),
            LessonStep(
                id: "lesson-4-speak",
                label: "SPEAK",
                question: "She just asked \"what happens if this doesn't work out?\" for the second time. Pick the best response.",
                options: [
                    LessonOption(
                        id: "lesson-4-speak-A",
                        prefix: "A",
                        label: "\"Mom, I've run the numbers. I have three months runway and two clients already lined up.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "the numbers are real. but she asked about feelings and you handed her a spreadsheet.",
                            text: "She'll say \"okay\" and feel the exact same dread. You answered the question she asked, not the one she meant."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-speak-B",
                        prefix: "B",
                        label: "\"I know it's scary. It sounds like you're worried I won't be able to take care of myself.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            renText: "THAT. you named the fear out loud and gave her room to confirm it. that's the whole unlock.",
                            text: "Now she feels like you're actually listening, not just waiting to defend yourself."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-speak-C",
                        prefix: "C",
                        label: "\"I hear you but this is what I want to do. I need you to support me.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "totally get it, you want her in your corner. but flipping to your needs before hers lands as dismissal.",
                            text: "You just asked her to shut down her fear so you can feel supported. That's a bad trade. She needs something from you right now, not the other way around."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-speak-D",
                        prefix: "D",
                        label: "\"Can we talk about this later? I just want to have a nice dinner.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            renText: "you want peace at the table. she'll bring it back up before dessert.",
                            text: "Next dinner, same conversation, more buildup. Dodging it doesn't make it go away."
                        )
                    )
                ],
                correctIndex: 1
            )
        ]
    )
}
// swiftlint:enable line_length
