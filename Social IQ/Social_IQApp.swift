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
    @State private var showSplash = true

    private static let splashDuration: Duration = .milliseconds(1500)
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
                if showSplash {
                    SplashView()
                        .task {
                            try? await Task.sleep(for: Self.splashDuration)
                            withAnimation { showSplash = false }
                        }
                } else {
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
                                OnboardingView(
                                userId: user.id.uuidString,
                                appleFirstName: authViewModel.appleFirstName
                            ) {
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
                    .onChange(of: signedInUserId) { oldId, newId in
                        if oldId != nil, newId == nil {
                            // User signed out — reset so next sign-in re-checks onboarding
                            onboardingChecked = false
                            showOnboarding = false
                        }
                    }
                }
            }
            .preferredColorScheme(.dark)
        }
    }

    private func checkOnboarding(userId: String) async {
        AnalyticsService.identify(userId: userId)
        SuperwallService.identify(userId: userId)
        #if DEBUG
        if authViewModel.devSkipOnboarding {
            showOnboarding = false
            onboardingChecked = true
            return
        }
        #endif
        do {
            let completed = try await withTimeout(seconds: 5) {
                try await onboardingService.fetchOnboardingCompleted(userId: userId)
            }
            showOnboarding = !completed
            // If onboarding is needed and we don't have the name yet (session restore,
            // not fresh sign-in), fetch it from user_profiles.
            if showOnboarding, authViewModel.appleFirstName == nil {
                let storedName = await AuthService.shared.fetchFirstName(userId: userId)
                if let storedName, !storedName.isEmpty {
                    authViewModel.appleFirstName = storedName
                    #if DEBUG
                    print("[App] Restored first name from user_profiles: \(storedName)")
                    #endif
                }
            }
        } catch {
            // Network unreachable or timed out. Fall back to the last cached
            // value for this user. If we've never cached one, default to "home"
            // — a signed-in user hitting offline should land on cached content,
            // not be forced back through onboarding.
            if let cached = OnboardingService.cachedOnboardingCompleted(userId: userId) {
                showOnboarding = !cached
            } else {
                showOnboarding = false
            }
            #if DEBUG
            print("[App] Onboarding check failed (\(error)) — using cached value, showOnboarding=\(showOnboarding)")
            #endif
        }
        onboardingChecked = true
    }
}
