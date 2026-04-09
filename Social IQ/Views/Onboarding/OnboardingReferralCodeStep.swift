//
//  OnboardingReferralCodeStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingReferralCodeStep: View {
    @Binding var referralCode: String
    let onSkip: () -> Void

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Got a referral code?")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            TextField(
                "", text: $referralCode,
                prompt: Text("Enter code").foregroundStyle(.white.opacity(Theme.Opacity.disabled))
            )
            .textFieldStyle(.plain)
            .font(.title3)
            .foregroundStyle(.white)
            .padding(16)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .fill(Color.white.opacity(0.08))
            )
            .autocorrectionDisabled()
            .textInputAutocapitalization(.characters)

            Button(action: onSkip) {
                Text("Skip")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(Theme.Opacity.secondary))
                    .frame(maxWidth: .infinity)
            }
        }
    }
}
