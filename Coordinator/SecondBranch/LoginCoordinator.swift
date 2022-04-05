//
//  LoginCoordinator.swift
//  Navigation
//
//  Created by TIS Developer on 11.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

class LoginCoordinator: CoordinatorProtocol {
    
    weak var parentCoordinator: AppCoordinator?
   
    let navigationController: UINavigationController
    
    var childCoordinators = [CoordinatorProtocol]()
    
    required init() {
        self.navigationController = .init()
    }
    
    func openLoginViewController() {
        let loginViewController: LoginViewController = LoginViewController()
        self.navigationController.isNavigationBarHidden = true
        loginViewController.coordinator = self
        loginViewController.delegate = MyLoginFactory().createLoginInspector()
        self.navigationController.viewControllers = [loginViewController]
    }
}

extension LoginCoordinator: LoginViewControllerCoordinatorDelegate {
    
    func navigateToNextPage() {
        let profileCoordinator = ProfileCoordinator(navigationController: navigationController)
        profileCoordinator.delegate = self
        childCoordinators.append(profileCoordinator)
        profileCoordinator.openProfileViewController()
    }
}

extension LoginCoordinator: BackToLoginViewControllerDelegate {
    func navigateToPreviousPage(newOrderCoordinator: ProfileCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
