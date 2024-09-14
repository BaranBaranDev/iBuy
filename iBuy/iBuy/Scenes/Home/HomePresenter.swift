//
//  HomePresenter.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//


import UIKit

// MARK: - HomePresentationLogic
protocol HomePresentationLogic {
    func present(response: HomeModels.FetchFeatures.Response)
    func present(response: HomeModels.FetchProducts.Response)
}

// MARK: - HomePresenter
final class HomePresenter {
    
    //MARK: Public Properties
    weak var controller: HomeDisplayLogic?
    
}


// MARK: - HomePresenter: HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
    func present(response: HomeModels.FetchFeatures.Response) {
        controller?.display(viewModel: HomeModels.FetchFeatures.ViewModel(features: response.features))
    }
    
    func present(response: HomeModels.FetchProducts.Response) {
        controller?.display(viewModel: HomeModels.FetchProducts.ViewModel(products: response.products))
    }
}
