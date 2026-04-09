//
//  SettingsView.swift
//  Social IQ
//

import Supabase
import SwiftUI

struct SettingsView: View {
    var authViewModel: AuthViewModel

    @Environment(\.dismiss) private var dismiss
    @State private var showDeleteConfirmation = false
    @State private var isRestoringPurchases = false
    @State private var restoreMessage: String?

    private let progressService = LessonProgressService()
    private let onboardingService = OnboardingService()

    private var userId: String? {
        if case .signedIn(let user) = authViewModel.authState {
            return user.id.uuidString
        }
        return nil
    }

    var body: some View {
        List {
            // MARK: - Purchases
            Section {
                Button {
                    Task { await restorePurchases() }
                } label: {
                    HStack {
                        Label("Restore Purchases", systemImage: "arrow.clockwise")
                        Spacer()
                        if isRestoringPurchases {
                            ProgressView()
                                .tint(.white)
                        }
                    }
                }
                .disabled(isRestoringPurchases)
            } footer: {
                if let restoreMessage {
                    Text(restoreMessage)
                        .foregroundStyle(.white.opacity(0.6))
                }
            }

            // MARK: - Legal
            Section {
                Link(destination: AppConstants.privacyPolicyURL) {
                    Label("Privacy Policy", systemImage: "hand.raised")
                }

                Link(destination: AppConstants.supportURL) {
                    Label("Support", systemImage: "questionmark.circle")
                }
            }

            // MARK: - Account
            Section {
                Button {
                    Task { await authViewModel.signOut() }
                } label: {
                    Label("Sign Out", systemImage: "rectangle.portrait.and.arrow.right")
                }

                Button(role: .destructive) {
                    showDeleteConfirmation = true
                } label: {
                    Label("Delete Account", systemImage: "trash")
                }
            }
        }
        .scrollContentBackground(.hidden)
        .screenBackground()
        .foregroundStyle(.white)
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbarColorScheme(.dark, for: .navigationBar)
        .alert("Delete Account?", isPresented: $showDeleteConfirmation) {
            Button("Delete", role: .destructive) {
                Task { await deleteAccount() }
            }
            Button("Cancel", role: .cancel) {}
        } message: {
            Text("This will permanently delete your account and all associated data. This action cannot be undone.")
        }
    }

    // MARK: - Actions

    private func restorePurchases() async {
        isRestoringPurchases = true
        restoreMessage = nil
        do {
            try await SuperwallService.restorePurchases()
            restoreMessage = SuperwallService.isSubscribed
                ? "Purchases restored successfully."
                : "No active subscriptions found."
        } catch {
            restoreMessage = "Could not restore purchases. Please try again."
        }
        isRestoringPurchases = false
    }

    private func deleteAccount() async {
        guard let userId else { return }
        do {
            try await onboardingService.resetProfile(userId: userId)
            try await progressService.deleteAllProgress(userId: userId)
        } catch {
            // Best-effort data cleanup
        }
        SuperwallService.reset()
        await authViewModel.signOut()
    }
}

#Preview {
    NavigationStack {
        SettingsView(authViewModel: AuthViewModel())
    }
}
