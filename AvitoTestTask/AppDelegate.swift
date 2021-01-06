//
//  AppDelegate.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
    
        let context = PromotionContext()
        let container = PromotionContainer.assemble(with: context)
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController =  UINavigationController(rootViewController: container.viewController)
        window?.makeKeyAndVisible()
        
        return true
    }
    
   
}

