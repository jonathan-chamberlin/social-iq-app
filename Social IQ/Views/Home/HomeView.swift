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
    @State private var proBadgeGlow = false
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
            ZStack {
                ScrollView {
                    VStack(spacing: 20) {
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

                        #if DEBUG
                        if debugForceSubscribed {
                            Text("DEBUG: Pro mode forced ON")
                                .font(.caption)
                                .foregroundStyle(.green)
                                .frame(maxWidth: .infinity, alignment: .leading)
                        }
                        #endif

                        ForEach(LessonData.allLessons) { lesson in
                            Button {
                                handleLessonTap(lesson)
                            } label: {
                                lessonCard(lesson)
                            }
                            .buttonStyle(.plain)
                        }

                        if !isProUser {
                            upgradeButton
                                .padding(.top, 8)
                        }

                        Button("Sign Out", role: .destructive) {
                            Task {
                                await authViewModel.signOut()
                            }
                        }
                        .padding(.bottom, 32)
                    }
                    .padding(.horizontal, 20)
                }
            }
            .screenBackground()
            .navigationDestination(item: $selectedLesson) { lesson in
                LessonView(
                    lesson: lesson,
                    userId: userId,
                    onComplete: { Task { await loadCompletedLessons() } }
                )
            }
            .toolbar {
                ToolbarItem(placement: .principal) {
                    HStack(spacing: 8) {
                        Text("Social IQ")
                            .font(.headline)
                            .foregroundStyle(.white)
                        if isProUser {
                            Text("PRO")
                                .font(.caption2)
                                .fontWeight(.heavy)
                                .foregroundStyle(.white)
                                .padding(.horizontal, 8)
                                .padding(.vertical, 3)
                                .background(Capsule().fill(Theme.goldGradient))
                                .shadow(color: proBadgeGlow ? Theme.gold.opacity(0.6) : .clear, radius: 8)
                                .onAppear {
                                    withAnimation(.easeInOut(duration: 0.8).repeatForever(autoreverses: true)) {
                                        proBadgeGlow = true
                                    }
                                }
                        }
                    }
                }
                if AppConfig.showResetDataButton {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Reset Data") {
                            showResetConfirmation = true
                        }
                        .font(.caption2)
                        .foregroundStyle(.red.opacity(0.7))
                    }
                }
            }
            .alert("Reset All Data?", isPresented: $showResetConfirmation) {
                Button("Reset", role: .destructive) {
                    Task { await resetUserData() }
                }
                Button("Cancel", role: .cancel) {}
            } message: {
                Text("This will clear your profile, onboarding, and lesson progress. You will be signed out.")
            }
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task { await loadCompletedLessons() }
            .onAppear {
                if UserDefaults.standard.bool(forKey: AppConstants.shouldAutoOpenLesson1Key) {
                    UserDefaults.standard.removeObject(forKey: AppConstants.shouldAutoOpenLesson1Key)
                    selectedLesson = LessonData.allLessons.first
                }
            }
        }
    }

    private func isLocked(_ lesson: Lesson) -> Bool {
        _ = subscriptionRevision
        #if DEBUG
        if debugForceSubscribed { return false }
        #endif
        return !AppConstants.freeLessonIds.contains(lesson.id) && !SuperwallService.isSubscribed
    }

    private func handleLessonTap(_ lesson: Lesson) {
        if isLocked(lesson) {
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

    private func loadCompletedLessons() async {
        guard let userId else { return }
        do {
            let completed = try await progressService.fetchCompletedLessons(userId: userId)
            completedLessonIds = Set(completed.map(\.lessonId))
        } catch {
            // Silently fail — lessons still usable without progress data
        }
    }

    // MARK: - Reset

    private func resetUserData() async {
        guard let userId else { return }
        let client = SupabaseService.shared.client

        struct ProfileReset: Encodable {
            let onboardingCompleted: Bool
            let firstName: String?
            let age: Int?
            let gender: String?
            let socialContext: String?
            let quiz1Answer: String?
            let quiz2Answer: String?
            let quiz3Answer: String?
            let selectedGoals: [String]?
            let referralCode: String?
            let discoverySource: String?
            let currentStreak: Int
            let longestStreak: Int
            let totalXp: Int

            enum CodingKeys: String, CodingKey {
                case onboardingCompleted = "onboarding_completed"
                case firstName = "first_name"
                case age, gender
                case socialContext = "social_context"
                case quiz1Answer = "quiz1_answer"
                case quiz2Answer = "quiz2_answer"
                case quiz3Answer = "quiz3_answer"
                case selectedGoals = "selected_goals"
                case referralCode = "referral_code"
                case discoverySource = "discovery_source"
                case currentStreak = "current_streak"
                case longestStreak = "longest_streak"
                case totalXp = "total_xp"
            }
        }

        let reset = ProfileReset(
            onboardingCompleted: false,
            firstName: nil, age: nil, gender: nil, socialContext: nil,
            quiz1Answer: nil, quiz2Answer: nil, quiz3Answer: nil,
            selectedGoals: nil, referralCode: nil, discoverySource: nil,
            currentStreak: 0, longestStreak: 0, totalXp: 0
        )

        do {
            try await client
                .from(DatabaseSchema.UserProfiles.table)
                .update(reset)
                .eq(DatabaseSchema.UserProfiles.id, value: userId)
                .execute()

            try await client
                .from(DatabaseSchema.LessonProgress.table)
                .delete()
                .eq(DatabaseSchema.LessonProgress.userId, value: userId)
                .execute()
        } catch {
            // Best-effort reset
        }
        await authViewModel.signOut()
    }

    // MARK: - Lesson Card

    private func lessonCard(_ lesson: Lesson) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(lesson.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 8) {
                    tag(lesson.category.rawValue, color: Theme.gold)
                    tag(lesson.difficulty.rawValue, color: .blue)
                }
            }

            Spacer()

            if isLocked(lesson) {
                Text("PRO")
                    .font(.caption2)
                    .fontWeight(.bold)
                    .foregroundStyle(.white)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(
                        Capsule().fill(Theme.goldGradient)
                    )
            } else if completedLessonIds.contains(lesson.id) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .cardBackground()
        .overlay(
            RoundedRectangle(cornerRadius: 12)
                .stroke(Color.white.opacity(0.1), lineWidth: 1)
        )
    }

    private func tag(_ text: String, color: Color) -> some View {
        Text(text.capitalized)
            .font(.caption2)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Capsule().fill(color.opacity(0.4)))
    }

    // MARK: - Upgrade Button

    private var upgradeButton: some View {
        Button {
            SuperwallService.presentPaywall(placement: .lessonLocked) {
                Task { @MainActor in
                    subscriptionRevision += 1
                    if SuperwallService.isSubscribed {
                        AnalyticsService.track(event: .subscriptionStarted)
                    }
                }
            }
        } label: {
            Label("Upgrade", systemImage: "star.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(Theme.goldGradient)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
