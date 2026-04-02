//
//  UserProfile.swift
//  Social IQ
//

import Foundation

struct UserProfile: Codable, Identifiable {
    let id: UUID
    let appleUserId: String
    let email: String?
    let displayName: String?
    let createdAt: Date
}
