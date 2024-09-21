//
//  CartInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.



import Foundation

// MARK: - CartBusinessLogic
protocol CartBusinessLogic {
    func fetchProducts(_ request: CartModels.FetchProducts.Request)
    func deleteProduct(_ request: CartModels.DeleteProduct.Request)
}

// MARK: - CartInteractor
final class CartInteractor {
    
    //MARK: Dependencies
    private let presenter: CartPresentationLogic
    private let worker: CartWorker
    
    //MARK: İnitialization
    init(presenter: CartPresentationLogic, worker: CartWorker) {
        self.presenter = presenter
        self.worker = worker
    }
}

// MARK: - CartInteractor: CartBusinessLogic
extension CartInteractor: CartBusinessLogic {
    func fetchProducts(_ request: CartModels.FetchProducts.Request) {
        worker.fetchProducts { [ weak self ] result in
            guard let self = self else { return }
            switch result {

            case .success(let products):
                let response = CartModels.FetchProducts.Response(products: products, error: nil)
                self.presenter.presentFetchedProducts(response)
            case .failure(let error):
                let response = CartModels.FetchProducts.Response(products: [], error: error)
                self.presenter.presentFetchedProducts(response)
            }
        }
    }
    
    func deleteProduct(_ request: CartModels.DeleteProduct.Request) {
        worker.deleteProduct(request.product) { [weak self] result in
            guard let self = self else { return }

            switch result {
            case .success:
                let response = CartModels.DeleteProduct.Response(success: true, error: nil)
                self.presenter.presentDeletedProduct(response)
            case .failure(let error):
                let response = CartModels.DeleteProduct.Response(success: false, error: error)
                self.presenter.presentDeletedProduct(response)
            }
        }
    }
}


