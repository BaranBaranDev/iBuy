//
//  CartWorker.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.
//

import Foundation
import CoreData

// MARK: - CartDataWorker Protocol
protocol CartDataWorker {
    func fetchProducts(completion: @escaping (Result <[ProductDatabase], Error>) -> Void)
    func deleteProduct(_ product: ProductDatabase, completion: @escaping (Result<Void, Error>) -> Void)
}

// MARK: - CartWorker
final class CartWorker {
    //MARK: Dependencies
    private let service: CoreDataService
    
    // MARK: İnitialization
    init(service: CoreDataService) {
        self.service = service
    }
}

// MARK: - CartWorker: CartDataWorker
extension CartWorker: CartDataWorker {
    func fetchProducts(completion: @escaping (Result <[ProductDatabase], Error>) -> Void) {
        let request: NSFetchRequest<ProductDatabase> = ProductDatabase.fetchRequest()
        do {
            let products = try service.context.fetch(request)
            print("Fetched products count: \(products.count)")  // Verinin geldiğini kontrol ediyoruz.
            completion(.success(products))
        } catch let error {
            print("Error fetching products: \(error.localizedDescription)")
            completion(.failure(error))
        }
    }
    
    func deleteProduct(_ product: ProductDatabase, completion: @escaping (Result<Void, Error>) -> Void) {
          service.context.delete(product)
          do {
              try service.context.save()
              completion(.success(()))
          } catch let error {
              completion(.failure(error))
          }
      }
}
