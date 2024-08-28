//
//  HomeBuilder.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.
//


import Foundation


enum HomeBuilder {
    static func build() -> HomeViewController {
        let service = FirebaseService()
        let worker = HomeWorker(service: service)
        let presenter = HomePresenter()
        let router = HomeRouter()
        let interactor = HomeInteractor(presenter: presenter, worker: worker)
        let vc = HomeViewController(interactor: interactor, router: router)
        
        //viewController referansı burada ayarlanıyor
        presenter.controller = vc
        router.controller = vc
      
        
        return vc
        
    }
}

