//
//  HomeInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.


import Foundation

// MARK: - HomeBusinessLogic
protocol HomeBusinessLogic {
    func fetchFeatures(request: HomeModels.FetchFeatures.Request)
    func fetchProducts(request: HomeModels.FetchProducts.Request)
}

// MARK: - HomeDataStore
protocol HomeDataStore {
    var selectedProduct: ProductResponse? { get set }
}

// MARK: - HomeInteractor
final class HomeInteractor: HomeDataStore {
    
    // MARK: - DataStore Logic
    var selectedProduct: ProductResponse?
    
 
    //MARK: Dependencies
    private let presenter: HomePresentationLogic
    private let worker: HomeWorker
    
    init(presenter: HomePresentationLogic, worker: HomeWorker) {
        self.presenter = presenter
        self.worker = worker
    }

}


// MARK: - HomeInteractor: HomeBusinessLogic
extension HomeInteractor: HomeBusinessLogic {
    func fetchFeatures(request: HomeModels.FetchFeatures.Request) {
        worker.fetchFeatures { [weak self] result in
            guard let self = self else { return }
            switch result {
    
            case .success(let features):
                presenter.present(response: HomeModels.FetchFeatures.Response(features: features))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchProducts(request: HomeModels.FetchProducts.Request) {
        worker.fetchProducts(with: request.categoryName) { [weak self] result in
            guard let self = self else { return }
            switch result {
                
            case .success(let products):
                presenter.present(response: HomeModels.FetchProducts.Response(products: products))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


