//
//  LoginResponseModel.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import Foundation

// MARK: - LoginResponseModel
struct LoginResponseModel: Codable {
    let data: UserData?
    let success: Bool?
    let message: String?
}

// MARK: - DataClass
struct UserData: Codable {
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
