//
//  PromotionPresenter.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation
import UIKit

final class PromotionPresenter {
    weak var view: PromotionViewInput?
    weak var moduleOutput: PromotionModuleOutput?
    
    private let router: PromotionRouterInput
    private let interactor: PromotionInteractorInput

    private var promotionTypeArr: [PromotionType.Result] = []
    private var selectedItemForShowing = -1
    private var selectedRowForLogic = -1
    
    init(router: PromotionRouterInput, interactor: PromotionInteractorInput) {
        self.router = router
        self.interactor = interactor
    }
}

extension PromotionPresenter: PromotionModuleInput {
}

extension PromotionPresenter: PromotionViewOutput {
    
    var itemsCount: Int {
        return 2
    }
    
    func item(at index: Int) -> PromotionCollectionViewCellModel {
        if !promotionTypeArr.isEmpty{
            return PromotionCollectionViewCellModel(imageURL: promotionTypeArr[0].list[index].icon.iconUrl,
                                                    title: promotionTypeArr[0].list[index].title,
                                                    description: promotionTypeArr[0].list[index].description,
                                                    price: promotionTypeArr[0].list[index].price,
                                                    checkMarkIsHidden: true, buttonIsActive: false)
        }
        interactor.loadPromotionType()
        return PromotionCollectionViewCellModel(imageURL: "", title: "", description: "", price: "", checkMarkIsHidden: true, buttonIsActive: false)
    }
    
    
    func didSelectItem(at index: Int) -> PromotionCollectionViewCellModel {
        let iconUrl =  promotionTypeArr[0].list[index].icon.iconUrl
        let title = promotionTypeArr[0].list[index].title
        let description = promotionTypeArr[0].list[index].description
        let price = promotionTypeArr[0].list[index].price
        if selectedRowForLogic == -1 {
            selectedRowForLogic = index
            selectedItemForShowing = index
            if !promotionTypeArr.isEmpty{
                return PromotionCollectionViewCellModel(imageURL: iconUrl, title: title, description: description,
                                                        price: price, checkMarkIsHidden: false, buttonIsActive: true)
            }
        } else if selectedRowForLogic == index {
            selectedRowForLogic = -1
            if !promotionTypeArr.isEmpty{
                return PromotionCollectionViewCellModel(imageURL: iconUrl, title: title, description: description,
                                                        price: price, checkMarkIsHidden: true, buttonIsActive: false)
            }
        }
        if !promotionTypeArr.isEmpty{
            return PromotionCollectionViewCellModel(imageURL: iconUrl, title: title, description: description,
                                                    price: price, checkMarkIsHidden: true, buttonIsActive: true)
        }
        return PromotionCollectionViewCellModel(imageURL: "", title: "", description: "", price: "", checkMarkIsHidden: true, buttonIsActive: false)
    }
    

    func header() -> PromotionCollectionReusableViewModel {
        if !promotionTypeArr.isEmpty{
            return PromotionCollectionReusableViewModel(title: promotionTypeArr[0].title)
        } else {
            interactor.loadPromotionType()
        }
        return PromotionCollectionReusableViewModel(title: "")
    }
    
    func getSelectedPromotion() -> PromotionCollectionViewAlertModel {
        return PromotionCollectionViewAlertModel(title: promotionTypeArr[0].list[selectedItemForShowing].title, price: promotionTypeArr[0].list[selectedItemForShowing].price)
    }
    
}

extension PromotionPresenter: PromotionInteractorOutput {
    func didLoadCurrentPromotion(currentPromotion: PromotionType?) {
        if let currentPromotion = currentPromotion{
            promotionTypeArr.append(currentPromotion.result)
            view?.update()
        }
        
    }
    
    func didFail(with error: Error) {
        router.show(error)
        print ("did fail with \(error)")
    }
    
}
