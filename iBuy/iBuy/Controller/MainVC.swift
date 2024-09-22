//
//  MainVC.swift
//  e-commerceApp
//
//  Created by Baran Baran on 14.08.2024.
//

import UIKit

final class MainVC: UITabBarController {
    
    // MARK:  Properties
    private lazy var homeVC: UIViewController = createViewController(rootVC: HomeBuilder.build(), title: "Home", image: "house")
    private lazy var cartVC: UIViewController = createViewController(rootVC: CartBuilder.build(), title: "My Cart", image: "cart")

    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
}

// MARK: - Setup Methods
private extension MainVC {
    func setup() {
        viewControllers = [homeVC, cartVC]
        customizeTabBar()
        customizeNavigationBar()
    }
    
    func createViewController(rootVC: UIViewController, title: String, image: String) -> UIViewController {
        let controller = UINavigationController(rootViewController: rootVC)
        controller.tabBarItem.title = title
        controller.tabBarItem.image = UIImage(systemName: image)
        rootVC.title = title
        return controller
    }
    
    func customizeTabBar() {
        let appearance = UITabBarAppearance()
        appearance.backgroundColor = .clear
        tabBar.standardAppearance = appearance
        tabBar.scrollEdgeAppearance = appearance
    }
    
    func customizeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .systemBackground
        appearance.titleTextAttributes = [.foregroundColor: UIColor.black]
        
        UINavigationBar.appearance().prefersLargeTitles = true
        UINavigationBar.appearance().standardAppearance = appearance
        UINavigationBar.appearance().scrollEdgeAppearance = appearance
    }
}

// MARK: - Preview
#Preview {
    MainVC()
}
