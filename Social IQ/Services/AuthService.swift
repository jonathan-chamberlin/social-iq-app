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
    /// Apple only sends fullName/email on the very first sign-in for a given
    /// app+Apple ID pair. We persist whatever Apple provides to `user_profiles`
    /// immediately so it survives re-auth and account deletion.
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

        // Persist Apple-provided name and email to user_profiles.
        // Apple only sends these on the very first authorization, so this is
        // our one chance to capture them in a table we control.
        let givenName = credential.fullName?.givenName
        let email = credential.email
        if (givenName != nil && !givenName!.isEmpty) || (email != nil && !email!.isEmpty) {
            #if DEBUG
            print("[Auth] Saving Apple info to user_profiles - name: \(givenName ?? "nil"), email: \(email ?? "nil")")
            #endif
            try? await saveAppleInfoToProfile(
                userId: session.user.id.uuidString,
                firstName: givenName,
                email: email
            )
        }

        currentNonce = nil
        return session.user
    }

    /// Fetch the stored first name from user_profiles.
    /// Used as fallback when Apple doesn't provide the name on re-auth.
    func fetchFirstName(userId: String) async -> String? {
        struct Row: Decodable {
            let firstName: String?
            enum CodingKeys: String, CodingKey {
                case firstName = "first_name"
            }
        }
        do {
            let rows: [Row] = try await SupabaseService.shared.client
                .from(DatabaseSchema.UserProfiles.table)
                .select(DatabaseSchema.UserProfiles.firstName)
                .eq(DatabaseSchema.UserProfiles.id, value: userId)
                .execute()
                .value
            return rows.first?.firstName
        } catch {
            #if DEBUG
            print("[Auth] Failed to fetch first name: \(error)")
            #endif
            return nil
        }
    }

    func signOut() async throws {
        try await SupabaseService.shared.client.auth.signOut()
    }

    func restoreSession() async throws -> User? {
        // Force a server-side refresh to verify the user still exists.
        // The local Keychain may hold a valid-looking JWT for a deleted user.
        let session = try await SupabaseService.shared.client.auth.refreshSession()
        return session.user
    }

    // MARK: - Profile persistence

    /// Save Apple-provided name/email to user_profiles.
    /// Only updates non-nil fields so we never overwrite existing data with nil.
    private func saveAppleInfoToProfile(userId: String, firstName: String?, email: String?) async throws {
        struct AppleInfoUpdate: Encodable {
            let firstName: String?
            let email: String?

            enum CodingKeys: String, CodingKey {
                case firstName = "first_name"
                case email
            }
        }

        let update = AppleInfoUpdate(firstName: firstName, email: email)
        try await SupabaseService.shared.client
            .from(DatabaseSchema.UserProfiles.table)
            .update(update)
            .eq(DatabaseSchema.UserProfiles.id, value: userId)
            .execute()
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
