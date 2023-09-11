//
//  NSObject+Ext.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 7.08.2023.
//

import Foundation

extension NSObject {
    class var nameOfClass: String {
        return String(describing: self)
    }
}
