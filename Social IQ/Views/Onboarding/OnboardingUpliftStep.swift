//
//  OnboardingUpliftStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingUpliftStep: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("But you're already ahead")
                .font(.title)
                .fontWeight(.bold)
                .foregroundStyle(.green)
                .padding(.top, 20)

            Text(
                "Most people never realize social skills are trainable. You did. Social IQ uses the same deliberate practice frameworks that athletes and top performers use. Adapted for real social situations."
            )
            .font(.body)
            .foregroundStyle(.white.opacity(0.9))
            .lineSpacing(6)
            .padding(20)
            .background(
                RoundedRectangle(cornerRadius: 16)
                    .fill(Color.green.opacity(0.08))
            )
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(Color.green.opacity(Theme.Opacity.disabled), lineWidth: 1)
            )

            Image(systemName: "arrow.up.right")
                .font(.system(size: 60))
                .foregroundStyle(.green.opacity(Theme.Opacity.disabled))
                .frame(maxWidth: .infinity, alignment: .center)
                .padding(.top, 20)
        }
    }
}
