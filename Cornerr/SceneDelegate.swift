//
//  SceneDelegate.swift
//  Cornerr
//
//  Created by Tony Chen on 4/30/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let scene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: scene)
        self.window = window
        window.makeKeyAndVisible()
        
        self.window?.rootViewController = self.createTabBarController()
    }
    
    // Creates the Tab Bar
    func createTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.backgroundColor = .lightBlue
        tabBarController.tabBar.tintColor = .darkBlue
        tabBarController.tabBar.unselectedItemTintColor = .white
        
        let dummySimpleUser: SimpleUser = SimpleUser(id: 0, username: "Tony", contact: "123")
        
        let dummyListings: [Listing] = [Listing(id: 0, unixTime: 1, title: "Manicure", category: "Beauty", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "Beaded Jewelry", category: "Crafts", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: []),Listing(id: 0, unixTime: 1, title: "Video Editing", category: "Tech", description: "blahblah", availability: "blahblah", location: "blahblah", price: 0, seller: dummySimpleUser, buyers: [])]
        
        let filters: [String] = ["Beauty", "Fashion", "Media", "Tech", "Crafts", "Food", "Other"]
        
        let homeViewController = HomeViewController(listings: dummyListings, filters: filters)
        homeViewController.tabBarItem = UITabBarItem(title: "Home", image: UIImage(systemName: "house.fill"), selectedImage: UIImage(systemName: "house.fill"))
        
        let homeNavController = UINavigationController(rootViewController: homeViewController)
        homeNavController.navigationBar.prefersLargeTitles = false
        
//        let favoritesViewController = FavoritesViewController()
//        favoritesViewController.tabBarItem = UITabBarItem(title: "Favorites", image: UIImage(systemName: "heart.fill"), selectedImage: UIImage(systemName: "heart.fill"))
//
//        let favoritesNavController = UINavigationController(rootViewController: favoritesViewController)
//        favoritesNavController.navigationBar.prefersLargeTitles = false
        
        let profileViewController = ProfileViewController()
        profileViewController.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), selectedImage: UIImage(systemName: "person.fill"))
        
        let profileNavController = UINavigationController(rootViewController: profileViewController)
        profileNavController.navigationBar.prefersLargeTitles = false
        
        tabBarController.setViewControllers(([homeNavController, profileNavController]), animated: false)
        
        return tabBarController
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }


}

