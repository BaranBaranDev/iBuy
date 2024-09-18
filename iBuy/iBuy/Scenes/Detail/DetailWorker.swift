//
//  DetailWorker.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//

import CoreData

// MARK: - DetailDataWorker Protocol
protocol DetailDataWorker {
    func saveProduct(name: String, price: Int, url: String)
}

// MARK: - DetailWorker
final class DetailWorker {
    //MARK: Dependencies
    private let service: CoreDataService
    
    // MARK:  İnitialization
    init(service: CoreDataService) {
        self.service = service
    }
}

// MARK: - DetailWorker: DetailDataWorker
extension DetailWorker: DetailDataWorker {
    func saveProduct(name: String, price: Int, url: String){
        let product = ProductDatabase(context: service.context)
        product.name = name
        product.price = Int64(price)
        product.url = url
        
        service.saveContext()
    }
}
