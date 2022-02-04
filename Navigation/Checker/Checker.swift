import Foundation

class Checker: LoginViewControllerDelegate {
    
    static let shared: Checker = .init()
    
    private let loginUser = "1"
    private let pswdUser = "1"
    
    func checkLoginPassword(login: String, password: String) -> Bool {
        if (loginUser == login && pswdUser == password) {
            print(true)
            return true
        }
        else {
            print(false)
            return false
        }
    }
}


