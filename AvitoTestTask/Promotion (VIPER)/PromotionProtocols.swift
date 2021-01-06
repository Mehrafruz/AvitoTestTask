//
//  PromotionProtocols.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

protocol PromotionModuleInput {
	var moduleOutput: PromotionModuleOutput? { get }
}

protocol PromotionModuleOutput: class {
}

protocol PromotionViewInput: class {
    func update()
}

protocol PromotionViewOutput: class {
    var itemsCount: Int { get }
    func item(at index: Int) -> PromotionCollectionViewCellModel
    func header () -> PromotionCollectionReusableViewModel
    func didSelectItem(at index: Int) -> PromotionCollectionViewCellModel
    func getSelectedPromotion() -> PromotionCollectionViewAlertModel
}

protocol PromotionInteractorInput: class {
    func loadPromotionType()
}

protocol PromotionInteractorOutput: class {
    func didLoadCurrentPromotion(currentPromotion: PromotionType?)
    func didFail(with error: Error)
}

protocol PromotionRouterInput: class {
    func show(_ error: Error)
}



