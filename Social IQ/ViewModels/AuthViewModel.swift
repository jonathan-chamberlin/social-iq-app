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
    /// First name from Apple credential (only available on first sign-in).
    var appleFirstName: String?

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
            appleFirstName = credential.fullName?.givenName
            #if DEBUG
            print("[Auth] Apple credential givenName: \(appleFirstName ?? "nil")")
            #endif

            let user = try await AuthService.shared.signInWithApple(credential: credential)

            // Apple only sends fullName on the very first authorization.
            // On re-auth, fall back to the name stored in user_profiles.
            if appleFirstName == nil || appleFirstName?.isEmpty == true {
                let storedName = await AuthService.shared.fetchFirstName(userId: user.id.uuidString)
                #if DEBUG
                print("[Auth] user_profiles first_name: \(storedName ?? "nil")")
                #endif
                if let storedName, !storedName.isEmpty {
                    appleFirstName = storedName
                }
            }

            #if DEBUG
            print("[Auth] Final appleFirstName: \(appleFirstName ?? "nil")")
            #endif
            authState = .signedIn(user)
        } catch {
            errorMessage = error.localizedDescription
            authState = .signedOut
        }
    }

    #if DEBUG
    var devSkipOnboarding = false

    func devSkipAuth() {
        let devUser = User(
            id: UUID(),
            appMetadata: [:],
            userMetadata: ["full_name": .string("Dev User")],
            aud: "dev",
            createdAt: Date(),
            updatedAt: Date()
        )
        authState = .signedIn(devUser)
    }

    func devSkipAll() {
        devSkipOnboarding = true
        devSkipAuth()
    }
    #endif

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
