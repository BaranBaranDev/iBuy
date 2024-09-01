//
//  HomeWorker.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//

import UIKit
import FirebaseFirestore

// MARK: - HomeNetworkWorker Protocol
protocol HomeNetworkWorker {
    func fetchFeatures(completion: @escaping (Result<[FeatureResponse], ServiceError>) -> Void)
    func fetchProducts(with categoryName: String,completion: @escaping (Result<[ProductResponse], ServiceError>) -> Void)
}

// MARK: - HomeWorker
final class HomeWorker {
    
    //MARK: Dependencies
    private let service: FirebaseService
    
    // MARK:  İnitialization
    init(service: FirebaseService) {
        self.service = service
    }
}

// MARK: - HomeWorker: HomeNetworkWorker

extension HomeWorker: HomeNetworkWorker {
    func fetchFeatures(completion: @escaping (Result<[FeatureResponse], ServiceError>) -> Void) {
        service.fetchData(collectionName: "features", completion: completion)
    }
    
    func fetchProducts(with categoryName: String, completion: @escaping (Result<[ProductResponse], ServiceError>) -> Void) {
        service.fetchData(collectionName: categoryName, completion: completion)
    }
    
}
