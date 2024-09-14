//
//  DetailPresenter.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//


import UIKit

protocol DetailPresentationLogic {
    func present(response: DetailModels.SaveProduct.Response)
}



final class DetailPresenter {
  weak var controller: DetailDisplayLogic?
  
  
}



extension DetailPresenter: DetailPresentationLogic {
    func present(response: DetailModels.SaveProduct.Response) {
        let viewModel = DetailModels.SaveProduct.ViewModel(successMessage: "Saved Database")
        controller?.display(viewModel: viewModel)
    }
}
