//
//  PasswordResetViewController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 8.09.2023.
//

import UIKit

class PasswordResetViewController: UIViewController {

    // MARK: - Outlets
    
    @IBOutlet private weak var backButton: UIButton!
    @IBOutlet private weak var newPasswordTextField: UITextField!
    @IBOutlet private weak var newPasswordAgainTextField: UITextField!
    @IBOutlet private weak var changePasswordButton: UIButton!
    @IBOutlet private weak var giveUpButton: UIButton!
    
    // MARK: - Variables
    
    var viewModel = LogicViewModel()
    var email: String?
    var code: String?
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setUI()
        
    }

    private func setUI() {
        
        // Add Target
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        giveUpButton.addTarget(self, action: #selector(giveUpButtonTapped), for: .touchUpInside)
        changePasswordButton.addTarget(self, action: #selector(passwordReset), for: .touchUpInside)
        
        // Radius - Border
        changePasswordButton.setCorner(radius: 20)
        newPasswordTextField.setCorner(radius: 22)
        newPasswordTextField.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        newPasswordAgainTextField.setCorner(radius: 22)
        newPasswordAgainTextField.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
    }
    
    // MARK: - Objc Func

    @objc func backButtonTapped() {
        let vc = VerifyViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func giveUpButtonTapped() {
        let vc = LoginViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func passwordReset() {
        guard let newPassword = newPasswordTextField.text,
              let confirmPassword = newPasswordAgainTextField.text else {
            return
        }
        
        if newPassword == confirmPassword {
            viewModel.forgetPassword(email: self.email ?? "", code: self.code ?? "", newPassword: newPassword) { result in
                switch result {
                case.success(let response):
                    DispatchQueue.main.async {
                        print("Password reset success: \(response)")
                        let vc = LoginViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                case.failure(let error):
                    print("Password reset failure: \(error)")
                    
                }
            }
        } else {
            print("New password and confirm password do not match")
        }
    }
}
