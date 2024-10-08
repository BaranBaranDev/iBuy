//
//  HeaderView.swift
//  iBuy
//
//  Created by Baran Baran on 21.08.2024.
//

import UIKit
import SnapKit
final class HomeHeaderView: UICollectionReusableView {
    
    // MARK: Properties
    public var headerText: String? {
        didSet {
            headerTitle.text = headerText ?? ""
        }
    }
    
    
    // MARK:  UI Elements
     private let headerTitle: UILabel = {
         LabelFactory.build(
            font: .customFont(weight: .demiBold, size: 25),
            textAlignment: .left,
            textColor: .label
         )
     }()
    
    // MARK:  İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        headerTitle.text = nil
    }
}

// MARK: - Setup
private extension HomeHeaderView {
    func setup() {
        addSubview(headerTitle)
    }
}
// MARK: - Layout
private extension HomeHeaderView {
    func layout() {
        headerTitle.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.leading.equalToSuperview().offset(8)
            make.trailing.equalToSuperview().inset(8)
        }
    }
}
