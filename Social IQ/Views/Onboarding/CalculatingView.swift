//
//  CalculatingView.swift
//  Social IQ
//

import SwiftUI

struct CalculatingView: View {
    let onFinish: () -> Void

    @State private var phase = 0

    private let messages = [
        "Analyzing your social patterns...",
        "Mapping skill gaps...",
        "Customizing your lessons...",
    ]

    var body: some View {
        VStack(spacing: 32) {
            Spacer()
                .frame(height: 60)

            ProgressView()
                .controlSize(.large)
                .tint(.white)

            VStack(alignment: .leading, spacing: 12) {
                ForEach(0...phase, id: \.self) { i in
                    if i < messages.count {
                        HStack(spacing: 8) {
                            Image(systemName: i < phase ? "checkmark.circle.fill" : "circle.dotted")
                                .foregroundStyle(i < phase ? .green : .white.opacity(0.5))
                            Text(messages[i])
                                .font(.subheadline)
                                .foregroundStyle(.white.opacity(0.7))
                        }
                        .transition(.opacity.combined(with: .move(edge: .bottom)))
                    }
                }
            }

            Spacer()
        }
        .animation(.easeInOut(duration: 0.4), value: phase)
        .task {
            try? await Task.sleep(for: .milliseconds(800))
            phase = 1
            try? await Task.sleep(for: .milliseconds(800))
            phase = 2
            try? await Task.sleep(for: .milliseconds(1400))
            onFinish()
        }
    }
}
