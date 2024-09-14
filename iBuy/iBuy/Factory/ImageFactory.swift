//
//  ImageFactory.swift
//  iBuy
//
//  Created by Baran Baran on 29.08.2024.
//

import UIKit

struct ImageFactory {
    static func build(
        imageName: String? = nil,
        contentMode: UIView.ContentMode = .scaleAspectFill,
        tintColor: UIColor? = nil,
        isUserInteractionEnabled: Bool = false
    ) -> UIImageView {
        let imageView = UIImageView()
        imageView.tintColor = tintColor
        imageView.contentMode = contentMode
        imageView.clipsToBounds = true
        imageView.isUserInteractionEnabled = isUserInteractionEnabled
        
        if let imageName = imageName {
            imageView.image = UIImage(systemName: imageName)
        }
        return imageView
    }
}
