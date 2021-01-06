//
//  PromotionInteractor.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

final class PromotionInteractor {
    private let networkManager: NetworkManagerDescription
	weak var output: PromotionInteractorOutput?
    
    init(networkManager: NetworkManagerDescription) {
        self.networkManager = networkManager
    }
}

extension PromotionInteractor: PromotionInteractorInput {
    func loadPromotionType() {
        networkManager.currentPromotion() { [weak self] (result) in
            DispatchQueue.main.async {
                switch result {
                case .success(let currentPromotion):
                    self?.output?.didLoadCurrentPromotion(currentPromotion: currentPromotion)
                case .failure(let error):
                    self?.output?.didFail(with: error)
                }
            }
        }
    }
    
}
