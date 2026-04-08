//
//  SignInView.swift
//  Social IQ
//

import AuthenticationServices
import SwiftUI

struct SignInView: View {
    var authViewModel: AuthViewModel

    var body: some View {
        ZStack {
            VStack(spacing: 32) {
                Spacer()

                Text("Social IQ")
                    .font(.system(size: 40, weight: .bold))
                    .foregroundStyle(.white)

                Text("Master every conversation")
                    .font(.title3)
                    .foregroundStyle(.gray)

                Spacer()

                if case .loading = authViewModel.authState {
                    ProgressView()
                        .tint(.white)
                        .scaleEffect(1.2)
                } else {
                    SignInWithAppleButton(.signIn) { request in
                        request.requestedScopes = [.fullName, .email]
                        request.nonce = AuthService.shared.generateNonce()
                    } onCompletion: { result in
                        Task {
                            await authViewModel.handleAppleSignIn(result: result)
                        }
                    }
                    .signInWithAppleButtonStyle(.white)
                    .frame(height: 50)
                    .frame(maxWidth: 280)
                }

                #if DEBUG
                Button("Skip Sign In (Dev)") {
                    authViewModel.devSkipAuth()
                }
                .font(.footnote)
                .foregroundStyle(.gray)

                Button("Skip Onboarding (Dev)") {
                    authViewModel.devSkipAll()
                }
                .font(.footnote)
                .foregroundStyle(.gray)
                #endif

                if let error = authViewModel.errorMessage {
                    Text(error)
                        .font(.footnote)
                        .foregroundStyle(.red)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal, 32)
                }

                Spacer()
                    .frame(height: 60)
            }
        }
        .screenBackground()
    }
}

#Preview {
    SignInView(authViewModel: AuthViewModel())
}
