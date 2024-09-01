//
//  HomeModels.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//

import Foundation


enum HomeModels {

    // MARK: - Fetch Features Use Case
    enum FetchFeatures {
        struct Request {}
    
        struct Response {
            var features: [FeatureResponse]
        }

        struct ViewModel {
            var features: [FeatureResponse]
        }
    }
    
    // MARK: - Fetch Products Use Case
    enum FetchProducts {
        struct Request {
            var categoryName: String
        }
        
        struct Response {
            var products: [ProductResponse]
        }
        
        struct ViewModel {
            var products: [ProductResponse]
        }
    }
}
