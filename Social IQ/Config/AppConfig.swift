//
//  AppConfig.swift
//  Social IQ
//

import Foundation

enum AppConfig {
    static let supabaseURL = URL(string: "https://mobxxxxbsuuygwddjfom.supabase.co")!
    static let supabaseAnonKey = "sb_publishable_tOhcW5WAn7K5jvqDCPKJiQ_rZbdhNGP"
    static let superwallAPIKey = "pk_FleX2nb2iqfrCDpPwGpmI"
    static let mixpanelToken = "c1389400976ecbdf82fd43ac29fb6212"

    /// Show "Reset Data" button on HomeView for testing. Set to false before release.
    static let showResetDataButton = false

    // Non-secret constants (UserDefaults keys, product IDs) live in Constants/AppConstants.swift
}
