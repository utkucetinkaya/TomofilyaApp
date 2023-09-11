//
//  Router.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import Foundation

protocol URLRequestConvertible {
    var url: URL { get }
    var method: HTTPMethod { get }
    var parameters: [String: Any]? { get }
    var headers: [String: String]? { get }
    func request() -> URLRequest
}

enum Router {
    case register(fullName: String, email: String, password: String)
    case verifyCode(email: String, code: String)
    case login(credentials: [String: Any])
    case socialLogin(token: String, platform: String)
    case sendVerificationCode(email: String)
    case passwordReset(email: String, verificationCode: String, password: String)
}

extension Router: URLRequestConvertible {

    static let baseURL = "https://tomofilya.azurewebsites.net"

    var url: URL {
        switch self {
        case .sendVerificationCode(let email):
            guard let encodedEmail = email.addingPercentEncoding(withAllowedCharacters: .urlPathAllowed) else {
                fatalError("Invalid email")
            }
            return URL(string: Router.baseURL + path.replacingOccurrences(of: "{email}", with: encodedEmail))!
        default:
            return URL(string: Router.baseURL + path)!
        }
    }

    var path: String {
        switch self {
        case .register:
            return "/user/post"
        case .verifyCode:
            return "/user/verifycode"
        case .login:
            return "/authentication/login"
        case .socialLogin:
            return "/authentication/social"
        case .sendVerificationCode:
            return "/user/sendverificationcode/{email}"
        case .passwordReset:
            return "/user/passwordreset"
        }
    }

    var method: HTTPMethod {
        switch self {
        case .register, .verifyCode, .login, .socialLogin, .passwordReset:
            return .post
        case .sendVerificationCode:
            return .get
        }
    }

    var parameters: [String : Any]? {

        switch self {
        case .register(let fullName, let email, let password):
            return ["fullName": fullName, "email": email, "password": password]
        case .verifyCode(let email, let code):
            return ["email": email, "code": code]
        case .login(let credentials):
            return credentials
        case .socialLogin(let token, let platform):
            return ["token": token, "platform": platform]
        case .sendVerificationCode:
            return nil
        case .passwordReset(let email, let verificationCode, let password):
            return ["email": email, "verificationCode": verificationCode, "password": password]
        }

    }

    var headers: [String : String]? {
        var headers = [
            "Content-Type": "application/json",
            "ApiKey": "COF40RZ95GBJZ7R08QVJMIDR0TLEJL1DDEXY10K0H8MQ03DJJ8"
        ]
        switch self {
        case .socialLogin(let token, _):
            headers["Authorization"] = "Bearer \(token)"
        default:
            break
        }
        return headers
    }
    
    func request() -> URLRequest {
        // Create request
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        // Add Parameters
        if let parameters = parameters {
            do {
                let data = try JSONSerialization.data(withJSONObject: parameters)
                request.httpBody = data
            } catch {
                print(error.localizedDescription)
            }
        }
        // Add Headers
        if let headers = headers {
            for (key, value) in headers {
                request.setValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
}
