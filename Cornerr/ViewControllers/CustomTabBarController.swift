//
//  TabBarController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/2/22.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private var allListings: [Listing] = []
    private var currentUser: User!
    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        
        self.currentUser = user
        
        self.tabBar.backgroundColor = .lightBlue
        self.tabBar.tintColor = .darkBlue
        self.tabBar.unselectedItemTintColor = .white
        
        let homeViewController = HomeViewController()
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
        
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        homeNavController.navigationBar.prefersLargeTitles = false

        let profileViewController = ProfileViewController(user: currentUser)
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
        
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        profileNavController.navigationBar.prefersLargeTitles = false
        
        self.setViewControllers(([homeNavController, profileNavController]), animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

