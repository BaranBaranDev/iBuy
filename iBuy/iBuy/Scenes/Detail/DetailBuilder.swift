//
//  DetailBuilder.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//


import Foundation


enum DetailBuilder {
    static func build(selectedProduct: ProductResponse) -> DetailViewController {
        let service = CoreDataService()
        let worker = DetailWorker(service: service)
        let presenter = DetailPresenter()
        let interactor = DetailInteractor(presenter: presenter, worker: worker)
        let vc = DetailViewController(interactor: interactor, selectedProduct: selectedProduct)
        
        presenter.controller = vc
        return vc
        
    }
}

