//
//  PromotionContainer.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class PromotionContainer {
    let input: PromotionModuleInput
	let viewController: UIViewController
	private(set) weak var router: PromotionRouterInput!

	class func assemble(with context: PromotionContext) -> PromotionContainer {
        let router = PromotionRouter()
        let interactor = PromotionInteractor(networkManager: NetworkManager.shared)
        let presenter = PromotionPresenter(router: router, interactor: interactor)
		let viewController = PromotionViewController(output: presenter)

        presenter.view = viewController 
		presenter.moduleOutput = context.moduleOutput

		interactor.output = presenter
        router.viewController = viewController
        

        return PromotionContainer(view: viewController, input: presenter, router: router)
	}

    private init(view: UIViewController, input: PromotionModuleInput, router: PromotionRouterInput) {
		self.viewController = view
        self.input = input
		self.router = router
	}
}

struct PromotionContext {
	weak var moduleOutput: PromotionModuleOutput?
}
