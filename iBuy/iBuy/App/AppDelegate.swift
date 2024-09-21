//
//  AppDelegate.swift
//  e-commerceApp
//
//  Created by Baran Baran on 14.08.2024.
//

import UIKit
import CoreData
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
  
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        FirebaseApp.configure()
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = MainVC()
  
        return true
    }
}

