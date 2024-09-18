//
//  UIViewController+Ext.swift
//  iBuy
//
//  Created by Baran Baran on 18.09.2024.
//

import UIKit

// MARK: - UIViewController Extension
extension UIViewController {
    func showErrorAlert(message: String, title: String = "Error") {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
}

