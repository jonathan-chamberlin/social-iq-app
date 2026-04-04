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

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                ScrollView {
                    VStack(spacing: 20) {
                        Text(greeting)
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.top, 8)

                        ForEach(LessonData.allLessons) { lesson in
                            Button {
                                handleLessonTap(lesson)
                            } label: {
                                lessonCard(lesson)
                            }
                            .buttonStyle(.plain)
                        }

                        upgradeButton
                            .padding(.top, 8)

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
            .navigationDestination(item: $selectedLesson) { lesson in
                LessonView(
                    lesson: lesson,
                    userId: userId,
                    onComplete: { Task { await loadCompletedLessons() } }
                )
            }
            .navigationTitle("Social IQ")
            .toolbarColorScheme(.dark, for: .navigationBar)
            .task { await loadCompletedLessons() }
            .onAppear {
                if UserDefaults.standard.bool(forKey: "shouldAutoOpenLesson1") {
                    UserDefaults.standard.removeObject(forKey: "shouldAutoOpenLesson1")
                    selectedLesson = LessonData.allLessons.first
                }
            }
        }
    }

    private func isLocked(_ lesson: Lesson) -> Bool {
        false
    }

    private func handleLessonTap(_ lesson: Lesson) {
        if isLocked(lesson) {
            SuperwallService.presentPaywall(placement: .lessonLocked)
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

    // MARK: - Lesson Card

    private func lessonCard(_ lesson: Lesson) -> some View {
        HStack {
            VStack(alignment: .leading, spacing: 10) {
                Text(lesson.title)
                    .font(.headline)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)

                HStack(spacing: 8) {
                    tag(lesson.category.rawValue, color: .purple)
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
                        Capsule().fill(
                            LinearGradient(
                                colors: [.blue, .purple],
                                startPoint: .leading,
                                endPoint: .trailing
                            )
                        )
                    )
            } else if completedLessonIds.contains(lesson.id) {
                Image(systemName: "checkmark.circle.fill")
                    .foregroundStyle(.green)
                    .font(.title2)
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.white.opacity(0.08))
        )
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
            SuperwallService.presentPaywall()
        } label: {
            Label("Upgrade", systemImage: "star.fill")
                .font(.headline)
                .frame(maxWidth: .infinity)
                .padding()
                .background(
                    LinearGradient(
                        colors: [.blue, .purple],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 12))
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
