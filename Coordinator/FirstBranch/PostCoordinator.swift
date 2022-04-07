//
//  PostCoordinator.swift
//  Navigation
//
//  Created by TIS Developer on 11.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol BackToFeedViewControllerCoordinatorDelegate: AnyObject {
    func navigateToPreviousPage(newOrderCoordinator: PostCoordinator)
}

class PostCoordinator: CoordinatorProtocol {
    
    weak var delegate: BackToFeedViewControllerCoordinatorDelegate?
    
    var childCoordinators = [CoordinatorProtocol]()
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openPostViewControler() {
        let postViewController: PostViewController = PostViewController()
        postViewController.coordinator = self
        self.navigationController.pushViewController(postViewController, animated: true)
    }
}

extension PostCoordinator: PostViewControllerCoordinatorDelegate {
    func navigateToNextPage() {
        let infoCoordinator: InfoCoordinator = InfoCoordinator(navigationController: navigationController)
        infoCoordinator.delegate = self
        childCoordinators.append(infoCoordinator)
        infoCoordinator.openInfoViewController()
    }
}

extension PostCoordinator: BackToPostViewControllerCoordinatorDelegate {
    func navigateToPreviousPage(newOrderCoordinator: InfoCoordinator) {
        navigationController.popToRootViewController(animated: true)
        childCoordinators.removeLast()
    }
}
