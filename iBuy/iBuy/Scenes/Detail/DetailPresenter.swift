//
//  DetailPresenter.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//


import UIKit

// MARK: - DetailPresentationLogic
protocol DetailPresentationLogic {
    func presentSaveProduct(response: DetailModels.SaveProduct.Response)
}


// MARK: - DetailPresenter
final class DetailPresenter {
  weak var controller: DetailDisplayLogic?
  
}

// MARK: - DetailPresenter: DetailPresentationLogic
extension DetailPresenter: DetailPresentationLogic {
    func presentSaveProduct(response: DetailModels.SaveProduct.Response) {
        let viewModel = DetailModels.SaveProduct.ViewModel(successMessage: "Saved Database")
        controller?.display(viewModel: viewModel)
    }
}
