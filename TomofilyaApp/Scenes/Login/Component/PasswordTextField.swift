//
//  PasswordTextField.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 23.08.2023.
//

import UIKit

@IBDesignable class PassWordTextField: UITextField {
    
    @IBInspectable var hideEye: String = "eyeoff"
    @IBInspectable var showEye: String = "eyeoff"
    
    static let eyeContainerBounds = CGSize(width: 50, height: 50)
    static let eyeSelectorBounds = CGSize(width: 30, height: 30)
    static let eyeSelectorOrigin = CGPoint(x: 10, y: 10)
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.setup()
    }
    
    override var isSecureTextEntry: Bool {
        didSet {
            DispatchQueue.main.async {
                self.eyeSelector.setImage(self.eyeImage, for: .normal)
            }
        }
    }
    
    private var eyeImage: UIImage? {
        self.isSecureTextEntry ? UIImage(named: hideEye) : UIImage(named: showEye)
    }
    
    private var eyeContainer: UIView = {
        let view = UIView(frame: CGRect(origin: .zero, size: eyeContainerBounds))
        return view
    }()
    
    private var eyeSelector: UIButton = {
        let button = UIButton(frame: CGRect(origin: eyeSelectorOrigin, size: eyeSelectorBounds))
        return button
    }()
    
    private func setup() {
        self.eyeSelector.addTarget(self, action: #selector(showHidePassword), for: .touchUpInside)
        self.eyeContainer.addSubview(eyeSelector)
        self.rightView = eyeContainer
        self.rightViewMode = .always
        
        self.isSecureTextEntry = true
    }
    
    @objc private func showHidePassword() {
        self.isSecureTextEntry = !self.isSecureTextEntry
    }
}
