//
//  LoginViewController.swift
//  FileManager
//
//  Created by TIS Developer on 16.03.2022.
//

import UIKit

class ChangeLoginViewController: UIViewController {
    
    var changeLoginUIView = ChangeLoginUIView()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .cyan
        setupView()
        
        //если нужно сменить пароль
        changeLoginUIView.onTapChangeButton = { data in
            let checkLenghtPassword = LoginInspector.shared.checkLenghtPassword(password: data)
            if checkLenghtPassword {
                self.savePassword(password: data)
            } else {
                self.makeAlert(messageErr: "Пароль должен быть больше 4 символов!")
            }
        }
    }
    
    func makeAlert(messageErr: String) {
        let alertVC = UIAlertController(title: "Ошибка", message: messageErr, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default)
        alertVC.addAction(alertAction)
        self.present(alertVC, animated: true, completion: nil)
    }
    
    func savePassword(password: String) {
        let checkSaveNewPassword = LoginInspector.shared.saveNewPassword(newPassword: password)
        if checkSaveNewPassword {
            let alertVC = UIAlertController(title: "Успешно", message: "Пароль изменен!", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "OK", style: .default) { (_) in
                self.dismiss(animated: true, completion: nil)
            }

            alertVC.addAction(alertAction)
            self.present(alertVC, animated: true, completion: nil)
        } else {
            self.makeAlert(messageErr: "Ошибка сохранения пароля!")
        }
    }
}

extension ChangeLoginViewController {
    func setupView() {
        
        self.view.addSubview(changeLoginUIView)
        changeLoginUIView.translatesAutoresizingMaskIntoConstraints = false
        
        let constraints = [
            changeLoginUIView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            changeLoginUIView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            changeLoginUIView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            changeLoginUIView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
        ]
        NSLayoutConstraint.activate(constraints)
    }
}
