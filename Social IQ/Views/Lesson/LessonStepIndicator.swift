//
//  LessonStepIndicator.swift
//  Social IQ

import SwiftUI

struct LessonStepIndicator: View {
    let currentLabel: String

    private static let stepLabels = ["READ", "THINK", "SPEAK"]

    var body: some View {
        let currentIndex = Self.stepLabels.firstIndex(of: currentLabel) ?? 0

        HStack(spacing: 0) {
            ForEach(Array(Self.stepLabels.enumerated()), id: \.offset) { index, label in
                let isCompleted = index < currentIndex
                let isCurrent = index == currentIndex

                VStack(spacing: 4) {
                    Circle()
                        .fill(isCompleted || isCurrent ? Theme.gold : Color.gray.opacity(0.4))
                        .frame(width: 10, height: 10)
                        .overlay {
                            if isCompleted {
                                Image(systemName: "checkmark")
                                    .font(.system(size: 6, weight: .bold))
                                    .foregroundStyle(.white)
                            }
                        }
                    Text(label)
                        .font(.caption2)
                        .fontWeight(isCurrent ? .semibold : .regular)
                        .foregroundStyle(isCurrent ? .white : .gray.opacity(0.6))
                }
                .frame(maxWidth: .infinity)

                if index < Self.stepLabels.count - 1 {
                    Rectangle()
                        .fill(isCompleted ? Theme.gold : Color.gray.opacity(0.3))
                        .frame(height: 2)
                        .offset(y: -8)
                }
            }
        }
        .padding(.horizontal, 40)
        .padding(.bottom, 4)
    }
}
