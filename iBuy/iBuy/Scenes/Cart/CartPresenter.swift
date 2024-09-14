//
//  CartPresenter.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import Foundation

// MARK: - CartPresentationLogic
protocol CartPresentationLogic {
    func present(response: CartModels.FetchProducts.Response)
}


// MARK: - CartPresenter
final class CartPresenter {
  weak var controller: CartDisplayLogic?
}

// MARK: - CartPresenter: CartPresentationLogic
extension CartPresenter: CartPresentationLogic {
    func present(response: CartModels.FetchProducts.Response) {
        if let error = response.error {
            print("Error presenting products: \(error.localizedDescription)")  // Hata kontrolü
        } else {
            print("Products presented: \(response.products.count) products")  // Verinin iletildiğini kontrol ediyoruz
        }
        let viewModel = CartModels.FetchProducts.ViewModel(products: response.products, errorMessage: response.error?.localizedDescription)
        controller?.display(viewModel: viewModel)
    }
}
