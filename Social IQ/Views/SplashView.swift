//
//  SplashView.swift
//  Social IQ
//

import SwiftUI

struct SplashView: View {
    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 24) {
                Image("LaunchLogo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 24))

                Text("Social IQ")
                    .font(.system(size: 36, weight: .bold))
                    .foregroundStyle(Theme.gold)
            }
        }
    }
}
