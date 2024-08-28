//
//  HomeModels.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//

import UIKit

// MARK:  HomeModels
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
}
