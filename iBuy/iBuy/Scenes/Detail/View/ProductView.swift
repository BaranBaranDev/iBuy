//
//  ProductView.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//

import UIKit

final class ProductView: UIView {
    
    // MARK: - UI Elemanları
    private lazy var productImageView: UIImageView = {
        ImageFactory.build(
            imageName: "macbook",
            contentMode: .scaleAspectFit
        )
    }()
    
    private lazy var productNameLabel: UILabel = {
        LabelFactory.build(text: "Test name")
    }()
    
    private lazy var productPriceLabel: UILabel = {
        LabelFactory.build(text: "Test price")
    }()
    
    private lazy var labelStackView: UIStackView = {
        StackViewFactory.build(
            views: [productNameLabel, productPriceLabel],
            axis: .vertical
        )
    }()
    
    private lazy var cartButton: UIButton = {
        ButtonFactory.build(
            title: "Add to Cart",
            titleColor: .white,
            backgroundColor: .systemBlue,
            cornerRadius: 20
        )
    }()
    
    // MARK: - Başlatma
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - Setup
private extension ProductView {
    func setup() {
        backgroundColor = .clear
        addSubview(productImageView)
        addSubview(labelStackView)
        addSubview(cartButton)
    }
    
    // MARK: - Constraintler
    func setupConstraints() {
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
            make.height.equalTo(65)
            make.width.equalTo(150)
        }
    }
}

#Preview {
    DetailBuilder.build()
}
