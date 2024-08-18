//
//  HomeRouter.swift
//  e-commerceApp
//
//  Created by Baran Baran on 18.08.2024.



import UIKit

protocol HomeRoutingLogic {
  
}

protocol HomeDataPassing {
  var dataStore: HomeDataStore? { get }
}



final class HomeRouter:  HomeDataPassing {
    
  weak var controller: HomeViewController?
  var dataStore: HomeDataStore?

}



extension HomeRouter: HomeRoutingLogic {
    
}
