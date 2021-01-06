//
//  PromotionRouter.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

final class PromotionRouter {
    weak var viewController: UIViewController?
}

extension PromotionRouter: PromotionRouterInput {
    
    func show(_ error: Error) {
        let message: String = (error as? NetworkError)?.errorDescription ?? error.localizedDescription
        let alertController = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        alertController.addAction(cancelAction)
        viewController?.present(alertController, animated: true, completion: nil)
    }

}
