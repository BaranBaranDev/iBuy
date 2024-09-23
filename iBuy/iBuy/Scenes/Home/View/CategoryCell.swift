//
//  CategoryCell.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//

import UIKit
import SnapKit


final class CategoryCell: UICollectionViewCell {
    
    // MARK: - UI Elements

    private let categoryImageView: UIImageView = {
         ImageFactory.build(
            contentMode: .scaleAspectFit,
            tintColor: .black
        )
    }()

    private let categoryLabel: UILabel = {
         LabelFactory.build()
    }()

    private lazy var categoryStackView: UIStackView = {
         StackViewFactory.build(
            views: [categoryImageView,categoryLabel],
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
        assertionFailure("init(coder:) has not been implemented")
        return nil
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        categoryLabel.text = nil
        categoryImageView.image = nil
    }
}

// MARK: - Setup
private extension CategoryCell {
    func setup(){
        backgroundColor = .systemBackground
        addSubview(categoryStackView)
    }
}

// MARK: - Layout
private extension CategoryCell {
    func layout() {
        categoryStackView.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        categoryImageView.snp.makeConstraints { make in
            make.height.equalTo(100)
            make.width.equalTo(150)
        }
    
    }
}

// MARK: - Configure
extension CategoryCell{
    public func configure(with category: Category) {
        categoryImageView.image = UIImage(systemName: category.iconName)
        categoryLabel.text = category.name
    }
}
