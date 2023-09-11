//
//  UIFont+Ext.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 6.08.2023.
//

import UIKit

extension UIFont {
    static func poppinsRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Poppins-Regular", size: size) ?? UIFont.systemFont(ofSize: size)
    }
}
