//
//  Theme.swift
//  Social IQ
//

import SwiftUI

enum Theme {
    static let gold = Color(red: 0.85, green: 0.65, blue: 0.13)
    static let goldLight = Color(red: 0.95, green: 0.78, blue: 0.25)
    static let goldDark = Color(red: 0.7, green: 0.5, blue: 0.1)

    static let goldGradient = LinearGradient(
        colors: [gold, goldLight],
        startPoint: .leading,
        endPoint: .trailing
    )

    enum Opacity {
        static let disabled: Double = 0.3
        static let secondary: Double = 0.5
        static let muted: Double = 0.6
        static let subtle: Double = 0.7
    }
}

extension View {
    func cardBackground() -> some View {
        self.background(RoundedRectangle(cornerRadius: 12).fill(Color.white.opacity(0.08)))
    }

    func screenBackground() -> some View {
        self.background(Color.black.ignoresSafeArea())
    }
}
