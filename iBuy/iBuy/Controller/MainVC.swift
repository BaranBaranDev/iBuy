//
//  MainVC.swift
//  e-commerceApp
//
//  Created by Baran Baran on 14.08.2024.
//

import UIKit

final class MainVC: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Helpers

extension MainVC {
    private func setup() {
       
        // Create VC
        let homeVC = createViewController(rootVC: HomeBuilder.build(), title: "Home", image: "house")
        let cartVC = createViewController(rootVC: AppsVC(), title: "My Cart", image: "cart")
      
        
        // Add tabbar
        viewControllers = [homeVC, cartVC]
        
        // custom func
        customizeTabBar()
        customizeNavigationBar()
    }
    
    // Create UINavigationController for each VC
    private func createViewController(rootVC: UIViewController, title: String, image: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: rootVC)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        
     
        rootVC.title = title
        
        return controller
    }
    
   // Custom tabbar
    private func customizeTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundImage = UIImage()
        appearance.shadowImage = UIImage()
        appearance.backgroundColor = .clear
        
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    // Custom NavBar
    private func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().compactAppearance = appearance
        UINavigationBar.appearance().compactScrollEdgeAppearance = appearance
    }
}

// MARK: - VC



final class AppsVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemOrange
    }
}