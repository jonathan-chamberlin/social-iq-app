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
        AnalyticsService.initialize(token: AppConfig.mixpanelToken)
    }

    private var signedInUserId: String? {
        if case .signedIn(let user) = authViewModel.authState {
            return user.id.uuidString
        }
        return nil
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
            .overlay(alignment: .bottomTrailing) {
                if signedInUserId != nil {
                    FeedbackButton(userId: signedInUserId)
                        .padding(.trailing, 20)
                        .padding(.bottom, 24)
                }
            }
            .task {
                await authViewModel.checkSession()
            }
        }
    }

    private func checkOnboarding(userId: String) async {
        AnalyticsService.identify(userId: userId)
        #if DEBUG
        if authViewModel.devSkipOnboarding {
            showOnboarding = false
            onboardingChecked = true
            return
        }
        #endif
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
