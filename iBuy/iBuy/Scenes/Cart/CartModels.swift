//
//  CartModels.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//
// CartModels.swift
// iBuy
// Created by Baran Baran on 14.09.2024.

import UIKit

enum CartModels {
    // MARK: Use cases
    enum FetchProducts {
        struct Request {}

        struct Response {
            let products: [ProductDatabase]
            let error: Error? 
        }

        struct ViewModel {
            let products: [ProductDatabase]
            let errorMessage: String?
        }
    }
}
