import Foundation
import UIKit

class User {
    
    var userName: String
    var userAvatar: UIImage
    var userStatus: String
    
    init(userName: String, userAvatar: UIImage, userStatus: String) {
        self.userName = userName
        self.userAvatar = userAvatar
        self.userStatus = userStatus
    }
}


