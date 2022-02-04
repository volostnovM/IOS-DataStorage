import Foundation

class MyLoginFactory: LoginFactoryProtocol {
    func createLoginInspector() -> LoginInspector {
        return LoginInspector()
    }
}
