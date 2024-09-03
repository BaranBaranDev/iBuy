//
//  DetailBuilder.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//


import Foundation


enum DetailBuilder {
    static func build() -> DetailViewController {
        let worker = DetailWorker()
        let presenter = DetailPresenter()
        let router = DetailRouter()
        let interactor = DetailInteractor(presenter: presenter, worker: worker)
        let vc = DetailViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
        router.dataStore = interactor
        
        return vc
        
    }
}

