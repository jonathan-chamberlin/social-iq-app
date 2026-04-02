//
//  LessonData.swift
//  Social IQ
//

import Foundation

// swiftlint:disable line_length
enum LessonData {
    static var allLessons: [Lesson] { [lesson1, lesson2, lesson3, lesson4, lesson5] }

    static let lesson1 = Lesson(
        id: "lesson-1",
        title: "Critical Feedback in Front of the Team",
        category: "workplace",
        difficulty: "intermediate",
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
                            text: "Totally see why you'd read it that way, but if she'd actually lost her cool you'd see it: raised voice, cutting you off harder. She was calm and specific. Read it as emotional and you'll respond emotionally. Bad move."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-read-B",
                        prefix: "B",
                        label: "She's trying to demonstrate authority in front of the group",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Here's the thing: managers who just want to correct you do it in private. She did it on the call because there's a performance element. She's showing the team she holds people to standards. Once you see that, the right response becomes obvious."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-read-C",
                        prefix: "C",
                        label: "She's trying to embarrass you to establish dominance over the team",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Makes sense on the surface, but \"embarrass you\" assumes she's out to get you. She's managing how the team sees her, not targeting you. If you read this as an attack, you'll get defensive or shut down, and both of those lose."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-read-D",
                        prefix: "D",
                        label: "She's testing whether you can handle criticism professionally",
                        feedback: OptionFeedback(
                            isCorrect: false,
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
                            text: "I get the instinct, but explaining yourself right now looks defensive to everyone watching. The team hears \"he's arguing with Sandra.\" Now a 10-second correction becomes a full debate."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-think-B",
                        prefix: "B",
                        label: "Apologize profusely to show accountability",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Big apology in front of 15 people makes this way bigger than it needs to be. Sandra flagged a problem. She didn't ask you to grovel. Over-apologizing makes you look shook."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-think-C",
                        prefix: "C",
                        label: "Agree to validate and disarm her, then follow up during your one on one",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Everyone's watching how you handle pressure. Agree, move on, look like you can take a hit without drama. Sandra feels her authority is intact (even if you disagree). Then you have the real conversation in your 1-on-1 where you can actually push back."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-think-D",
                        prefix: "D",
                        label: "Push back gently to show you're not a pushover",
                        feedback: OptionFeedback(
                            isCorrect: false,
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
                            text: "\"I thought I made the changes\" is a subtle defense. Sandra and everyone else hears you questioning her. Now a quick correction becomes a back-and-forth."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-speak-B",
                        prefix: "B",
                        label: "\"I'm so sorry, Sandra, I should have caught this before the meeting.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Way too much apology. The team's watching. Over-apologizing tells them you can't take a hit without crumbling."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-speak-C",
                        prefix: "C",
                        label: "\"Can you clarify exactly what's not working? I want to make sure I understand.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Asking for details right now drags out the awkward moment for everyone. Save that for when you follow up privately."
                        )
                    ),
                    LessonOption(
                        id: "lesson-1-speak-D",
                        prefix: "D",
                        label: "\"You're right. I'll fix it and send an updated version by end of day.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Clean. You agreed, committed to a fix, gave a deadline. Meeting moves on. You look composed, Sandra feels respected (even if you don't actually agree). Handle the details later in private."
                        )
                    )
                ],
                correctIndex: 3
            )
        ]
    )

    static let lesson2 = Lesson(
        id: "lesson-2",
        title: "First Date Conversation Dies",
        category: "dating",
        difficulty: "intermediate",
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
    static let lesson3 = Lesson(
        id: "lesson-3",
        title: "Entering a Group at a Party",
        category: "friendships",
        difficulty: "intermediate",
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
    static let lesson4 = Lesson(
        id: "lesson-4",
        title: "Parent Criticizing Your Career Choice",
        category: "family",
        difficulty: "beginner",
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
                            text: "Easy to take her words at face value, but look at her body language: tight voice, stirring pasta nervously. She's not critiquing your plan. She's scared. If you respond with logic, you'll miss what she actually needs."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-read-B",
                        prefix: "B",
                        label: "She's scared about your financial security and expressing it as criticism",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "The word \"stable\" is the giveaway. She's not saying freelance is bad. She's saying the lack of security terrifies her. That tight voice and the pasta stirring? That's anxiety. She's scared for you and this is the only way she knows how to say it."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-read-C",
                        prefix: "C",
                        label: "She's worried what other family members will think",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Nothing she's doing points to caring about what other people think. She's not mentioning relatives or friends. The tight voice and \"stability\" tell you this is her own fear, not a reputation thing."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-read-D",
                        prefix: "D",
                        label: "She doesn't trust your judgment based on past decisions",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "She's not bringing up past mistakes or saying \"you always do this.\" She's worried about the future. If you hear this as a trust issue, you'll get defensive about your track record instead of addressing what's actually going on."
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
                            text: "Spreadsheets don't work on someone who's scared. She won't absorb any numbers until she feels like you've actually heard her. Lead with the emotion first, then the plan has a shot."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-think-B",
                        prefix: "B",
                        label: "Label her fear, tell her you appreciate her concern, and that everything will be okay",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "Name what she's feeling: \"it sounds like you're worried I won't be able to support myself.\" Once she feels heard, her guard drops. Then you can reassure her things will be okay."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-think-C",
                        prefix: "C",
                        label: "Label the fear underneath the criticism before explaining that it's your life",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "\"It's my life\" sounds respectful but it's actually a wall. She hears \"stop talking about this.\" She'll feel dismissed and bring it up again next dinner because nothing got resolved."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-think-D",
                        prefix: "D",
                        label: "Change the subject and revisit this when she's had time to process",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "She's going to bring it up again. Guaranteed. Every time you dodge this conversation, she has more time to worry and the next one gets harder."
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
                            text: "She'll say \"okay\" and feel the exact same dread. You answered the question she asked, not the one she meant."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-speak-B",
                        prefix: "B",
                        label: "\"I know it's scary. It sounds like you're worried I won't be able to take care of myself.\"",
                        feedback: OptionFeedback(
                            isCorrect: true,
                            text: "\"Scary\" validates what she's feeling. The paraphrase gives her a chance to say \"yes, exactly.\" Now she feels like you're actually listening, not just waiting to defend yourself."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-speak-C",
                        prefix: "C",
                        label: "\"I hear you but this is what I want to do. I need you to support me.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "You just asked her to shut down her fear so you can feel supported. That's a bad trade. She needs something from you right now, not the other way around."
                        )
                    ),
                    LessonOption(
                        id: "lesson-4-speak-D",
                        prefix: "D",
                        label: "\"Can we talk about this later? I just want to have a nice dinner.\"",
                        feedback: OptionFeedback(
                            isCorrect: false,
                            text: "Next dinner, same conversation, more buildup. Dodging it doesn't make it go away."
                        )
                    )
                ],
                correctIndex: 1
            )
        ]
    )

    static let lesson5 = Lesson(
        id: "lesson-5",
        title: "Sibling Asking for Money Again",
        category: "family",
        difficulty: "intermediate",
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
