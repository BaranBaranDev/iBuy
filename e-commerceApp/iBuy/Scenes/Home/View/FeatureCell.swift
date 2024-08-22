//
//  FeatureCell.swift
//  e-commerceApp
//
//  Created by Baran Baran on 20.08.2024.
//

import UIKit

final class FeatureCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .purple
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

