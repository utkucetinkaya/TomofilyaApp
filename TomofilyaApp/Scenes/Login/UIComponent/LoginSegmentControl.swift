//
//  LoginSegmentControl.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 24.08.2023.
//

import UIKit

class SegmentedControl: UISegmentedControl {
    
    override func layoutSubviews(){
        super.layoutSubviews()
        
        setBorder(width: 1, color: UIColor(hex: "#E42E0E"))
        let segmentStringSelected: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        let segmentStringHighlited: [NSAttributedString.Key : Any] = [
            NSAttributedString.Key.foregroundColor : UIColor.white
        ]
        
        setTitleTextAttributes(segmentStringHighlited, for: .normal)
        setTitleTextAttributes(segmentStringSelected, for: .selected)
        setTitleTextAttributes(segmentStringHighlited, for: .highlighted)
        
        layer.masksToBounds = true
        
        if #available(iOS 13.0, *) {
            selectedSegmentTintColor = UIColor(hex: "#E42E0E")
        } else {
            tintColor = UIColor(hex: "#E42E0E")
        }
        
        backgroundColor = UIColor(hex: "#0F0F0F")
        
        let maskedCorners: CACornerMask = [.layerMinXMinYCorner, .layerMinXMaxYCorner, .layerMaxXMinYCorner, .layerMaxXMaxYCorner]
        clipsToBounds = true
        
        setCorner(radius: 24)
        layer.maskedCorners = maskedCorners
        
        let foregroundIndex = numberOfSegments
        if subviews.indices.contains(foregroundIndex),
           let foregroundImageView = subviews[foregroundIndex] as? UIImageView {
            foregroundImageView.image = UIImage()
            foregroundImageView.clipsToBounds = true
            foregroundImageView.layer.masksToBounds = true
            foregroundImageView.backgroundColor = UIColor(hex: "#E42E0E")
            
            foregroundImageView.layer.cornerRadius = bounds.height / 2 + 5
            foregroundImageView.layer.maskedCorners = maskedCorners
        }
    }
    
    override func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return false
    }
}
