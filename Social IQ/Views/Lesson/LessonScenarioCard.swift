//
//  LessonScenarioCard.swift
//  Social IQ

import SwiftUI

struct LessonScenarioCard: View {
    let scenarioText: String
    let isReadStep: Bool

    private static let credibilityText = "Answers grounded in peer-reviewed research from UCLA, University of Washington, and FBI negotiation training."

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if !isReadStep {
                Text("Scenario")
                    .font(.caption)
                    .fontWeight(.semibold)
                    .foregroundStyle(.gray)
            }
            Text(scenarioText.sentenceFormatted)
                .font(isReadStep ? .body : .caption)
                .italic()
                .foregroundStyle(.white.opacity(isReadStep ? 0.9 : 0.7))
                .lineSpacing(6)
                .lineLimit(isReadStep ? nil : 3)

            if isReadStep {
                Text(Self.credibilityText)
                    .font(.caption2)
                    .foregroundStyle(.white.opacity(0.4))
                    .lineSpacing(3)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .cardBackground()
    }
}
