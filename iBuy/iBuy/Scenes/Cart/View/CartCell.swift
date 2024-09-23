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
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productImageView.image = nil
        productNameLabel.text = nil
        productPriceLabel.text = nil
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
        configureImage(from: product.url ?? "")
        configureLabel(product)
        
    }
    
    @MainActor
    private func configureImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        CacheManager.shared.loadImage(from: url) { [weak self] image in
            guard let self = self else { return }
            
            if let image = image {
                self.productImageView.image = image
                
            } else {
                self.productImageView.image = nil
            }
        }
    }
    
    @MainActor
    private func configureLabel(_ product: ProductDatabase){
        productNameLabel.text = product.name
        
        let priceText = NSMutableAttributedString(
            string: "$",
            attributes: [.font: UIFont.boldSystemFont(ofSize: 23)]
        )
        priceText.append(NSAttributedString(string: String(product.price)))
        productPriceLabel.attributedText = priceText
    }
}
