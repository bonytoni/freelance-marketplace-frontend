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
        
        let dummyListings: [Listing] = [Listing(id: 0, title: "Manicure", category: "Beauty", description: "Kirby is an action-platform video game series developed by HAL Laboratory and published by Nintendo. The series centers around the adventures of a pink hero named Kirby as he fights to protect and save his home on the distant Planet Popstar from a variety of threats. ", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, title: "Beaded Jewelry", category: "Crafts", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, title: "Video Editing", category: "Tech", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, title: "urmom", category: "Fashion", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, title: "urmom", category: "Media", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, title: "urmom", category: "Food", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, title: "urmom", category: "Other", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: [])]
        
        let filters: [String] = ["Beauty", "Fashion", "Media", "Tech", "Crafts", "Food", "Other"]
        
        getAllListings()
        
        let homeViewController = HomeViewController(listings: dummyListings, filters: filters)
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

