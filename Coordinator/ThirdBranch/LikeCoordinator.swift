//
//  ThirdBranch.swift
//  Navigation
//
//  Created by TIS Developer on 07.04.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation
import UIKit


class LikeCoordinator: CoordinatorProtocol {
    
    weak var parentCoordinator: AppCoordinator?
    var childCoordinators = [CoordinatorProtocol]()
    let navigationController: UINavigationController
    
    required init() {
        self.navigationController = .init()
    }
    
    func openLikeViewController() {
        let likeViewController: LikeViewController = LikeViewController()
        //likeViewController.coordinator = self
        self.navigationController.pushViewController(likeViewController, animated: true)
    }
}

