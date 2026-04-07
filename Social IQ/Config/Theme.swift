//
//  Theme.swift
//  Social IQ
//

import SwiftUI

enum Theme {
    static let gold = Color(red: 0.85, green: 0.65, blue: 0.13)
    static let goldLight = Color(red: 0.95, green: 0.78, blue: 0.25)
    static let goldDark = Color(red: 0.7, green: 0.5, blue: 0.1)

    static let accentGradient = LinearGradient(
        colors: [goldLight, gold],
        startPoint: .leading,
        endPoint: .trailing
    )
}
