//
//  ProductView.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//

import UIKit

// MARK: - ProductViewDelegate
protocol ProductViewDelegate: AnyObject {
    func didTappedAddToCartButton()
}

// MARK: - ProductView
final class ProductView: UIView {
    
    // MARK:  Properties
    weak var delegate: ProductViewDelegate?
    
    // MARK: - UI Elements
    private lazy var productImageView: UIImageView = {
        ImageFactory.build(
            contentMode: .scaleAspectFit
        )
    }()
    
    private lazy var productNameLabel: UILabel = {
        LabelFactory.build(
            font: .customFont(weight: .bold, size: 30),
            textAlignment: .center
        )
    }()
    
    private lazy var productPriceLabel: UILabel = {
        LabelFactory.build()
    }()
    
    private lazy var labelStackView: UIStackView = {
        StackViewFactory.build(
            views: [productNameLabel, productPriceLabel],
            axis: .vertical,
            spacing: 8
        )
    }()
    
    private lazy var cartButton: UIButton = {
        let button = ButtonFactory.build(
            title: "Add to Cart",
            titleColor: .white,
            backgroundColor: .systemBlue,
            cornerRadius: 20,
            font: .customFont(weight: .bold, size: 20)
        )
        button.addTarget(self, action: #selector(cartButtonTapped), for: .touchUpInside)
        return button
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
private extension ProductView {
    func setup() {
        backgroundColor = .systemBackground
        addSubviewsFromExt(productImageView,labelStackView,cartButton)
    }
}

// MARK: - Layout
private extension ProductView {
    func layout() {
        productImageView.snp.makeConstraints { make in
            make.top.equalTo(self.snp.topMargin)
            make.trailing.equalTo(self.snp.trailingMargin)
            make.leading.equalTo(self.snp.leadingMargin)
            make.height.equalTo(CGFloat.screenHeight / 2)
        }
        
        labelStackView.snp.makeConstraints { make in
            make.top.equalTo(productImageView.snp.bottomMargin)
            make.trailing.equalTo(productImageView.snp.trailing)
            make.leading.equalTo(productImageView.snp.leading)
        }
        
        cartButton.snp.makeConstraints { make in
            make.top.equalTo(labelStackView.snp.bottomMargin).offset(16)
            make.centerX.equalToSuperview()
            make.height.equalTo(50)
            make.width.equalTo(CGFloat.screenWidth * 0.80)
        }
    }
}

// MARK: - Actions
private extension ProductView {
    @objc func cartButtonTapped() {
        delegate?.didTappedAddToCartButton()
    }
}

// MARK: - Configure
extension ProductView {
    public func configure(with product: ProductResponse?) {
        guard let product = product else { return }

        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.configureLabel(for: product)
            if let url = URL(string: product.url) {
                self.productImageView.sd_setImage(with: url)
            }
        }
    }
    
    private func configureLabel(for product: ProductResponse) {
        productNameLabel.text = product.name
        productPriceLabel.attributedText = formatPriceText(for: Double(product.price))
    }

    private func formatPriceText(for price: Double) -> NSAttributedString {
        let priceText = "$\(price)"
        let attributedText = NSMutableAttributedString(
            string: priceText,
            attributes: [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20)
            ]
        )
        
        attributedText.addAttributes([
            NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 24),
        ], range: NSMakeRange(0, 1))
        
        return attributedText
    }
}
