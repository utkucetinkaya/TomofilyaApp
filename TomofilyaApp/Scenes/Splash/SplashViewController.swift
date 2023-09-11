//
//  SplashViewController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 6.08.2023.
//

import UIKit

class SplashViewController: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet private weak var logoImageView: UIImageView!
    @IBOutlet private weak var textLabel: UILabel!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
            self.animateLogoAndShowLabel()
        }
        goToOnboarding()
    }
    
    // MARK: - Function
    
    func goToOnboarding() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
            let vc = OnboardingViewController()
            self.navigationController?.setViewControllers([vc], animated: true)
        }
    }
     func animateLogoAndShowLabel() {
         UIView.animate(withDuration: 0.8, animations: {
             
             self.logoImageView.transform = CGAffineTransform(translationX: 0, y: -60)
         }) { _ in
             
             let fullText = "Selam 👋\nTomofilya’ya Hoş Geldin!"
             let attributedText = NSMutableAttributedString(string: fullText)
             let newlineRange = (fullText as NSString).range(of: "\n")
             if newlineRange.location != NSNotFound {
                 attributedText.setAttributes([.font: UIFont.poppinsRegular(size: 16)], range: NSRange(location: newlineRange.location + 1, length: fullText.count - newlineRange.location - 1))
             }
             
             self.textLabel.attributedText = attributedText
             self.textLabel.textAlignment = .center
             self.textLabel.isHidden = false
         }
     }
}
