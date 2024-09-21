//
//  CartPresenter.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import Foundation

// MARK: - CartPresentationLogic
protocol CartPresentationLogic {
    func presentFetchedProducts(_ response: CartModels.FetchProducts.Response)
    func presentDeletedProduct(_ response: CartModels.DeleteProduct.Response)
}

// MARK: - CartPresenter
final class CartPresenter {
    weak var controller: CartDisplayLogic?
}

// MARK: - CartPresenter: CartPresentationLogic
extension CartPresenter: CartPresentationLogic {
    func presentFetchedProducts(_ response: CartModels.FetchProducts.Response) {
        if let error = response.error {
            print("Error presenting products: \(error.localizedDescription)")
        } else {
            print("Products presented: \(response.products.count) products")
        }
        let viewModel = CartModels.FetchProducts.ViewModel(
            products: response.products,
            errorMessage: response.error?.localizedDescription
        )
        controller?.displayFetchedProducts(viewModel)
    }
    
    func presentDeletedProduct(_ response: CartModels.DeleteProduct.Response) {
        let message: String
        if response.success {
            message = "Product successfully deleted."
        } else {
            message = "Failed to delete product: \(response.error?.localizedDescription ?? "Unknown error")"
        }
        let viewModel = CartModels.DeleteProduct.ViewModel(message: message)
        controller?.displayDeleteProductResult(viewModel)
        
    }
    
    
}
