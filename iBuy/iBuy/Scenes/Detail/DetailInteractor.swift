//
//  DetailInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.



import Foundation

// MARK: - DetailBusinessLogic
protocol DetailBusinessLogic {
    func saveProduct(name: String, price: Int, url: String)
}

// MARK: - DetailInteractor
final class DetailInteractor {
    
    //MARK: Dependencies
    private let presenter: DetailPresentationLogic
    private let worker: DetailDataWorker
    
    init(presenter: DetailPresentationLogic, worker: DetailDataWorker) {
        self.presenter = presenter
        self.worker = worker
    }
    
}

// MARK: - DetailInteractor: DetailBusinessLogic
extension DetailInteractor: DetailBusinessLogic {
    func saveProduct(name: String, price: Int, url: String) {
        let request = DetailModels.SaveProduct.Request(productName: name, productPrice: price, productUrl: url)
        worker.saveProduct(name: request.productName , price: request.productPrice, url: request.productUrl)
        
        let response = DetailModels.SaveProduct.Response(success: true)
        presenter.present(response: response)
    }
    
    
}


