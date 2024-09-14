//
//  CartInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.



import Foundation

protocol CartBusinessLogic {
    
    
}

protocol CartDataStore {
    //var name: String { get set }
    
}

final class CartInteractor: CartDataStore {
    
    // Data store logic
    //var name: String = ""
    
    //MARK: Dependencies
    private var presenter: CartPresentationLogic?
    private var worker: CartWorker?
    
    init(presenter: CartPresentationLogic? = nil, worker: CartWorker? = nil) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension CartInteractor: CartBusinessLogic {
    
}


