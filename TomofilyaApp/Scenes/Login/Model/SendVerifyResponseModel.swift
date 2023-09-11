//
//  SendVerifyResponseModel.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import Foundation

struct SendVerifyResponseModel: Decodable {
    let success: Bool
    let message: String?
}
