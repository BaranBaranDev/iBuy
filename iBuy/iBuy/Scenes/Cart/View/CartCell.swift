//
//  CartCell.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import UIKit

final class CartCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    private lazy var productNameLabel: UILabel = {
        LabelFactory.build(text: "Test name")
    }()
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
      
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    public func configure(_ product: ProductDatabase){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            productNameLabel.text = product.name
            
        }
    }
}

private extension CartCell {
    func setup(){
        contentView.backgroundColor = .systemBackground
        addSubview(productNameLabel)
    }
    
    func layout(){
        productNameLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
}
