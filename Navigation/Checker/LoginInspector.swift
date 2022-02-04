import Foundation

class LoginInspector: LoginViewControllerDelegate {
    
    func checkLoginPassword(login: String, password: String) -> Bool {
        return Checker.shared.checkLoginPassword(login: login, password: password)
    }
}
