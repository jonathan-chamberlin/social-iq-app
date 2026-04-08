//
//  HomeToolbarContent.swift
//  Social IQ

import SwiftUI

struct HomeProBadge: View {
    @State private var glow = false

    var body: some View {
        Text("PRO")
            .font(.caption2)
            .fontWeight(.heavy)
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 3)
            .background(Capsule().fill(Theme.goldGradient))
            .shadow(color: glow ? Theme.gold.opacity(0.6) : .clear, radius: 8)
            .onAppear {
                withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                    glow = true
                }
            }
    }
}

struct HomeUpgradeButton: View {
    let onTap: () -> Void

    var body: some View {
        Button(action: onTap) {
            Label("Upgrade", systemImage: "star.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.goldGradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}
