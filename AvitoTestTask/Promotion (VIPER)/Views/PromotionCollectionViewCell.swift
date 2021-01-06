//
//  PromotionCollectionViewCell.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit



struct PromotionCollectionViewCellModel {
    let imageURL: String?
    let title: String
    let description: String?
    let price: String
    let checkMarkIsHidden: Bool
    let buttonIsActive: Bool
}

protocol ReusableViewCell: AnyObject {
    static var identifier: String { get }
}

final class PromotionCollectionViewCell: UICollectionViewCell {
    
    private let iconImageView = UIImageView()
    private var titleLabel = UILabel()
    private let descriptionLabel = UILabel()
    private let priceLabel = UILabel()
    public var checkMarkImageView = UIImageView()
    
    override var isHighlighted: Bool{
        didSet{
            self.contentView.backgroundColor = isHighlighted ? ColorPalette.highightGray : ColorPalette.lightGray
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupViews()
    }
    
    
    private func setupViews() {
        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 7.0
        
        [iconImageView, titleLabel, descriptionLabel, priceLabel, checkMarkImageView].forEach {
            contentView.addSubview($0)
        }
        setupLabel(label: titleLabel, fontName: "Lato-Bold", fontSize: 25, numberOfLines: 1)
        setupLabel(label: descriptionLabel, fontName: "Lato-Regular", fontSize: 16, numberOfLines: 4)
        setupLabel(label: priceLabel, fontName: "Lato-Bold", fontSize: 20, numberOfLines: 1)
        checkMarkImageView.image = UIImage(named: "checkmark")
        addConstraints()
    }
    
    private func setupLabel(label: UILabel, fontName: String, fontSize: CGFloat, numberOfLines: Int){
        label.font = UIFont(name: fontName, size: fontSize)
        label.textColor = ColorPalette.black
        label.numberOfLines = numberOfLines
        label.lineBreakMode = .byClipping
        label.textAlignment = .left
    }
    
    private func addConstraints(){
        [contentView, iconImageView, titleLabel, descriptionLabel, priceLabel, checkMarkImageView].forEach {
            ($0).translatesAutoresizingMaskIntoConstraints = false
        }
        
        
        NSLayoutConstraint.activate([
            iconImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            iconImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 15),
            iconImageView.widthAnchor.constraint(equalToConstant: 60),
            iconImageView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 15),
            titleLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 15),
            titleLabel.widthAnchor.constraint(equalToConstant: 0.5*UIScreen.main.bounds.width),
            titleLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
        NSLayoutConstraint.activate([
            checkMarkImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            checkMarkImageView.leftAnchor.constraint(equalTo: descriptionLabel.rightAnchor, constant: 5),
            checkMarkImageView.widthAnchor.constraint(equalToConstant: 25),
            checkMarkImageView.heightAnchor.constraint(equalToConstant: 25)
        ])
        
        NSLayoutConstraint.activate([
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            descriptionLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 15),
            descriptionLabel.widthAnchor.constraint(equalToConstant: 0.55*UIScreen.main.bounds.width),
        ])
        
        NSLayoutConstraint.activate([
            priceLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 10),
            priceLabel.leftAnchor.constraint(equalTo: iconImageView.rightAnchor, constant: 15),
            priceLabel.widthAnchor.constraint(equalToConstant: 0.5*UIScreen.main.bounds.width),
            priceLabel.heightAnchor.constraint(equalToConstant: 30)
        ])
        
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with model: PromotionCollectionViewCellModel) {
        guard let imageUrl = model.imageURL else {
            return
        }
        guard let description = model.description else {
            return
        }
        titleLabel.text = model.title
        descriptionLabel.text = description
        priceLabel.text = model.price
        iconImageView.download(from: imageUrl)
        checkMarkImageView.isHidden =  model.checkMarkIsHidden
    }
}

extension PromotionCollectionViewCell: ReusableViewCell {
    static var identifier: String {
        return String(describing: self)
    }
}

