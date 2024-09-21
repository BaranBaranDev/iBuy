//
//  FeatureCell.swift
//  e-commerceApp
//
//  Created by Baran Baran on 20.08.2024.
//

import UIKit
import SnapKit
import SDWebImage

final class FeatureCell: UICollectionViewCell {
    
    
    // MARK: - UI Elements
    
    private lazy var backgroundImageView: UIImageView = {
        ImageFactory.build(contentMode: .scaleAspectFit)
    }()
    
    private lazy var titleLabel: UILabel = {
        LabelFactory.build(
            font: .customFont(weight: .bold, size: 30)
        )
    }()
    
    private lazy var detailButton: UIButton = {
        ButtonFactory.build(
            title: "Learn More",
            titleColor: .white,
            backgroundColor: .systemBlue,
            cornerRadius: 16
        )
    }()
    
    
    private lazy var buyButton: UIButton = {
        ButtonFactory.build(
            title: "Buy",
            titleColor: .systemBlue,
            backgroundColor: .clear,
            cornerRadius: 16,
            borderWidth: 2,
            borderColor: .systemBlue
        )
    }()
    
    
    private lazy var buttonStackView: UIStackView = {
        StackViewFactory.build(
            views: [detailButton,buyButton],
            axis: .horizontal,
            distribution: .equalCentering,
            spacing: 8
        )
    }()
    
    
    
    // MARK: - İnitialization
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.backgroundColor = .systemBackground
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundImageView.frame = contentView.bounds
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        backgroundImageView.image = nil
        titleLabel.text = nil
    }
}
// MARK: - Setup
private extension FeatureCell {
    func setup() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(buttonStackView)
        backgroundImageView.addSubview(titleLabel)
        
    }
}

// MARK: - Layout
private extension FeatureCell {
    func layout() {
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottomMargin)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(buttonStackView.snp.top).offset(-8)
            make.centerX.equalToSuperview()
        }
        
        detailButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
        buyButton.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(35)
        }
        
    }
}
// MARK: - Configure
extension FeatureCell {
    
    public func configure(with model: FeatureResponse?) {
        guard let model = model else { return } // != nil
        
        configureBackgroundImage(model)
        configureTitleLabel(model)
        
    }
    
    private func configureBackgroundImage(_ model: FeatureResponse){
        guard let url =  URL(string: model.url) else { return }
        backgroundImageView.sd_setImage(with: url)
    }
    
    private func configureTitleLabel(_ model: FeatureResponse){
        titleLabel.text = model.name
    }
    
}
