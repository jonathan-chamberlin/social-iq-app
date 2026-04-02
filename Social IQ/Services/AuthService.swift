//
//  AuthService.swift
//  Social IQ
//

import AuthenticationServices
import CryptoKit
import Foundation
import Supabase

final class AuthService {
    static let shared = AuthService()
    private init() {}

    /// The raw nonce for the current sign-in attempt.
    /// Set via `generateNonce()` before presenting the Apple sign-in sheet.
    private(set) var currentNonce: String?

    // MARK: - Public API

    /// Call before presenting Sign in with Apple. Returns the SHA256 hash
    /// to set on the ASAuthorizationAppleIDRequest.
    func generateNonce() -> String {
        let nonce = randomNonceString()
        currentNonce = nonce
        return sha256(nonce)
    }

    /// Exchange an Apple credential for a Supabase session.
    func signInWithApple(credential: ASAuthorizationAppleIDCredential) async throws -> User {
        guard let nonce = currentNonce else {
            throw AuthError.missingNonce
        }
        guard let tokenData = credential.identityToken,
              let idToken = String(data: tokenData, encoding: .utf8) else {
            throw AuthError.missingIdentityToken
        }

        let session = try await SupabaseService.shared.client.auth.signInWithIdToken(
            credentials: .init(
                provider: .apple,
                idToken: idToken,
                nonce: nonce
            )
        )

        currentNonce = nil
        return session.user
    }

    func signOut() async throws {
        try await SupabaseService.shared.client.auth.signOut()
    }

    func restoreSession() async throws -> User? {
        let session = try await SupabaseService.shared.client.auth.session
        return session.user
    }

    // MARK: - Nonce helpers

    private func randomNonceString(length: Int = 32) -> String {
        var randomBytes = [UInt8](repeating: 0, count: length)
        let status = SecRandomCopyBytes(kSecRandomDefault, randomBytes.count, &randomBytes)
        precondition(status == errSecSuccess, "Failed to generate random bytes")
        let charset: [Character] = Array("0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._")
        return String(randomBytes.map { charset[Int($0) % charset.count] })
    }

    private func sha256(_ input: String) -> String {
        let data = Data(input.utf8)
        let hash = SHA256.hash(data: data)
        return hash.compactMap { String(format: "%02x", $0) }.joined()
    }
}

// MARK: - Auth Error

enum AuthError: LocalizedError {
    case missingIdentityToken
    case missingNonce

    var errorDescription: String? {
        switch self {
        case .missingIdentityToken:
            "Apple Sign In did not return an identity token."
        case .missingNonce:
            "Sign-in nonce was not generated. Please try again."
        }
    }
}
