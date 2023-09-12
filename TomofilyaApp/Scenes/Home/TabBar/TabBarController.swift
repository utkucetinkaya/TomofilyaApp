//
//  TabBarController.swift
//  TomofilyaApp
//
//  Created by Utku Çetinkaya on 11.09.2023.
//

import UIKit

class TabBarController: UITabBarController {
    
    // MARK: - Properties
    
    let tabBarItems = [
        TabBarItem(viewController: HomeViewController(), icon: UIImage(named: "home"), title: "Ana Sayfa"),
        TabBarItem(viewController: MessageViewController(), icon: UIImage(named: "message"), title: "Mesajlar"),
        TabBarItem(viewController: MyGarageViewController(), icon: UIImage(named: "my_garage"), title: "Garajım"),
        TabBarItem(viewController: ShoppingBagViewController(), icon: UIImage(named: "shopping_bag"), title: "Sepetim"),
        TabBarItem(viewController: ProfileViewController(), icon: UIImage(named: "profile"), title: "Profil")
    ]
    
    // MARK: - Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = true
        navigationItem.hidesBackButton = true
        setupTabBarItems()
    }
    
    // MARK: - SetupTabBarItems
    private func setupTabBarItems() {
      
        var navControllers = [UINavigationController]()
        
        for item in tabBarItems {
            let nav = UINavigationController(rootViewController: item.viewController)
            nav.tabBarItem.title = item.title
            nav.tabBarItem.image = item.icon
            
            if let font = UIFont(name: "Poppins-Regular", size: 8) {
                nav.tabBarItem.setTitleTextAttributes([.font: font], for: .normal)
            }
            navControllers.append(nav)
        }
        
        self.setViewControllers(navControllers, animated: true)
        
    }
    
    // MARK: - Layoutcycle
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        layoutTabBar()
        setupTabBar()
    }
    
    // MARK: - LayoutTabBar
    private func layoutTabBar() {
        
        let tabHeight: CGFloat = 93
        let tabWidth = self.view.frame.size.width
        
        var tabFrame = self.tabBar.frame
        tabFrame.size.height = tabHeight
        tabFrame.size.width = tabWidth
        tabFrame.origin.y = (self.view.frame.size.height - tabHeight) + 5
        tabFrame.origin.x = (self.view.frame.size.width - tabWidth) / 2
        self.tabBar.frame = tabFrame
    }
    
    // MARK: - SetTabBar
    private func setupTabBar() {
        
        self.tabBar.barTintColor = .black
        self.tabBar.alpha = 0.8
        self.tabBar.tintColor = UIColor(hex: "#E42E0E")
        self.tabBar.unselectedItemTintColor = .white
        
        let borderLayer = CAShapeLayer()
        let maskLayer = CAShapeLayer()
        
        maskLayer.path = UIBezierPath(roundedRect: self.tabBar.bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: 30, height: 0)).cgPath
        
        borderLayer.path = maskLayer.path
        borderLayer.lineWidth = 0.6
        borderLayer.strokeColor = UIColor(hex: "#B5B5B5").cgColor
        borderLayer.fillColor = UIColor.clear.cgColor
        borderLayer.frame = self.tabBar.bounds
        
        self.tabBar.layer.mask = maskLayer
        self.tabBar.layer.addSublayer(borderLayer)
        
    }
}
