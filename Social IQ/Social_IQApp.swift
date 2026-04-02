//
//  Social_IQApp.swift
//  Social IQ
//
//  Created by Jonathan Chamberlin on 3/26/26.
//

import SwiftUI

@main
struct Social_IQApp: App {
    @State private var authViewModel = AuthViewModel()

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
                case .signedIn:
                    HomeView(authViewModel: authViewModel)
                }
            }
            .task {
                await authViewModel.checkSession()
            }
        }
    }
}
