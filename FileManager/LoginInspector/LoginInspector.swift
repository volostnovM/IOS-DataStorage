//
//  LoginInspector.swift
//  FileManager
//
//  Created by TIS Developer on 16.03.2022.
//

import UIKit
import KeychainAccess

class LoginInspector {

    static let shared = LoginInspector()

    let keychain = Keychain(service: "FileManager")
    
    func showPassword() {
        let token = keychain["password"]
        print("password \(String(describing: token))")
    }

    // метод проверки пароля на количество символов
    func checkLenghtPassword(password: String) -> Bool {
        if password.count < 4 {
            return false
        } else {
            return true
        }
    }

    // метод после ввода первого пароля
    func setFirstPassword() {
        NotificationCenter.default.post(name: Notification.Name("clearUIForSecondPassword"), object: nil)
    }

    // метод, сверяющий введенные пароли
    func comparePasswords(firstPassword: String, secondPassword: String) -> Bool {
        if firstPassword == secondPassword {
            
            do {
                try keychain.set(secondPassword, key: "password")
                UserDefaults.standard.set(true, forKey: "password")
            }
            catch let error {
                print(error)
            }
            
            print("Save pin")
            return true

        } else {
            print("Error Save pin")
            return false
        }
    }

    // метод проверки существующего пароля
    func checkPassword(password: String) -> Bool {
        
        let token = keychain["password"]
        
        guard let result = token else { return false }
        if result == password {
            return true
        } else {
            return false
        }
    }
    
    func saveNewPassword(newPassword: String) -> Bool {
        do {
            try keychain.set(newPassword, key: "password")
            UserDefaults.standard.set(true, forKey: "password")
        }
        catch let error {
            print(error)
            return false
        }
        
        print("Save new pin")
        return true
    }
}
