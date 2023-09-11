//
//  ForgotPasswordViewController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.09.2023.
//

import UIKit

class ForgotPasswordViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var giveUpButton: UIButton!
    @IBOutlet private weak var emailTextField: UITextField!
    
    // MARK: - Variables
    
    var viewModel = LogicViewModel()
    var email: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setButtonTarget()
        setUI()
    }
    
    // MARK: - Set UI
    
    private func setUI() {
        sendButton.setCorner(radius: 20)
        emailTextField.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        emailTextField.setCorner(radius: 20)
    }
  
    // MARK: - Set Button Target
    
    private func setButtonTarget() {
        
        backButton.addTarget(self, action: #selector(backButtonPressed), for: .touchUpInside)
        giveUpButton.addTarget(self, action: #selector(giveUpButtonPressed), for: .touchUpInside)
        sendButton.addTarget(self, action: #selector(sendButtonPressed), for: .touchUpInside)
    }
   
    // MARK: - Objc Func
    
    // Send Button
    @objc func sendButtonPressed() {
        
        DispatchQueue.main.async {
            self.sendVerificationCode()
        }
    }
    
    // GiveUpButton
    @objc func giveUpButtonPressed() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    // BackButton
    @objc func backButtonPressed() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - SendVerifyCode
    private func sendVerificationCode() {
        
        guard let email = emailTextField.text else {
            return
        }
        
        viewModel.sendVerificationCode(email: email) { result in
            switch result {
            case.success(let response):
                DispatchQueue.main.async {
                    let vc = VerifyViewController()
                    vc.email = email
                    vc.isPasswordReset = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    print("Send verification code success: \(response)")
                }
            case.failure(let error):
                print("Send verification code failure: \(error)")
            }
        }
    }
}
