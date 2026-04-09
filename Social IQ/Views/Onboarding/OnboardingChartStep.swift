//
//  OnboardingChartStep.swift
//  Social IQ
//

import SwiftUI

struct OnboardingChartStep: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Your Social Confidence Over Time")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(.white)
                .padding(.top, 20)

            confidenceChart
                .frame(height: 200)
                .padding(.top, 8)

            HStack {
                legendDot(color: .green, label: "With Social IQ")
                Spacer()
                legendDot(color: .gray, label: "Without training")
            }
        }
    }

    private var confidenceChart: some View {
        GeometryReader { geo in
            let w = geo.size.width
            let h = geo.size.height
            let labelHeight: CGFloat = 20
            let chartH = h - labelHeight

            ZStack(alignment: .bottomLeading) {
                ForEach(0..<4, id: \.self) { i in
                    let y = chartH * CGFloat(i) / 3
                    Path { path in
                        path.move(to: CGPoint(x: 0, y: y))
                        path.addLine(to: CGPoint(x: w, y: y))
                    }
                    .stroke(Color.white.opacity(0.06), lineWidth: 1)
                }

                Path { path in
                    path.move(to: CGPoint(x: 0, y: chartH * 0.75))
                    path.addLine(to: CGPoint(x: w, y: chartH * 0.7))
                }
                .stroke(Color.gray.opacity(Theme.Opacity.secondary), lineWidth: 2)

                Path { path in
                    path.move(to: CGPoint(x: 0, y: chartH * 0.75))
                    path.addCurve(
                        to: CGPoint(x: w, y: chartH * 0.1),
                        control1: CGPoint(x: w * 0.35, y: chartH * 0.65),
                        control2: CGPoint(x: w * 0.65, y: chartH * 0.2)
                    )
                }
                .stroke(Color.green, lineWidth: 6)

                HStack {
                    Text("Week 1")
                    Spacer()
                    Text("Week 4")
                    Spacer()
                    Text("Week 8")
                }
                .padding(.horizontal, 16)
                .font(.caption2)
                .foregroundStyle(.white.opacity(Theme.Opacity.secondary))
                .offset(y: labelHeight / 2)
                .frame(width: w, height: labelHeight, alignment: .bottom)
                .offset(y: labelHeight)
            }
        }
    }

    private func legendDot(color: Color, label: String) -> some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 8, height: 8)
            Text(label)
                .font(.caption)
                .foregroundStyle(.white.opacity(Theme.Opacity.subtle))
        }
    }
}
