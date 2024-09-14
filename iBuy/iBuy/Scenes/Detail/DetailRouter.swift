//
//  DetailRouter.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.



import UIKit

protocol DetailRoutingLogic {
  
}


final class DetailRouter:  DetailDataPassing {
    
  weak var controller: DetailViewController?
  var dataStore: DetailDataStore?

}



extension DetailRouter: DetailRoutingLogic {
    
}
