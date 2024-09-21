//
//  HomeRouter.swift
//  iBuy
//
//  Created by Baran Baran on 28.08.2024.



import UIKit

// MARK: - HomeRoutingLogic
protocol HomeRoutingLogic {
  func routeDetail()
}

// MARK: - HomeDataPassing
protocol HomeDataPassing {
    var dataStore: HomeDataStore? { get }
}


// MARK: - HomeRouter Class
final class HomeRouter: HomeDataPassing {
    
  // MARK: Properties
  var dataStore: HomeDataStore?
  weak var controller: HomeViewController?
}


// MARK: - HomeRouter: HomeRoutingLogic
extension HomeRouter: HomeRoutingLogic {
    func routeDetail() {
        guard let selectedProduct = dataStore?.selectedProduct else { return }
        
        let vc = DetailBuilder.build(selectedProduct: selectedProduct)
        controller?.navigationController?.pushViewController(vc, animated: true)
    }
}
