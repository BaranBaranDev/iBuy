//
//  CartBuilder.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//


import Foundation


enum CartBuilder {
    static func build() -> CartViewController {
        let service = CoreDataService()
        let worker = CartWorker(service: service)
        let presenter = CartPresenter()
        let interactor = CartInteractor(presenter: presenter, worker: worker)
        let vc = CartViewController(interactor: interactor)

        presenter.controller = vc
        return vc
        
    }
}

