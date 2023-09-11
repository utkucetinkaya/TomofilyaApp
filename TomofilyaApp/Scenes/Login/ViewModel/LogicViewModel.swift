//
//  LoginLogicViewModel.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import Foundation
import UIKit

class LogicViewModel {
    
    var didLogin: ((Bool) -> Void)?
    let networkController = URLSessionNetworkService.shared
    
    func register(fullName: String, email: String, password: String, completion: @escaping (Result<RegisterResponse, Error>) -> Void) {
        let endpoint = Router.register(fullName: fullName, email: email, password: password)
        
        networkController.request(endpoint) { (result: Result<RegisterResponse, Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func verifyCode(email: String, code: String, completion: @escaping (Result<VerifyCodeResponse, Error>) -> Void) {
        let endpoint = Router.verifyCode(email: email, code: code)
        
        networkController.request(endpoint) { (result: Result<VerifyCodeResponse, Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func sendVerificationCode(email: String, completion: @escaping (Result<SendVerifyResponseModel, Error>) -> Void) {
        let endpoint = Router.sendVerificationCode(email: email)
        
        networkController.request(endpoint) { (result: Result<SendVerifyResponseModel, Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func login(email: String, password: String, completion: @escaping (Result<LoginResponseModel, Error>) -> Void) {
        let endpoint = Router.login(credentials: ["email": email, "password": password])
        
        networkController.request(endpoint) { (result: Result<LoginResponseModel, Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func forgetPassword(email: String, code: String, newPassword: String, completion: @escaping (Result<PasswordResetResponse, Error>) -> Void) {
        let endpoint = Router.passwordReset(email: email, verificationCode: code, password: newPassword)
        
        networkController.request(endpoint) { (result: Result<PasswordResetResponse, Error>) in
            
            switch result {
            case .success(let response):
                completion(.success(response))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func socialLogin(request: SocialLoginRequest) {
        // Create a router object with the endpoint and the request object
        let endpoint = Router.socialLogin(token: request.token, platform: request.platform)
        // Use the network service to make the request and get the response
        URLSessionNetworkService.shared.request(endpoint) { (result: Result<SocialResponseModel, Error>) in
            switch result {
            case .success(let response):
                // Handle the success case here
                // Check if the response is successful and has data
                if response.success == true, let data = response.data {
                    // Check if the user logged in with social media account
                    if data.isSocialMediaAccount == true {
                        print(response.success)
                        self.didLogin?(true)
                    } else {
                        print("Sosyal medya hesabı ile giriş yapmanız gerekiyor.")
                        self.didLogin?(false)
                        // Handle the case where the user did not log in with social media account here
                    }
                } else {
                    // Handle the case where the response is not successful or has no data here
                    // Show the error message from the response if any
                    print("Hata")
                    self.didLogin?(false)
                }
            case .failure(let error):
                // Handle the failure case here
                // Show the error message from the error object if any
                print(error.localizedDescription)
                self.didLogin?(false)
            }
        }
    }
}
