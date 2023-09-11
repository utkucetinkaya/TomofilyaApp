//
//  SocialResponseModel.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import Foundation

// MARK: - SocialResponseModel
struct SocialResponseModel: Codable {
    let data: DataClass?
    let success: Bool?
    let message: String?
}

// MARK: - DataClass
struct DataClass: Codable {
    let accessToken, refreshToken, fullName: String?
    let userID: Int?
    let expiration: String?
    let isSocialMediaAccount: Bool?

    enum CodingKeys: String, CodingKey {
        case accessToken, refreshToken, fullName
        case userID = "userId"
        case expiration, isSocialMediaAccount
    }
}

struct SocialLoginRequest: Codable {
    let token: String
    let platform: String
}
//
//struct SocialResponseModel: Codable {
//    let accessToken: String?
//    let expiration: String?
//    let fullName: String?
//    let isSocialMediaAccount: Bool?
//    let refreshToken: String?
//    let userId: Int?
//}
