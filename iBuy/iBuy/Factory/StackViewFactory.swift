//
//  StackViewFactory.swift
//  iBuy
//
//  Created by Baran Baran on 31.08.2024.
//

import UIKit

struct StackViewFactory {
    static func build(
        views: [UIView],
        axis: NSLayoutConstraint.Axis,
        alignment: UIStackView.Alignment = .fill,
        distribution: UIStackView.Distribution = .fill,
        spacing: CGFloat = 0
    ) -> UIStackView {
        let stackView = UIStackView(arrangedSubviews: views)
        stackView.axis = axis
        stackView.alignment = alignment
        stackView.distribution = distribution
        stackView.spacing = spacing
        
        return stackView
    }
}
