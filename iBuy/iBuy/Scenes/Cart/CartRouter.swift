//
//  CartRouter.swift
//  iBuy
//
//  Created by Baran Baran on 14.09.2024.



import UIKit

protocol CartRoutingLogic {
  
}

protocol CartDataPassing {
  var dataStore: CartDataStore? { get }
}



final class CartRouter:  CartDataPassing {
    
  weak var controller: CartViewController?
  var dataStore: CartDataStore?

}



extension CartRouter: CartRoutingLogic {
    
}
