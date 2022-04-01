//
//  LoginUIView.swift
//  FileManager
//
//  Created by TIS Developer on 16.03.2022.
//

import UIKit

class ChangeLoginUIView: UIView {
    
    var onTapChangeButton: ((_ pin: String) -> Void)?

    private lazy var passwordTextField: MyTextField = {
        let textField = MyTextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "Введите новый пароль"
        textField.backgroundColor = .systemGray6
        textField.layer.cornerRadius = 5
        textField.textInsets.right = 5
        textField.textInsets.left = 5
        textField.isSecureTextEntry = true
        return textField
    }()

    private lazy var passwordButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 5
        button.setTitle("Сохранить пароль", for: .normal)
        button.addTarget(self, action: #selector(changePassword), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func changePassword() {
        guard let password = passwordTextField.text else { return }
        onTapChangeButton?(password)
    }
}


private extension ChangeLoginUIView {
    func setupConstraints() {
        
        self.addSubview(passwordTextField)
        self.addSubview(passwordButton)
        
        NSLayoutConstraint.activate([
            passwordTextField.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordTextField.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            passwordTextField.heightAnchor.constraint(equalToConstant: 40),

            passwordButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            passwordButton.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            passwordButton.widthAnchor.constraint(equalTo: passwordTextField.widthAnchor),
            passwordButton.heightAnchor.constraint(equalTo: passwordTextField.heightAnchor)
        ])
    }
}
