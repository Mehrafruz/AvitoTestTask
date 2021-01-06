//
//  PromotionType.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

struct PromotionType: Codable{
    let status: String
    let result: Result
    
    struct Result: Codable {
        let title: String
        let actionTitle: String
        let selectedActionTitle: String
        let list: [List]
    }
    
    struct List: Codable {
        let id: String
        let title: String
        let description: String?
        let icon: Icon
        let price: String
        let isSelected: Bool
        
        struct Icon: Codable {
            var iconUrl: String?
            
            enum CodingKeys: String, CodingKey {
                case iconUrl = "52x52"
            }
        }
    }
}
