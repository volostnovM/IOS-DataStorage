//
//  LoginUIView.swift
//  FileManager
//
//  Created by TIS Developer on 16.03.2022.
//

import UIKit

class LoginUIView: UIView {
    
    var onTapNewPinButton: ((_ pin: String) -> Void)?
    var onTapSecondNewPinButton: ((_ pin: String) -> Void)?
    var onTapEnterButton: ((_ pin: String) -> Void)?

    lazy var passwordTextField: MyTextField = {
        let textField = MyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите пароль"
        textField.backgroundColor = .white
        textField.layer.cornerRadius = 5
        textField.textInsets.right = 5
        textField.textInsets.left = 5
        textField.isSecureTextEntry = true
        return textField
    }()

    lazy var passwordButton: UIButton = {
        let passwordButton = UIButton()
        passwordButton.translatesAutoresizingMaskIntoConstraints = false
        passwordButton.backgroundColor = .systemBlue
        passwordButton.layer.cornerRadius = 5


        let passwordIsSet = UserDefaults.standard.bool(forKey: "password")
        if passwordIsSet == true {
            passwordButton.setTitle("Введите пароль", for: .normal)
            passwordButton.addTarget(self, action: #selector(insertPasswordButtonAction), for: .touchUpInside)
        } else {
            passwordButton.setTitle("Создать пароль", for: .normal)
            passwordButton.addTarget(self, action: #selector(firstPasswordButtonAction), for: .touchUpInside)
        }
        return passwordButton
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // сброс при вводе неверного повторного пароля
    func clearAllData() {
        passwordButton.removeTarget(self, action: #selector(comparePasswords), for: .touchUpInside)
        passwordButton.addTarget(self, action: #selector(firstPasswordButtonAction), for: .touchUpInside)
        passwordButton.setTitle("Создать пароль", for: .normal)
        passwordTextField.text?.removeAll()
    }
    
    // метод сброса интерфейса для ввода пароля повторно
    func clearUIForSecondPassword() {
        passwordTextField.text?.removeAll()
        passwordButton.setTitle("Повторите пароль", for: .normal)
        passwordButton.removeTarget(self, action: #selector(firstPasswordButtonAction), for: .touchUpInside)
        passwordButton.addTarget(self, action: #selector(comparePasswords), for: .touchUpInside)
    }
    
    //если пароль уже установлен
    @objc func firstPasswordButtonAction() {
        guard let password = passwordTextField.text else { return }
        onTapEnterButton?(password)
    }
    
    //пароль еще не установлен
    @objc func insertPasswordButtonAction() {
        guard let password = passwordTextField.text else { return }
        onTapNewPinButton?(password)
    }
    
    // сверка паролей
    @objc func comparePasswords() {
        guard let password = passwordTextField.text else { return }
        onTapSecondNewPinButton?(password)
    }
}

extension LoginUIView {
    
    func setupConstraints() {
        self.addSubview(passwordTextField)
        self.addSubview(passwordButton)
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            //passwordTextField.widthAnchor.constraint(equalToConstant: CGFloat(self.bounds.width) / 2),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),
            
            passwordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
        ])
    }
}
