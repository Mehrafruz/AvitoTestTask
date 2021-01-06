//
//  PromotionHeaderCollectionReusableView.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

struct PromotionCollectionReusableViewModel {
    let title: String
}


class PromotionHeaderCollectionReusableView: UICollectionReusableView {
    static let identifier = "PromotionHeaderCollectionReusableView"
    private let titleLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setup() {
        titleLabel.textAlignment = .left
        titleLabel.font = UIFont(name:"Lato-Bold", size: 26)
        titleLabel.textColor = ColorPalette.black
        titleLabel.numberOfLines = 2
        titleLabel.lineBreakMode = .byClipping
        addSubview(titleLabel)
    }
    
    
    override func layoutSubviews() {
        super.layoutSubviews()
        titleLabel.frame = CGRect(x: bounds.minX+20, y: bounds.minY, width: bounds.width-40, height: bounds.height)
    }
    
    public func configure(with model: PromotionCollectionReusableViewModel){
        titleLabel.text = model.title
        
    }
    
}
