//
//  LoginViewController.swift
//  FileManager
//
//  Created by TIS Developer on 16.03.2022.
//

import UIKit

class LoginViewController: UIViewController {
    
    var firstPassword: String?
    var secondPassword: String?

    var loginUIView = LoginUIView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
        setupHideKeyboardOnTap()
        
        //если пароль еще не установлен
        loginUIView.onTapEnterButton = { data in
            let checkLenghtPassword = LoginInspector.shared.checkLenghtPassword(password: data)
            if checkLenghtPassword {
                self.firstPassword = data
                self.loginUIView.clearUIForSecondPassword()
            } else {
                self.makeAlert(messageErr: "Пароль должен быть больше 4 символов!")
            }
        }
        
        //пароль установлен
        loginUIView.onTapNewPinButton = { data in
            let checkLenghtPassword = LoginInspector.shared.checkLenghtPassword(password: data)
            if checkLenghtPassword {
                let status = LoginInspector.shared.checkPassword(password: data)
                if status {
                    self.presentFileManager()
                } else {
                    self.makeAlert(messageErr: "Неправильно введен пароль!")
                }
            } else {
                self.makeAlert(messageErr: "Пароль должен быть больше 4 символов!")
            }
        }
        
        //проверка второго введенного пароля
        loginUIView.onTapSecondNewPinButton = { data in

            self.secondPassword = data
            guard let firstPassword = self.firstPassword, let secondPassword = self.secondPassword else { return }
            let checkLenghtPassword = LoginInspector.shared.checkLenghtPassword(password: data)
            if checkLenghtPassword {
                
                let result = LoginInspector.shared.comparePasswords(firstPassword: firstPassword, secondPassword: secondPassword)
                if result {
                    self.presentFileManager()
                } else {
                    self.makeAlert(messageErr: "Пароли не совпадают!")
                    self.loginUIView.clearAllData()
                }
            } else {
                self.makeAlert(messageErr: "Пароль должен быть больше 4 символов!")
            }
        }
        
        LoginInspector.shared.showPassword()
    }
    
    func makeAlert(messageErr: String) {
        let alertVC = UIAlertController(title: "Ошибка", message: messageErr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    
    //  метод перехода на экран FileManager
    func presentFileManager() {
        let tabBarController = UITabBarController()
        tabBarController.tabBar.tintColor = .black
        
        if #available(iOS 15.0, *) {
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = .white
            
            tabBarController.tabBar.standardAppearance = tabBarAppearance
            tabBarController.tabBar.scrollEdgeAppearance = tabBarAppearance
        }
        

        let fileManagerVC = FileManagerViewController()
        fileManagerVC.view.backgroundColor = .white
        fileManagerVC.tabBarItem = UITabBarItem(title: "Manager", image: UIImage(systemName: "folder"), tag: 0)
        
        let fileManagerController = UINavigationController(rootViewController: fileManagerVC)
        fileManagerController.navigationBar.barTintColor = .cyan
        fileManagerController.navigationBar.tintColor = .black
        
        let settingVC = SettingViewController()
        settingVC.view.backgroundColor = .white
        settingVC.tabBarItem = UITabBarItem(title: "Setting", image: UIImage(systemName: "swift"), tag: 1)
        
        let settingController = UINavigationController(rootViewController: settingVC)
        settingController.navigationBar.barTintColor = .cyan
        settingController.navigationBar.tintColor = .black
        
        tabBarController.viewControllers = [settingController,fileManagerController]
        tabBarController.selectedIndex = 1
        tabBarController.modalPresentationStyle = .fullScreen
        self.present(tabBarController, animated: false, completion: nil)
    }

}
extension LoginViewController {
    func setupView() {
        
        self.view.addSubview(loginUIView)
        loginUIView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            loginUIView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            loginUIView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            loginUIView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            loginUIView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
        
        
    }
}
extension LoginViewController : UITextFieldDelegate {
    //Скрытие keyboard при нажатии клавиши Return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    //Скрытие keyboard при нажатии за пределами TextField
    func setupHideKeyboardOnTap() {
        self.view.addGestureRecognizer(self.endEditingRecognizer())
        self.navigationController?.navigationBar.addGestureRecognizer(self.endEditingRecognizer())
    }
    
    private func endEditingRecognizer() -> UIGestureRecognizer {
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(self.view.endEditing(_:)))
        tap.cancelsTouchesInView = false
        return tap
    }
}
