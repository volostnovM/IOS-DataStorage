//
//  InfoCoordinator.swift
//  Navigation
//
//  Created by TIS Developer on 11.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import UIKit

protocol BackToPostViewControllerCoordinatorDelegate: AnyObject {
    func navigateToPreviousPage(newOrderCoordinator: InfoCoordinator)
}

class InfoCoordinator: CoordinatorProtocol {
    
    weak var delegate: BackToPostViewControllerCoordinatorDelegate?
    
    var childCoordinators = [CoordinatorProtocol]()
    
    unowned let navigationController: UINavigationController
    
    required init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func openInfoViewController() {
        let infoViewController: InfoViewController = InfoViewController()
        self.navigationController.present(infoViewController, animated: true, completion: nil)
    }
}
