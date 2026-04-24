//
//  LessonCompletionScoreCard.swift
//  Social IQ

import SwiftUI

struct LessonCompletionScoreCard: View {
    let displayedScore: Int
    let totalSteps: Int
    let showScoreGlow: Bool

    var body: some View {
        Text("\(displayedScore) / \(totalSteps)")
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundStyle(Theme.gold)
            .shadow(
                color: showScoreGlow ? Theme.gold.opacity(Theme.Opacity.muted) : .clear,
                radius: showScoreGlow ? 16 : 0
            )

        Text("Grounded in social dynamics research")
            .font(.caption)
            .foregroundStyle(.white.opacity(Theme.Opacity.secondary))
            .padding(.top, 4)
    }
}
