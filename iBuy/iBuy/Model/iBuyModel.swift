//
//  iBuyModel.swift
//  iBuy
//
//  Created by Baran Baran on 23.08.2024.
//

import Foundation

// MARK: - iBuyModel
struct iBuyModel: Codable {
    let features: [FeatureResponse]
    let categories : [ProductResponse]
}

// MARK: - FeatureResponse
struct FeatureResponse: Codable {
    let name: String?
    let url: String
}

// MARK: - ProductsResponse
struct ProductResponse: Codable {
    let name: String
    let price: Int
    let url: String
}
