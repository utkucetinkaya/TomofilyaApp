//
//  UIView+Ext.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 23.08.2023.
//

import UIKit

extension UIView {
    
    // MARK: - CornerRadius
  func setCorner(radius: CGFloat) {
        layer.cornerRadius = radius
        clipsToBounds = true
    }
    
    // MARK: - Border
    func setBorder(width: CGFloat, color: UIColor) {
          layer.borderColor = color.cgColor
          layer.borderWidth = width
      }
}
