//
//  HeaderView.swift
//  e-commerceApp
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
         let lbl = UILabel()
         lbl.textColor = .label
         lbl.textAlignment = .left
         lbl.adjustsFontForContentSizeCategory = true
         lbl.font = UIFont.boldSystemFont(ofSize: 30)
         lbl.adjustsFontSizeToFitWidth = true
         return lbl
     }()
    
    // MARK:  İnitialization
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
