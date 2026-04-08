//
//  AppConfig.swift
//  Social IQ
//

import Foundation

enum AppConfig {
    // swiftlint:disable:next force_unwrapping
    static let supabaseURL: URL = {
        guard let url = URL(string: "https://mobxxxxbsuuygwddjfom.supabase.co") else {
            fatalError("Invalid Supabase URL - check AppConfig")
        }
        return url
    }()
    static let supabaseAnonKey = "sb_publishable_tOhcW5WAn7K5jvqDCPKJiQ_rZbdhNGP"
    static let superwallAPIKey = "pk_FleX2nb2iqfrCDpPwGpmI"
    static let mixpanelToken = "c1389400976ecbdf82fd43ac29fb6212"

    /// Show "Reset Data" button on HomeView for testing. Set to false before release.
    static let showResetDataButton = false

    // Non-secret constants (UserDefaults keys, product IDs) live in Constants/AppConstants.swift
}
