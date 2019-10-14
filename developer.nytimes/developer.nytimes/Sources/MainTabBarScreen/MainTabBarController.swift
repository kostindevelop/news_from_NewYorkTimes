//
//  MainTabBarController.swift
//  developer.nytimes
//
//  Created by Konstantin Igorevich on 14.10.2019.
//  Copyright © 2019 Konstantin Igorevich. All rights reserved.
//

import UIKit

class MainTabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let emailedVC = NewsController()
        emailedVC.newsType = .emailed
        let icon1 = UITabBarItem(title: "Emailed", image: UIImage(named: "iconEmailed"), selectedImage: UIImage(named: "iconEmailed"))
        emailedVC.tabBarItem = icon1
        
        let viewedVC = NewsController()
        viewedVC.newsType = .viewed
        let icon2 = UITabBarItem(title: "Viewed", image: UIImage(named: "iconViewed"), selectedImage: UIImage(named: "iconViewed"))
        viewedVC.tabBarItem = icon2
        
        let sharedVC = NewsController()
        sharedVC.newsType = .shared
        let icon3 = UITabBarItem(title: "Shared", image: UIImage(named: "iconShared"), selectedImage: UIImage(named: "iconShared"))
        sharedVC.tabBarItem = icon3
        
        let favoritesVC = FavoritesController()
        let icon4 = UITabBarItem(title: "Favorites", image: UIImage(named: "iconFavorites"), selectedImage: UIImage(named: "iconFavorites"))
        favoritesVC.tabBarItem = icon4
        
        let controllers = [emailedVC, viewedVC, sharedVC, favoritesVC]  //array of the root view controllers displayed by the tab bar interface
        self.viewControllers = controllers
    }

}
