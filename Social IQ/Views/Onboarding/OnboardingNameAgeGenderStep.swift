//
//  OnboardingNameAgeGenderStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingNameAgeGenderStep: View {
    @Binding var userName: String
    @Binding var userAge: Int
    @Binding var selectedGender: String

    private let genderOptions = ["Male", "Female", "Other", "Prefer not to say"]

    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Tell us about yourself")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            VStack(alignment: .leading, spacing: 8) {
                Text("First name")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                TextField(
                    "", text: $userName,
                    prompt: Text("Your first name").foregroundStyle(.white.opacity(0.3))
                )
                .textFieldStyle(.plain)
                .font(.title3)
                .foregroundStyle(.white)
                .padding(16)
                .cardBackground()
                .autocorrectionDisabled()
                .textInputAutocapitalization(.words)
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Gender")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                HStack(spacing: 10) {
                    ForEach(genderOptions, id: \.self) { option in
                        let isSelected = selectedGender == option
                        Button {
                            selectedGender = option
                        } label: {
                            Text(option)
                                .font(.subheadline)
                                .foregroundStyle(isSelected ? .black : .white)
                                .padding(.horizontal, 14)
                                .padding(.vertical, 10)
                                .background(
                                    Capsule()
                                        .fill(isSelected ? Color.white : Color.white.opacity(0.08))
                                )
                        }
                    }
                }
            }

            VStack(alignment: .leading, spacing: 8) {
                Text("Age: \(userAge)")
                    .font(.subheadline)
                    .foregroundStyle(.white.opacity(0.7))
                Picker("Age", selection: $userAge) {
                    ForEach(13...99, id: \.self) { age in
                        Text("\(age)").tag(age)
                    }
                }
                .pickerStyle(.wheel)
                .frame(height: 150)
                .clipped()
            }
        }
    }
}
