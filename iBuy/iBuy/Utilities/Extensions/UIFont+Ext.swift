//
//  UIFont+Ext.swift
//  iBuy
//
//  Created by Baran Baran on 21.09.2024.
//

import UIKit

// MARK: - UIFont Extensions
extension UIFont {
    enum FontWeight: String {
        case regular = "AvenirNext-Regular"
        case bold = "AvenirNext-Bold"
        case demiBold = "AvenirNext-DemiBold"
    }
    
    static func customFont(weight: FontWeight, size: CGFloat) -> UIFont {
        return UIFont(name: weight.rawValue, size: size) ?? .systemFont(ofSize: size)
    }
}

