//
//  NetworkManager.swift
//  AvitoTestTask
//
//  Created by Мехрафруз on 06.01.2021.
//  Copyright © 2021 Мехрафруз. All rights reserved.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case emptyData
    
    var errorDescription: String {
        switch self {
        case .invalidURL:
            return "invalid url!!"
        case .emptyData:
            return "no data!!"
        }
    }
}

protocol NetworkManagerDescription: AnyObject {
    func currentPromotion (completion: @escaping (Result<PromotionType, Error>) -> Void)
}

final class NetworkManager: NetworkManagerDescription {
    static let shared: NetworkManagerDescription = NetworkManager()
    
    private init() {}
    
    func currentPromotion (completion: @escaping (Result<PromotionType, Error>) -> Void) {
        
        guard let path = Bundle.main.path(forResource: "result", ofType: "json") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: URL(fileURLWithPath: path)) { (data, response, error) in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, !data.isEmpty else {
                completion(.failure(NetworkError.emptyData))
                return
            }
            
            let decoder = JSONDecoder()
            
            do {
                let currentPromotion = try decoder.decode(PromotionType.self, from: data)
                completion(.success(currentPromotion))
            } catch let error {
                completion(.failure(error))
            }
        }.resume()
    }
}





