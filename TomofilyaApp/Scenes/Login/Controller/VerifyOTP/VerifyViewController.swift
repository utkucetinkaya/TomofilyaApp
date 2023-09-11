//
//  VerifyViewController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 2.09.2023.
//

import UIKit

class VerifyViewController: UIViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var otpTextField1: UITextField!
    @IBOutlet private weak var otpTextField2: UITextField!
    @IBOutlet private weak var otpTextField3: UITextField!
    @IBOutlet private weak var otpTextField4: UITextField!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var timerLabel: UILabel!
    
    // MARK: - Variables
    
    var viewModel = LogicViewModel()
    var countdownTimer: Timer?
    var totalTime = 90
    var otpTextFields = [UITextField]()
    var selectedTextFieldIndex = 0
    var email: String?
    var isPasswordReset: Bool = false
    var isRegister: Bool = false
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
                
        setUI()
        textFieldDelegate()
        startTimer()
    }
    
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         
        self.navigationController?.isNavigationBarHidden = true
     }
    
    // MARK: - TextField Objc func
    
    @objc private func textDidChange(textField: UITextField) {
        
        let selectedTextField = otpTextFields.first(where: {$0.isFirstResponder})
        otpTextFields.forEach {$0.backgroundColor = .white}
        selectedTextField?.backgroundColor = .lightGray
        
        let text = textField.text
        if text?.count == 1 {
            switch textField {
            case otpTextField1:
                otpTextField2.becomeFirstResponder()
            case otpTextField2:
                otpTextField3.becomeFirstResponder()
            case otpTextField3:
                otpTextField4.becomeFirstResponder()
            case otpTextField4:
                otpTextField4.becomeFirstResponder()
            default:
                break
            }
        }
        
        if text?.count == 0 {
            switch textField {
            case otpTextField1:
                otpTextField1.becomeFirstResponder()
                
            case otpTextField2:
                otpTextField1.becomeFirstResponder()
                
            case otpTextField3:
                otpTextField2.becomeFirstResponder()
                
            case otpTextField4:
                otpTextField3.becomeFirstResponder()
            default:
                break
            }
        }
    }
    
    // MARK: -  Objc func Verify
    
    @objc func verify() {
        guard let code1 = otpTextField1.text,
              let code2 = otpTextField2.text,
              let code3 = otpTextField3.text,
              let code4 = otpTextField4.text else {
            return
        }
        
        let code = code1 + code2 + code3 + code4
        
        viewModel.verifyCode(email: self.email ?? "", code: code) { result in
            switch result {
            case .success(let response):
                DispatchQueue.main.async {
                    print("Verify success: \(response)")
                    if self.isPasswordReset {
                        let vc = PasswordResetViewController()
                        vc.email = self.email
                        vc.code = code
                        self.navigationController?.pushViewController(vc, animated: true)
                    } else if self.isRegister {
                        let vc = LoginViewController()
                        self.navigationController?.pushViewController(vc, animated: true)
                    }
                }
                
            case .failure(let error):
                print("Verify failure: \(error)")
            }
        }
    }
    
    // MARK: - Functions
    
    // Timer
    private func startTimer() {
        countdownTimer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in

            if self.totalTime > 0 {
                let minutes = self.totalTime / 60
                let seconds = self.totalTime % 60
                
                let minuteString = String(format: "%02d", minutes)
                let secondString = String(format: "%02d", seconds)
                
                self.timerLabel.text = "\(minuteString):\(secondString)"
                
                self.totalTime -= 1
            } else {
                self.timerLabel.text = "00:00"
                self.countdownTimer?.invalidate()
            }
        }
    }
    
    // TextField
    private func textFieldDelegate() {
        otpTextField1.delegate = self
        otpTextField2.delegate = self
        otpTextField3.delegate = self
        otpTextField4.delegate = self
    }
    
    // SetUI
    private func setUI() {
        
        otpTextField1.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otpTextField2.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otpTextField3.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        otpTextField4.addTarget(self, action: #selector(textDidChange), for: .editingChanged)
        sendButton.addTarget(self, action: #selector(verify), for: .touchUpInside)
        
        otpTextField1.setCorner(radius: 12)
        otpTextField2.setCorner(radius: 12)
        otpTextField3.setCorner(radius: 12)
        otpTextField4.setCorner(radius: 12)
        sendButton.setCorner(radius: 20)
        
        otpTextField1.becomeFirstResponder()
    }
    
    // MARK: - IBAction
    
    @IBAction func backButtonAction(_ sender: UIButton) {
        self.dismiss(animated: true) {
            let vc = LoginViewController()
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}

// MARK: - UITextFieldDelegate

extension VerifyViewController: UITextFieldDelegate {
    
    internal func textFieldDidBeginEditing(_ textField: UITextField) {
        textField.backgroundColor = .lightGray
    }
    
    internal func textFieldDidEndEditing(_ textField: UITextField) {
        textField.backgroundColor = .white
    }
}
