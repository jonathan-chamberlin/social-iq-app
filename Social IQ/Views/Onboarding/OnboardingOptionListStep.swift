//
//  OnboardingOptionListStep.swift
//  Social IQ
//
//  Reusable step for single-select option lists that auto-advance on tap.
//  Used by: Social Context, Discovery Source.
//

import SwiftUI

struct OnboardingOptionListStep: View {
    let title: String
    let options: [String]
    let onSelect: (String) -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text(title)
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(spacing: 12) {
                ForEach(options, id: \.self) { option in
                    Button {
                        onSelect(option)
                    } label: {
                        HStack {
                            Text(option)
                                .font(.body)
                                .foregroundStyle(.white)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        .padding(16)
                        .background(
                            RoundedRectangle(cornerRadius: 12)
                                .fill(Color.white.opacity(0.08))
                        )
                    }
                }
            }
        }
    }
}
