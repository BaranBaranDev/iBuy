//
//  HomeWorker.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//

import UIKit


protocol HomeNetworkWorker {
    func fetchFeatures(completion: @escaping (Result<[FeatureResponse], ServiceError>) -> Void)
}

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
}
