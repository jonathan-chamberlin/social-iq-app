//
//  HomeView.swift
//  Social IQ
//

import Supabase
import SwiftUI

struct HomeView: View {
    var authViewModel: AuthViewModel
    @State private var completedLessonIds: Set<String> = []
    @State private var selectedLesson: Lesson?
    @State private var subscriptionRevision = 0
    @State private var showResetConfirmation = false
    #if DEBUG
    @State private var debugForceSubscribed = false
    #endif

    private let progressService = LessonProgressService()

    private var userName: String {
        if case .signedIn(let user) = authViewModel.authState,
           let metadata = user.userMetadata[DatabaseSchema.UserMetadata.fullName],
           case .string(let name) = metadata {
            return name
        }
        return ""
    }

    private var userId: String? {
        if case .signedIn(let user) = authViewModel.authState {
            return user.id.uuidString
        }
        return nil
    }

    private var greeting: String {
        userName.isEmpty ? "Welcome" : "Welcome back, \(userName)"
    }

    private var isProUser: Bool {
        _ = subscriptionRevision
        #if DEBUG
        if debugForceSubscribed { return true }
        #endif
        return SuperwallService.isSubscribed
    }

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    greetingHeader
                    #if DEBUG
                    debugBanner
                    #endif

                    HomeLessonList(
                        completedLessonIds: completedLessonIds,
                        isProUser: isProUser,
                        onLessonTap: { handleLessonTap($0) }
                    )

                    if !isProUser {
                        HomeUpgradeButton { presentUpgradePaywall() }
                            .padding(.top, 8)
                    }
                }
                .padding(.horizontal, 20)
            }
            .screenBackground()
            .navigationDestination(item: $selectedLesson) { lesson in
                LessonView(
                    lesson: lesson,
                    userId: userId,
                    isReplay: completedLessonIds.contains(lesson.id),
                    onComplete: { Task { await loadCompletedLessons() } }
                )
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Text("Social IQ")
                            .font(.headline)
                            .foregroundStyle(.white)
                        if isProUser { HomeProBadge() }
                    }
                }
                ToolbarItem(placement: .topBarTrailing) {
                    HStack(spacing: 12) {
                        NavigationLink {
                            SettingsView(authViewModel: authViewModel)
                        } label: {
                            Image(systemName: "gearshape")
                                .foregroundStyle(.white.opacity(Theme.Opacity.subtle))
                        }
                        #if DEBUG
                        if AppConfig.showResetDataButton {
                            Button("Reset Data") { showResetConfirmation = true }
                                .font(.caption2)
                                .foregroundStyle(.red.opacity(Theme.Opacity.subtle))
                        }
                        #endif
                    }
                }
            }
            .alert("Reset All Data?", isPresented: $showResetConfirmation) {
                Button("Reset", role: .destructive) {
                    Task { await resetUserData() }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("Clears profile, onboarding, and lesson progress. To also reset Pro, cancel sandbox subscription in Settings > App Store > Sandbox Account first.")
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task { await loadCompletedLessons() }
            .task {
                try? await Task.sleep(for: .seconds(2))
                if SuperwallService.isSubscribed { subscriptionRevision += 1 }
            }
            .onAppear {
                if UserDefaults.standard.bool(forKey: AppConstants.shouldAutoOpenLesson1Key) {
                    UserDefaults.standard.removeObject(forKey: AppConstants.shouldAutoOpenLesson1Key)
                    selectedLesson = LessonData.allLessons.first
                }
            }
        }
    }

    // MARK: - Greeting

    private var greetingHeader: some View {
        Text(greeting)
            .font(.title2)
            .fontWeight(.bold)
            .foregroundStyle(.white)
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.top, 8)
            #if DEBUG
            .onLongPressGesture(minimumDuration: 2) {
                debugForceSubscribed.toggle()
                SuperwallService.debugForceSubscribed = debugForceSubscribed
            }
            #endif
    }

    #if DEBUG
    @ViewBuilder private var debugBanner: some View {
        if debugForceSubscribed {
            Text("DEBUG: Pro mode forced ON")
                .font(.caption)
                .foregroundStyle(.green)
                .frame(maxWidth: .infinity, alignment: .leading)
        }
    }
    #endif

    // MARK: - Actions

    private func handleLessonTap(_ lesson: Lesson) {
        if !AppConstants.freeLessonIds.contains(lesson.id) && !isProUser {
            AnalyticsService.track(event: .lessonLockedTap, properties: ["lesson_id": lesson.id])
            let tappedLesson = lesson
            SuperwallService.presentPaywall(placement: .lessonLocked) {
                Task { @MainActor in
                    subscriptionRevision += 1
                    if SuperwallService.isSubscribed {
                        AnalyticsService.track(event: .subscriptionStarted)
                        selectedLesson = tappedLesson
                    }
                }
            }
        } else {
            selectedLesson = lesson
        }
    }

    private func presentUpgradePaywall() {
        SuperwallService.presentPaywall(placement: .lessonLocked) {
            Task { @MainActor in
                subscriptionRevision += 1
                if SuperwallService.isSubscribed {
                    AnalyticsService.track(event: .subscriptionStarted)
                }
            }
        }
    }

    private func loadCompletedLessons() async {
        guard let userId else { return }
        do {
            let completed = try await progressService.fetchCompletedLessons(userId: userId)
            completedLessonIds = Set(completed.map(\.lessonId))
        } catch {
            // Silently fail - lessons still usable without progress data
        }
    }

    private func resetUserData() async {
        guard let userId else { return }
        let onboardingService = OnboardingService()
        do {
            try await onboardingService.resetProfile(userId: userId)
            try await progressService.deleteAllProgress(userId: userId)
        } catch {
            // Best-effort reset
        }
        SuperwallService.reset()
        await authViewModel.signOut()
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
