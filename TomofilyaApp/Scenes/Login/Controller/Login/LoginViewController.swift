//
//  LoginViewController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 10.08.2023.
//

import UIKit
import GoogleSignIn

class LoginViewController: UIViewController {
    
    // MARK: - Outlets
    @IBOutlet private weak var checkBoxLabel: UILabel!
    @IBOutlet private weak var checkBoxButton: UIButton!
    @IBOutlet private weak var segmentOutlet: UISegmentedControl!
    @IBOutlet private weak var nameSurnameTextField: UITextField!
    @IBOutlet private weak var emailTextField: UITextField!
    @IBOutlet private weak var passwordTextField: UITextField!
    @IBOutlet private weak var signUpButton: UIButton!
    @IBOutlet private weak var loginButton: UIButton!
    @IBOutlet private weak var googleButton: UIButton!
    @IBOutlet private weak var appleButton: UIButton!
    @IBOutlet private weak var agreementTextView: UITextView!
    @IBOutlet private weak var forgetPasswordButton: UIButton!
    
    // MARK: - PageTypeEnum
    
    private enum PageType {
        case login
        case register
    }
    
    // MARK: - Variables
    
    var viewModel = LogicViewModel()
    
    private var currentPageType: PageType = .login {
        didSet {
            setupViewsFor(pageType: currentPageType)
        }
    }
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViewsFor(pageType: .login)
        setCustomizeUI()
        registerAgreementTextView()
        textFieldDelegate()
        addTargetButtonRegister()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        self.navigationController?.isNavigationBarHidden = true
    }
    
    // MARK: - SetUI
    private func setCustomizeUI() {
        
        // Button
        signUpButton.setCorner(radius: 20)
        loginButton.setCorner(radius: 20)
        
        appleButton.setCorner(radius: 24)
        appleButton.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        
        googleButton.setCorner(radius: 24)
        googleButton.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        
        // TextField
        nameSurnameTextField.setCorner(radius: 24)
        nameSurnameTextField.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        
        emailTextField.setCorner(radius: 24)
        emailTextField.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        
        passwordTextField.setCorner(radius: 24)
        passwordTextField.setBorder(width: 0.6, color: UIColor(hex: "#B5B5B5"))
        
    }
    
    // MARK: - SetPageType
    
    private func setupViewsFor(pageType: PageType) {
        nameSurnameTextField.isHidden = pageType == .register
        signUpButton.isHidden = pageType == .register
        loginButton.isHidden = pageType == .login
        forgetPasswordButton.isHidden = pageType == .login
        checkBoxLabel.isHidden = pageType == .register
        checkBoxButton.isHidden = pageType == .register
        agreementTextView.isHidden = pageType == .register
    }
    
    // MARK: - Did Login
    
    func didLogin() {
        self.viewModel.didLogin = { success in
            if success {
                DispatchQueue.main.async {
                    let vc = HomeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }
        }
    }
    
    // MARK: - SetDelegate
    
    private func textFieldDelegate() {
        nameSurnameTextField.delegate = self
        emailTextField.delegate = self
        passwordTextField.delegate = self
      
    }
    
    // MARK: - RegisterAddTargetButton
    
    private func addTargetButtonRegister() {
        
        signUpButton.addTarget(self, action: #selector(register), for: .touchUpInside)
        loginButton.addTarget(self, action: #selector(login), for: .touchUpInside)
        googleButton.addTarget(self, action: #selector(googleLogin), for: .touchUpInside)
        forgetPasswordButton.addTarget(self, action: #selector(forgetPassword), for: .touchUpInside)
    }
    
    // MARK: - RegisterTextView
    
    private func registerAgreementTextView() {
        let text = "Uygulamaya üye olarak; Üyelik Sözleşmesi’ni ve Kişisel Veriler ile İlgili Aydınlatma Metni’ni okuduğunuzu ve kabul ettiğinizi onaylamaktasınız."
      
        let attributedString = NSMutableAttributedString(string: text)
        
        attributedString.addAttribute(.foregroundColor, value: UIColor.white, range: NSRange(location: 0, length: text.count))
        
        let range1 = (text as NSString).range(of: "Üyelik Sözleşmesi")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#E42E0E"), range: range1)
        attributedString.addAttribute(.link, value: "https://tomofilyastorage.blob.core.windows.net/contracts/Tomofilya_Uyelik_Sozlesmesi.pdf", range: range1)
      
        let range2 = (text as NSString).range(of: "Aydınlatma Metni")
        attributedString.addAttribute(.foregroundColor, value: UIColor(hex: "#E42E0E"), range: range2)
        attributedString.addAttribute(.link, value: "https://tomofilyastorage.blob.core.windows.net/contracts/Tomofilya_KVKK_Aydinlatma_Metni.pdf", range: range2)
        
        agreementTextView.attributedText = attributedString
        agreementTextView.isUserInteractionEnabled = true
        agreementTextView.isEditable = false
        agreementTextView.isScrollEnabled = false
    }
    
    // MARK: - Send VerifyCode
    
    private func sendVerifyCode(email: String) {
        viewModel.sendVerificationCode(email: email) { result in
            switch result {
            case.success(let response):
                print("Send verification code success: \(response)")
            case.failure(let error):
                print("Send verification code failure: \(error)")
            }
        }
    }
    
    // MARK: - Objc Func Login
    
    @objc func login() {
        guard let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        viewModel.login(email: email, password: password) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Login success: \(response)")
                    let vc = HomeViewController()
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            case .failure(let error):
                print("Login failure: \(error)")
            }
        }
    }
    
    // MARK: - Objc Func GoogleLogin
    
    @objc func googleLogin() {
        
        GIDSignIn.sharedInstance.signIn(withPresenting: self) { signInResult, error in
            guard error == nil else {
                print("Google Sign-In hata: \(error!.localizedDescription)")
                return
            }
            
            guard let signInResult = signInResult else {
                print("No sign-in result present")
                return
            }
            
            signInResult.user.refreshTokensIfNeeded { user, error in
                guard error == nil else {
                    print("Failed to refresh tokens: \(error!.localizedDescription)")
                    return
                }
                
                guard let user = user else {
                    print("No user present after token refresh")
                    return
                }
                if let idTokenValue = user.idToken {
                   let idTokenString = idTokenValue.tokenString
                    let platform = SocialPlatform.google
                    
                    let request = SocialLoginRequest(token: idTokenString, platform: platform.rawValue)
                    self.viewModel.socialLogin(request: request)
                    self.didLogin()
                }
            }
        }
    }

    // MARK: - Objc Func ForgotPassword

    @objc func forgetPassword() {
        let vc = ForgotPasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }

    // MARK: - Objc Func Register
    
    @objc func register() {
        guard let fullName = nameSurnameTextField.text,
              let email = emailTextField.text,
              let password = passwordTextField.text else {
            return
        }
        
        viewModel.register(fullName: fullName, email: email, password: password) { result in
            switch result {
            case.success(let response):
                
                DispatchQueue.main.async {
                    print("Register Success: \(response)")
                    let vc = VerifyViewController()
                    vc.email = email
                    vc.isRegister = true
                    self.navigationController?.pushViewController(vc, animated: true)
                    self.sendVerifyCode(email: email)
                }
                
            case.failure(let error):
                print("Register failure: \(error)")
            }
        }
    }
 
    // MARK: - SegmentAction
    
    @IBAction func segmentAction(_ sender: UISegmentedControl) {
        
        currentPageType = sender.selectedSegmentIndex == 0 ? .login : .register
    }
}

// MARK: - UITextFieldDelegate

extension LoginViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
          textField.resignFirstResponder()
          return true
    }
}
