import Foundation
import UIKit

class TestUser: UserServiceProtocol {
    private var currentUser = User(
        userName: "Test",
        userAvatar: UIImage(named: "pictureTest") ?? UIImage(),
        userStatus: "Test!Test!Test!")


    func sendUser(userName: String) -> User? {
        
        guard userName == currentUser.userName else { return nil }
            return currentUser
        }
    }



