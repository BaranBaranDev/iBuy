//
//  CartModels.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//
// CartModels.swift
// iBuy
// Created by Baran Baran on 14.09.2024.

import Foundation

enum CartModels {
    // MARK: Fetch Products Use cases
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
    
    // MARK: Delete Product Use cases
    enum DeleteProduct {
        struct Request {
            let product: ProductDatabase
        }
        struct Response {
            let success: Bool
            let error: Error?
        }
        struct ViewModel {
            let message: String
        }
    }
}
