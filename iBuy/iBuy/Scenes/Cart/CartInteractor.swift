//
//  CartInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.



import Foundation

// MARK: - CartBusinessLogic
protocol CartBusinessLogic {
    func fetchProducts(request: CartModels.FetchProducts.Request)
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
    func fetchProducts(request: CartModels.FetchProducts.Request) {
        worker.fetchProducts { [ weak self ] result in
            guard let self = self else { return }
            switch result {

            case .success(let products):
                self.presenter.present(response: CartModels.FetchProducts.Response(products: products, error: nil))
            case .failure(let error):
                self.presenter.present(response: CartModels.FetchProducts.Response(products: [], error: error))
            }
        }
    }
}


