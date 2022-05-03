//
//  TabBarController.swift
//  Cornerr
//
//  Created by Tony Chen on 5/2/22.
//

import UIKit

class CustomTabBarController: UITabBarController {
    
    private var allListings: [Listing] = []
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        
        self.tabBar.backgroundColor = .lightBlue
        self.tabBar.tintColor = .darkBlue
        self.tabBar.unselectedItemTintColor = .white
        
        let dummySimpleUser: SimpleUser = SimpleUser(id: 0, username: "tony123", contact: "123")
        
//        let dummyListings: [Listing] = [Listing(id: 0, unixTime: 1, title: "Manicure", category: "Beauty", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "Beaded Jewelry", category: "Crafts", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "Video Editing", category: "Tech", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "urmom", category: "Fashion", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "urmom", category: "Media", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "urmom", category: "Food", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "urmom", category: "Other", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: [])]
        
        let filters: [String] = ["Beauty", "Fashion", "Media", "Tech", "Crafts", "Food", "Other"]
        
        getAllListings()
        
        let homeViewController = HomeViewController(listings: allListings, filters: filters)
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
        
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        homeNavController.navigationBar.prefersLargeTitles = false

        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
        
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        profileNavController.navigationBar.prefersLargeTitles = false
        
        self.setViewControllers(([homeNavController, profileNavController]), animated: false)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func getAllListings() {
        NetworkManager.getAllListings() { listing in
            self.allListings = listing
        }
    }
    
}

