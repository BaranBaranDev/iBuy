//
//  iBuyModel.swift
//  iBuy
//
//  Created by Baran Baran on 23.08.2024.
//

import Foundation

// MARK: - iBuyModel
struct iBuyModel {
    let features: [FeatureResponse]
}

// MARK: - FeatureResponse
struct FeatureResponse {
    let title: String
    let imageUrl: String
}
