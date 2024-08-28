//
//  HomeInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.


import Foundation

// MARK: - HomeBusinessLogic
protocol HomeBusinessLogic {
    func fetchFeatures(request: HomeModels.FetchFeatures.Request)
}


// MARK: - HomeInteractor
final class HomeInteractor {
 
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
                presenter.presentFetchFeatures(response: HomeModels.FetchFeatures.Response(features: features))
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}


