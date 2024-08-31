//
//  ButtonFactory.swift
//  iBuy
//
//  Created by Baran Baran on 24.08.2024.

import UIKit

struct ButtonFactory {
    static func build(
        title: String? = nil,
        titleColor: UIColor = .label,
        backgroundColor: UIColor = .clear,
        cornerRadius: CGFloat = 0,
        borderWidth: CGFloat = 0,
        borderColor: UIColor? = nil,
        font: UIFont? = nil,
        imageName: String? = nil
    ) -> UIButton {
        let button = UIButton(type: .system)
        
        button.setTitleColor(titleColor, for: .normal)
        button.backgroundColor = backgroundColor
        button.layer.cornerRadius = cornerRadius
        button.layer.borderWidth = borderWidth
        
        
        if let title = title {
            button.setTitle(title, for: .normal)
        }
        
        
        if let borderColor = borderColor {
            button.layer.borderColor = borderColor.cgColor
        }
        
        if let font = font {
            button.titleLabel?.font = font
        }
        
        if let imageName = imageName {
            button.setImage(UIImage(systemName: imageName), for: .normal)
        }
        
        return button
    }
}
