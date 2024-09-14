//
//  DetailModels.swift
//  iBuy
//
//  Created by Baran Baran on 3.09.2024.
//


import UIKit

enum DetailModels {
  // MARK: Use cases
  
  enum SaveProduct {
      struct Request {
          let productName: String
          let productPrice: Int
          let productUrl: String
      }

      struct Response {
          let success: Bool
      }

      struct ViewModel {
          let successMessage: String
      }

  }
}
