//
//  AppDelegate.swift
//  e-commerceApp
//
//  Created by Baran Baran on 14.08.2024.
//
//
//  AppDelegate.swift
//  e-commerceApp
//
//  Created by Baran Baran on 14.08.2024.
//

import UIKit
import CoreData
import FirebaseCore
import SDWebImage

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
    
    // MARK: - SDWebImage Cache Configuration
    fileprivate func configureSDWebImageCache() {
        let cache = SDImageCache.shared
        cache.config.maxMemoryCost = 50 * 1024 * 1024    // Max 50 MB memory
        cache.config.maxDiskSize = 50 * 1024 * 1024      // Max 50 MB disk space
        cache.config.shouldCacheImagesInMemory = true    // Cache images in memory
        cache.config.diskCacheExpireType = .accessDate   // Expire cache based on last access date
        cache.config.maxDiskAge = 60 * 60 * 24 * 7       // 1 week disk cache expiration
    }

}

