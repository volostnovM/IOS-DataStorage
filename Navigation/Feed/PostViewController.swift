//
//  PostViewController.swift
//  Navigation
//
//  Created by Artem Novichkov on 12.09.2020.
//  Copyright © 2020 Artem Novichkov. All rights reserved.
//

import UIKit


protocol PostViewControllerCoordinatorDelegate: AnyObject {
    func navigateToNextPage()
}

class PostViewController: UIViewController {
    
    weak var coordinator: PostViewControllerCoordinatorDelegate?
    var buttonInfo = UIBarButtonItem()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .green
        
        buttonInfo = UIBarButtonItem(image: UIImage.init(systemName: "info"), style: .plain, target: self, action: #selector(onInfoClick))
        self.navigationItem.rightBarButtonItem = buttonInfo
    }
    
    @objc func onInfoClick () {
        self.coordinator?.navigateToNextPage()
        }
}



