//
//  DetailInteractor.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.



import Foundation

protocol DetailBusinessLogic {
    
    
}

protocol DetailDataStore {
    //var name: String { get set }
    
}

final class DetailInteractor: DetailDataStore {
    
    // Data store logic
    //var name: String = ""
    
    //MARK: Dependencies
    private let presenter: DetailPresentationLogic
    private let worker: DetailWorker
    
    init(presenter: DetailPresentationLogic, worker: DetailWorker) {
        self.presenter = presenter
        self.worker = worker
    }

}


extension DetailInteractor: DetailBusinessLogic {
    
}


