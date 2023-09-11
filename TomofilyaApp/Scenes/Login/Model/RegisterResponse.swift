//
//  RegisterResponse.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 26.08.2023.
//

import Foundation

struct RegisterResponse: Decodable {
    let success: Bool
    let message: String?
}

