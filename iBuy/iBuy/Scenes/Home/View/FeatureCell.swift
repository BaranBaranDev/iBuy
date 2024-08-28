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
        let imageView = UIImageView(frame: contentView.bounds)
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        return imageView
    }()
    
    
    
    private lazy var titleLabel: UILabel = LabelFactory.build(
        text: nil,
        font: UIFont.boldSystemFont(ofSize: 30)
    )
    
    
    private lazy var detailButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Learn More", for: .normal)
        btn.tintColor = .white
        btn.backgroundColor = .systemBlue
        btn.layer.cornerRadius = 16
        return btn
    }()
    
    private lazy var buyButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Buy", for: .normal)
        btn.backgroundColor = .clear
        btn.layer.borderColor = UIColor.systemBlue.cgColor
        btn.layer.borderWidth = 2
        btn.layer.cornerRadius = 16
        btn.setTitleColor(.systemBlue, for: .normal)
        return btn
    }()
    
    
    
    private lazy var buttonStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [detailButton, buyButton])
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.distribution = .equalCentering
        return stackView
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

// MARK: - Setup & Layout
private extension FeatureCell {
    func setup() {
        addSubview(backgroundImageView)
        backgroundImageView.addSubview(buttonStackView)
        backgroundImageView.addSubview(titleLabel)
        
    }
    
    func layout() {
        buttonStackView.snp.makeConstraints { make in
            make.bottom.equalTo(backgroundImageView.snp.bottomMargin)
            make.centerX.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints { make in
            make.bottom.equalTo(buttonStackView.snp.topMargin)
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
    
    public func configure(for model: FeatureResponse?) {
        guard let model = model else { return } // != nil
        
        configureBackgroundImage(model)
        configureTitleLabel(model)
        
    }
    
    private func configureBackgroundImage(_ model: FeatureResponse){
        guard let url =  URL(string: model.url) else { return }
        backgroundImageView.sd_setImage(with: url)
    }
    
    private func configureTitleLabel(_ model: FeatureResponse){
        titleLabel.text = model.title
    }
    
}

#Preview {
    HomeBuilder.build()
}
