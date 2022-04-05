//
//  CoordinatorProtocol.swift
//  Navigation
//
//  Created by TIS Developer on 11.03.2022.
//  Copyright © 2022 Artem Novichkov. All rights reserved.
//

import Foundation

public protocol CoordinatorProtocol: AnyObject {
    var childCoordinators: [CoordinatorProtocol] {get set}
}
