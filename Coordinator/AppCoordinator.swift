//
//  AppCoordinator.swift
//  Navigation
//
//  Created by TIS Developer on 11.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

class AppCoordinator: CoordinatorProtocol {
    
    var childCoordinators = [CoordinatorProtocol]()
    
    let window: UIWindow?

    init(window: UIWindow?) {
        self.window = window
        window?.makeKeyAndVisible()
    }

    func start() {
        let tabBarController = self.setTabBarController()
        self.window?.rootViewController = tabBarController
    }

    func setTabBarController() -> UITabBarController {
        let tabBarController = UITabBarController()

        let firstItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house.fill"), tag: 0)
        let secondItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person.fill"), tag: 1)
        let thirdItem = UITabBarItem(title: "Like", image: UIImage(systemName: "heart.fill"), tag: 2)


        let firstCoordinator = FeedCoordinator()
        firstCoordinator.parentCoordinator = self
        firstCoordinator.openFeedViewController()
        let firstViewController = firstCoordinator.navigationController
        firstViewController.tabBarItem = firstItem
       
        let secondCoordinator = LoginCoordinator()
        secondCoordinator.parentCoordinator = self
        secondCoordinator.openLoginViewController()
        let secondViewControllerVC = secondCoordinator.navigationController
        secondViewControllerVC.tabBarItem = secondItem
        
        let thirdCoordinator = LikeCoordinator()
        thirdCoordinator.parentCoordinator = self
        thirdCoordinator.openLikeViewController()
        let thirdViewControllerVC = thirdCoordinator.navigationController
        thirdViewControllerVC.tabBarItem = thirdItem

        tabBarController.viewControllers = [firstViewController,secondViewControllerVC,thirdViewControllerVC]

        return tabBarController
    }
}
