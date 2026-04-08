//
//  LessonCompletionScoreCard.swift
//  Social IQ

import SwiftUI

struct LessonCompletionScoreCard: View {
    let displayedScore: Int
    let totalSteps: Int
    let showScoreGlow: Bool
    let completionCount: Int
    let percentile: Int
    let percentileScale: CGFloat
    let percentileOpacity: Double

    var body: some View {
        Text("\(displayedScore) / \(totalSteps)")
            .font(.system(size: 48, weight: .bold, design: .rounded))
            .foregroundStyle(Theme.gold)
            .shadow(
                color: showScoreGlow ? Theme.gold.opacity(0.6) : .clear,
                radius: showScoreGlow ? 16 : 0
            )

        Text("correct on first try")
            .font(.subheadline)
            .foregroundStyle(.gray)

        VStack(spacing: 6) {
            Text("\(completionCount.formatted()) people completed this lesson")
                .font(.caption)
                .foregroundStyle(.white.opacity(0.5))

            Text("You finished faster than \(percentile)% of them")
                .font(.headline)
                .fontWeight(.semibold)
                .foregroundStyle(Theme.goldLight)
                .scaleEffect(percentileScale)
                .opacity(percentileOpacity)
        }
        .padding(.top, 4)
    }
}
