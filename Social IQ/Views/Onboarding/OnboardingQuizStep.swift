//
//  OnboardingQuizStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingQuizStep: View {
    let subStep: QuizSubStep
    let onSelectOption: (Int) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(subStep.question)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(spacing: 12) {
                ForEach(Array(subStep.options.enumerated()), id: \.offset) { index, option in
                    Button {
                        onSelectOption(index)
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(16)
                        .cardBackground()
                    }
                }
            }
        }
    }
}
