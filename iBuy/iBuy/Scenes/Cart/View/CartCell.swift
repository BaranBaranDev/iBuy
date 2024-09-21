//
//  CartCell.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import UIKit

final class CartCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    private lazy var productImageView: UIImageView = {
        ImageFactory.build(
            contentMode: .scaleAspectFit
        )
    }()
    
    private lazy var productNameLabel: UILabel = {
        LabelFactory.build()
    }()
    
    private lazy var productPriceLabel: UILabel = {
        LabelFactory.build()
    }()
    
    private lazy var labelStackView: UIStackView = {
        StackViewFactory.build(
            views: [productNameLabel, productPriceLabel],
            axis: .vertical,
            alignment: .center,
            spacing: 8
        )
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
}
// MARK: - Setup
private extension CartCell {
    func setup(){
        backgroundColor = .systemBackground
        addSubview(productImageView)
        addSubview(labelStackView)
    }
}
  // MARK: - Layout
private extension CartCell {
    func layout(){
        productImageView.snp.makeConstraints { make in
            make.leading.equalTo(contentView.snp.leadingMargin)
            make.centerY.equalToSuperview()
            make.height.equalTo(CGFloat.screenHeight / 2)
            make.width.equalTo(CGFloat.screenWidth / 2)
            
        }
        labelStackView.snp.makeConstraints { make in
            make.leading.equalTo(productImageView.snp.trailing).offset(16)
            make.centerY.equalToSuperview()
        }
    }
}
// MARK: - Configure
extension CartCell {
    public func configure(with product: ProductDatabase){
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            productNameLabel.text = product.name
            
            let priceText = NSMutableAttributedString(
                string: "$",
                attributes: [.font: UIFont.boldSystemFont(ofSize: 23)]
            )
            priceText.append(NSAttributedString(string: String(product.price)))
            productPriceLabel.attributedText = priceText

            productImageView.sd_setImage(with: URL(string: product.url ?? ""))
        }
    }
}
