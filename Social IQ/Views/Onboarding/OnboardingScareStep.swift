//
//  OnboardingScareStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingScareStep: View {
    let quiz1Answer: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Here's what happens without training")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.red)
                .padding(.top, 20)

            VStack(alignment: .leading, spacing: 16) {
                let bullets = Self.bulletsByAnswer[quiz1Answer] ?? Self.bulletsDefault
                ForEach(bullets, id: \.self) { text in
                    bulletRow(text)
                }
            }
        }
    }

    private func bulletRow(_ text: String) -> some View {
        HStack(alignment: .top, spacing: 12) {
            Text("⚠️")
                .font(.title3)
            Text(text)
                .font(.body)
                .foregroundStyle(.white.opacity(0.9))
        }
        .padding(16)
        .frame(maxWidth: .infinity, alignment: .leading)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.red.opacity(0.1))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.red.opacity(Theme.Opacity.disabled), lineWidth: 1)
        )
    }

    // MARK: - Scare Bullet Data

    private static let bulletsByAnswer: [Int: [String]] = [
        0: [
            "Conversations die and you sit in painful silence",
            "People stop reaching out because the energy always fades",
            "You leave every interaction wishing you'd said more",
            "The people you want to know drift away without understanding why",
        ],
        1: [
            "People form their opinion of you in the first 7 seconds",
            "You get one shot at a first meeting — and right now you're winging it",
            "Forgettable introductions mean missed jobs, dates, and friendships",
            "The version of you people remember isn't the real you",
        ],
        2: [
            "You miss the signals that tell you when to speak and when to listen",
            "You say the wrong thing at the wrong time and only realize later",
            "People think you don't care — but you just didn't notice",
            "Social cues everyone else seems to get feel invisible to you",
        ],
        3: [
            "Your ideas die in your head because the moment passes",
            "The loud people get the credit while you stay invisible",
            "You rehearse what to say, but by the time you're ready, the topic changed",
            "People assume you have nothing to add — but you have everything to add",
        ],
        4: [
            "A good night gets ruined by 3am self-doubt",
            "You replay every word you said, searching for what went wrong",
            "One awkward moment loops in your head for days",
            "You cancel plans to avoid the post-social spiral",
        ],
        5: [
            "You see someone you want to meet and walk right past them",
            "The moment passes and you spend the rest of the night thinking \"what if\"",
            "Your friend group stays the same size while opportunities walk by",
            "The people you most want to know never find out you exist",
        ],
    ]

    private static let bulletsDefault: [String] = [
        "Awkward silences kill your confidence. And people notice.",
        "Opportunities pass because you can't connect",
        "You overthink every interaction, then replay it for hours",
        "The gap between your potential and your presence keeps growing",
    ]
}
