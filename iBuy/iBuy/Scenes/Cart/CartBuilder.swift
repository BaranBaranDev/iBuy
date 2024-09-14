//
//  CartBuilder.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//


import Foundation


enum CartBuilder {
    static func build() -> CartViewController {
        let worker = CartWorker()
        let presenter = CartPresenter()
        let router = CartRouter()
        let interactor = CartInteractor(presenter: presenter, worker: worker)
        let vc = CartViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
        
    }
}

