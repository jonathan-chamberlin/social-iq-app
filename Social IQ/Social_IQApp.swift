//
//  Social_IQApp.swift
//  Social IQ
//
//  Created by Jonathan Chamberlin on 3/26/26.
//

import Supabase
import SwiftUI

@main
struct Social_IQApp: App {
    @State private var authViewModel = AuthViewModel()
    @State private var showOnboarding = false
    @State private var onboardingChecked = false

    private let onboardingService = OnboardingService()

    init() {
        // Eagerly initialize the Supabase client
        _ = SupabaseService.shared
        SuperwallService.configure()
    }

    var body: some Scene {
        WindowGroup {
            Group {
                switch authViewModel.authState {
                case .signedOut:
                    SignInView(authViewModel: authViewModel)
                case .loading:
                    ProgressView("Loading...")
                case .signedIn(let user):
                    if !onboardingChecked {
                        ProgressView("Loading...")
                            .task { await checkOnboarding(userId: user.id.uuidString) }
                    } else if showOnboarding {
                        OnboardingView(userId: user.id.uuidString) {
                            showOnboarding = false
                        }
                    } else {
                        HomeView(authViewModel: authViewModel)
                    }
                }
            }
            .task {
                await authViewModel.checkSession()
            }
        }
    }

    private func checkOnboarding(userId: String) async {
        do {
            let completed = try await onboardingService.fetchOnboardingCompleted(userId: userId)
            showOnboarding = !completed
        } catch {
            // If we can't check, skip onboarding (don't block the user)
            showOnboarding = false
        }
        onboardingChecked = true
    }
}
