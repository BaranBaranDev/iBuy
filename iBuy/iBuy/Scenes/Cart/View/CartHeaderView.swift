//
//  CartHeaderView.swift
//  iBuy
//
//  Created by Baran Baran on 15.09.2024.
//

import UIKit

final class CartHeaderView: UICollectionReusableView {
    
    // MARK: - UI Elements
    private lazy var totalAmountLabel: UILabel = {
        LabelFactory.build(
            font: .customFont(weight: .bold, size: 25),
            textAlignment: .center
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
}

// MARK: - Setup
private extension CartHeaderView {
    func setup() {
        addSubview(totalAmountLabel)
    }
}

// MARK: - Layout
private extension CartHeaderView {
    func layout() {
        totalAmountLabel.snp.makeConstraints { make in
            make.edges.equalToSuperview().inset(16)
        }
    }
}
// MARK: - Configure
extension CartHeaderView {
    public func configure(totalAmount: Double) {
        totalAmountLabel.text = "Your cart total: $\(totalAmount)"
    }
}
