//
//  HomePresenter.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//


import UIKit

// MARK: - HomePresentationLogic
protocol HomePresentationLogic {
    func presentFetchFeatures(response: HomeModels.FetchFeatures.Response)
}

// MARK: - HomePresenter
final class HomePresenter {
  weak var controller: HomeDisplayLogic?

}


// MARK: - HomePresenter: HomePresentationLogic
extension HomePresenter: HomePresentationLogic {
    func presentFetchFeatures(response: HomeModels.FetchFeatures.Response) {
        controller?.display(viewModel: HomeModels.FetchFeatures.ViewModel(features: response.features))
    }
}
