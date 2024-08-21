//
//  CGFloat+Ext.swift
//  e-commerceApp
//
//  Created by Baran Baran on 19.08.2024.
//

import UIKit

// MARK: - CGFloat Extension for Screen Dimensions
extension CGFloat {
    
    /// The width of the screen.
    static var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }

    /// The height of the screen.
    static var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
}
