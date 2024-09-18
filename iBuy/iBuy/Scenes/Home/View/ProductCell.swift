//
//  ProductCell.swift
//  e-commerceApp
//
//  Created by Baran Baran on 20.08.2024.
//

import UIKit

final class ProductCell: UICollectionViewCell {
    
    // MARK: - UI Elements
    
    private lazy var productImageView: UIImageView = {
        return ImageFactory.build()
    }()
    
    private lazy var productName: UILabel = {
        return LabelFactory.build(
            font: UIFont.boldSystemFont(ofSize: 18)
        )
    }()
    
    private lazy var productPrice: UILabel = {
        return LabelFactory.build()
    }()
    
    private lazy var productStackView: UIStackView = {
        return StackViewFactory.build(
            views: [productImageView,productName,productPrice],
            axis: .vertical
        )
    }()
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        productName.text = nil
        productPrice.text = nil
        productImageView.image = nil
    }
}

// MARK: - Setup
private extension ProductCell {
    func setup() {
        backgroundColor = .systemBackground
        addSubview(productStackView)
    }
}

  // MARK: - Layout
private extension ProductCell {
    func layout() {
        productStackView.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(8)
        }
    }
}
// MARK: - Configure
extension ProductCell {
    public func configure(with product: ProductResponse?) {
        guard let product = product else { return }
        configureProductImage(product)
        configureProductLabel(product)
    }
    
    private func configureProductImage(_ product: ProductResponse){
        guard let url =  URL(string: product.url) else { return }
        productImageView.sd_setImage(with: url)
    }
    
    private func configureProductLabel(_ product: ProductResponse) {
        productName.text = product.name
        
        // Price text with a bold, larger dollar sign
        let priceText = "$\(product.price)"
        let attributedText = NSMutableAttributedString(
            string: priceText,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 16)
            ])
        
        // Making the dollar sign more prominent
        attributedText.addAttributes([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18),
        ], range: NSMakeRange(0, 1))
        
        productPrice.attributedText = attributedText
    }
}

#Preview {
    HomeBuilder.build()
}

