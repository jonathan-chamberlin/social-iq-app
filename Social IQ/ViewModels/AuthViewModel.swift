//
//  AuthViewModel.swift
//  Social IQ
//

import AuthenticationServices
import Foundation
import Supabase

@Observable
final class AuthViewModel {
    enum AuthState {
        case signedOut
        case loading
        case signedIn(User)
    }

    var authState: AuthState = .signedOut
    var errorMessage: String?

    func checkSession() async {
        authState = .loading
        do {
            if let user = try await AuthService.shared.restoreSession() {
                authState = .signedIn(user)
            } else {
                authState = .signedOut
            }
        } catch {
            authState = .signedOut
        }
    }

    /// Called from SignInWithAppleButton's onCompletion.
    func handleAppleSignIn(result: Result<ASAuthorization, Error>) async {
        authState = .loading
        errorMessage = nil
        do {
            guard case .success(let authorization) = result,
                  let credential = authorization.credential as? ASAuthorizationAppleIDCredential else {
                if case .failure(let error) = result {
                    throw error
                }
                throw AuthError.missingIdentityToken
            }
            let user = try await AuthService.shared.signInWithApple(credential: credential)
            authState = .signedIn(user)
        } catch {
            errorMessage = error.localizedDescription
            authState = .signedOut
        }
    }

    func signOut() async {
        do {
            try await AuthService.shared.signOut()
            authState = .signedOut
            errorMessage = nil
        } catch {
            errorMessage = error.localizedDescription
        }
    }
}
