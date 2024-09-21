//
//  HomePresenter.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//


import UIKit

// MARK: - HomePresentationLogic
protocol HomePresentationLogic {
    func presentFetchFeatures(_ response: HomeModels.FetchFeatures.Response)
    func presentFetchProducts(_ response: HomeModels.FetchProducts.Response)
}

// MARK: - HomePresenter
final class HomePresenter {
    
    //MARK: Public Properties
    weak var controller: HomeDisplayLogic?
    
}

// MARK: - HomePresenter: HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
    func presentFetchFeatures(_ response: HomeModels.FetchFeatures.Response) {
        let viewModel = HomeModels.FetchFeatures.ViewModel(features: response.features)
        controller?.displayFetchFeatures(viewModel)
    }
    
    func presentFetchProducts(_ response: HomeModels.FetchProducts.Response) {
        let viewModel = HomeModels.FetchProducts.ViewModel(products: response.products)
        controller?.displayFetchProducts(viewModel)
    }
}
