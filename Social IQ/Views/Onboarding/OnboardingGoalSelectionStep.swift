//
//  OnboardingGoalSelectionStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingGoalSelectionStep: View {
    @Binding var selectedGoals: Set<String>

    private static let maxGoals = 3

    private let goalOptions = [
        "Be more charismatic",
        "Read people instantly",
        "Handle conflict confidently",
        "Make lasting impressions",
        "Lead any conversation",
        "Eliminate social anxiety",
        "Stop overthinking social situations",
        "Approach people I'm interested in",
        "Be comfortable outside my friend group",
        "Be someone people want to know",
        "Be the center of attention",
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("What do you want to master?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            Text("Pick up to \(Self.maxGoals)")
                .font(.subheadline)
                .foregroundStyle(.white.opacity(Theme.Opacity.secondary))

            WrappingHStack(items: goalOptions, spacing: 10, lineSpacing: 10) { goal in
                let isSelected = selectedGoals.contains(goal)
                Button {
                    if isSelected {
                        selectedGoals.remove(goal)
                    } else if selectedGoals.count < Self.maxGoals {
                        selectedGoals.insert(goal)
                    }
                } label: {
                    Text(goal)
                        .font(.subheadline)
                        .fontWeight(.medium)
                        .foregroundStyle(isSelected ? .black : .white)
                        .padding(.horizontal, 16)
                        .padding(.vertical, 10)
                        .background(
                            Capsule()
                                .fill(isSelected ? Color.white : Color.white.opacity(0.08))
                        )
                }
            }
            .padding(.top, 8)
        }
    }
}
