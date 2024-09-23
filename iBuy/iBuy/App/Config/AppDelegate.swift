//
//  AppDelegate.swift
//  iBuy
//
//  Created by Baran Baran on 14.08.2024.

import UIKit
import CoreData
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    
    // MARK: - Application Lifecycle
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        configureFirebase()
        configureWindow()
        configureSDWebImageCache()
        
        return true
    }
    
    // MARK: - Firebase Configuration
    fileprivate func configureFirebase() {
        FirebaseApp.configure()
    }
    
    // MARK: - Window Setup
    fileprivate func configureWindow() {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        window?.rootViewController = MainVC()
    }
    
    // MARK: - Cache Configuration
    fileprivate func configureSDWebImageCache() {
        CacheManager.shared.configureCache(countLimit: 20, totalCostLimit: 50 * 1024 * 1024)

    }

}

