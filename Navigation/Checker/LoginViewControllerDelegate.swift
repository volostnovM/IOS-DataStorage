import Foundation

protocol LoginViewControllerDelegate: AnyObject {
    func checkLoginPassword(login: String, password: String) -> Bool
}
