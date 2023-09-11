//
//  UIColor+Ext.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 22.08.2023.
//

import UIKit

// UIColor extension hex
extension UIColor {
    // Hex kodundan UIColor nesnesi oluşturan bir convenience initializer
    convenience init(hex: String, alpha: CGFloat = 1.0) {
        // Hex kodunun başında "#" varsa kaldır
        let hex = hex.hasPrefix("#") ? String(hex.dropFirst()) : hex
        // Hex kodunun uzunluğuna göre RGB değerlerini hesapla
        var rgb: UInt64 = 0
        var r, g, b: CGFloat
        switch hex.count {
        case 3: // Kısa format, örneğin "FFF"
            Scanner(string: hex).scanHexInt64(&rgb)
            r = CGFloat((rgb & 0xF00) >> 8) / 15.0
            g = CGFloat((rgb & 0x0F0) >> 4) / 15.0
            b = CGFloat(rgb & 0x00F) / 15.0
        case 6: // Uzun format, örneğin "FF0000"
            Scanner(string: hex).scanHexInt64(&rgb)
            r = CGFloat((rgb & 0xFF0000) >> 16) / 255.0
            g = CGFloat((rgb & 0x00FF00) >> 8) / 255.0
            b = CGFloat(rgb & 0x0000FF) / 255.0
        default: // Geçersiz format, varsayılan olarak siyah döndür
            r = 0.0
            g = 0.0
            b = 0.0
        }
        // UIColor nesnesini oluştur ve döndür
        self.init(red: r, green: g, blue: b, alpha: alpha)
    }
}
