//
//  HomeView.swift
//  Social IQ
//

import Supabase
import SwiftUI

struct HomeView: View {
    var authViewModel: AuthViewModel

    private var userName: String {
        if case .signedIn(let user) = authViewModel.authState,
           let metadata = user.userMetadata["full_name"],
           case .string(let name) = metadata {
            return name
        }
        return ""
    }

    private var greeting: String {
        userName.isEmpty ? "Welcome" : "Welcome back, \(userName)"
    }

    var body: some View {
        NavigationStack {
            ZStack {
                Color.black.ignoresSafeArea()

                VStack(spacing: 24) {
                    Spacer()

                    Text(greeting)
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundStyle(.white)

                    NavigationLink(destination: LessonView()) {
                        Label("Start Lesson", systemImage: "book.fill")
                            .font(.headline)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(
                                LinearGradient(
                                    colors: [.purple, .blue],
                                    startPoint: .leading,
                                    endPoint: .trailing
                                )
                            )
                            .foregroundStyle(.white)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                    }
                    .padding(.horizontal, 32)

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
                    .padding(.horizontal, 32)

                    Spacer()

                    Button("Sign Out", role: .destructive) {
                        Task {
                            await authViewModel.signOut()
                        }
                    }
                    .padding(.bottom, 32)
                }
            }
            .navigationTitle("Social IQ")
            .toolbarColorScheme(.dark, for: .navigationBar)
        }
    }
}

#Preview {
    HomeView(authViewModel: AuthViewModel())
}
