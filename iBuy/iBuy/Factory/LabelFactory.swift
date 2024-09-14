//
//  LabelFactory.swift
//  iBuy
//
//  Created by Baran Baran on 24.08.2024.
//

import UIKit

struct LabelFactory {
    static func build(
        text: String? = nil,
        font: UIFont? = nil,
        textAlignment: NSTextAlignment = .center,
        backgroundColor: UIColor = .clear,
        textColor: UIColor = .label) -> UILabel {
            let label = UILabel()
            label.text = text
            label.font = font
            label.textAlignment = textAlignment
            label.backgroundColor = backgroundColor
            label.textColor = textColor
            return label
        }
}


