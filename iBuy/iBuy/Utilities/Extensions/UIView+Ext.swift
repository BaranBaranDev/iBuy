//
//  UIView+Ext.swift
//  iBuy
//
//  Created by Baran Baran on 18.09.2024.
//

import UIKit

// MARK: - UIView Extension for Adding Multiple Subviews
extension UIView {
    
    // MARK:  Add Multiple Subviews
    func addSubviewsFromExt(_ views: UIView...) {
        views.forEach { [weak self] view in
            guard let self = self else { return }
            self.addSubview(view)
        }
    }
}
