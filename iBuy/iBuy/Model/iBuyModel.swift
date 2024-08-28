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
}

// MARK: - FeatureResponse
struct FeatureResponse: Codable {
    let title: String?
    let url: String
}
