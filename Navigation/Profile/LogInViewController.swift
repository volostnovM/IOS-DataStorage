//
//  LogInViewController.swift
//  Navigation
//

import UIKit

class LogInViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?

    let scrollView = UIScrollView()
    let contentView = UIView()

    
    var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "logo")
        return imageView
    }()
    
    var loginTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Email or phone"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.tintColor = UIColor(named: "color")
        
        return textField
    }()
    
    var passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.textColor = .black
        textField.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        textField.autocapitalizationType = .none
        textField.isSecureTextEntry = true
        textField.backgroundColor = .systemGray6
        textField.placeholder = "Password"
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 10
        textField.tintColor = UIColor(named: "color")
        return textField
    }()
    
//    var entryButton: UIButton = {
//        let button = UIButton()
//        button.translatesAutoresizingMaskIntoConstraints = false
//        button.setBackgroundImage(#imageLiteral(resourceName: "pixel"), for: .normal)
//        button.setTitle("Log in", for: .normal)
//        button.setTitleColor(UIColor.init(white: 1, alpha: 1), for: .normal)
//        button.setTitleColor(UIColor.init(white: 1, alpha: 0.8), for: .selected)
//        button.setTitleColor(UIColor.init(white: 1, alpha: 0.8), for: .highlighted)
//        button.setTitleColor(UIColor.init(white: 1, alpha: 0.8), for: .disabled)
//        button.clipsToBounds = true
//        button.layer.cornerRadius = 10
//
//        button.addTarget(self, action: #selector(pressLoginButton), for: .touchUpInside)
//        return button
//    }()
    
    private lazy var entryButton: CustomButton = {
        let button = CustomButton(title: "Log in", titleColor: .white, backgroundColor: nil, backgroundImage: UIImage(imageLiteralResourceName: "pixel"), buttonAction: { [weak self] in
            #if DEBUG
            let userServise = TestUserService()
            #else
            let userServise = CurrentUserService()
            #endif
            if let login = self?.loginTextField.text, !login.isEmpty, let password = self?.passwordTextField.text, !password.isEmpty {
                if self?.delegate?.checkLoginPassword(login: login, password: password) == true {
                    let profileVC = ProfileViewController(userService: userServise, userName: login)
                    self?.navigationController?.pushViewController(profileVC, animated: true)
                } else {
                    self?.showAlert()
                }
            } else {
                self?.showAlert()
            }
        })
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
 
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillShow(notification:)),
                                               name: UIResponder.keyboardWillShowNotification,
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(keyboardWillHide(notification:)),
                                               name: UIResponder.keyboardWillHideNotification,
                                               object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)

    }

    
    @objc func pressLoginButton() {
        
        guard let login = loginTextField.text else {return}
        guard let password = passwordTextField.text else {return}
            
        let user: UserServiceProtocol
        
        #if DEBUG
        user = TestUser()
        #else
        user = CurrentUserService()
        #endif
        
        if let resultEnter = delegate?.checkLoginPassword(login: login, password: password), resultEnter == true {
            let profileVC = ProfileViewController(userService: user, userName: login)
            navigationController?.isNavigationBarHidden = true
            navigationController?.pushViewController(profileVC, animated: true)
        }
        else {
            return showAlert()
        }
    }
    
    
    private func showAlert() {
        let alertController = UIAlertController(title: "Ошибка", message: "Неверное имя пользователя или пароль", preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ок", style: .default)
        
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}

private extension LogInViewController {
    private func setupView() {
        self.view.backgroundColor = .white
        
        self.view.addSubview(scrollView)
        
        scrollView.addSubview(contentView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        contentView.translatesAutoresizingMaskIntoConstraints = false
        
        
        contentView.addSubview(logoImageView)
        contentView.addSubview(loginTextField)
        contentView.addSubview(passwordTextField)
        contentView.addSubview(entryButton)
        
        
        let constraints = [
            scrollView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor),
            
            
            contentView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            contentView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            
            
            logoImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 120),
            logoImageView.bottomAnchor.constraint(equalTo: loginTextField.topAnchor, constant: -120),
            logoImageView.widthAnchor.constraint(equalToConstant: 100),
            logoImageView.heightAnchor.constraint(equalToConstant: 100),
            
            loginTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            loginTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            loginTextField.heightAnchor.constraint(equalToConstant: 50),
            
            passwordTextField.topAnchor.constraint(equalTo: loginTextField.bottomAnchor, constant: 0),
            passwordTextField.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            passwordTextField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            passwordTextField.heightAnchor.constraint(equalToConstant: 50),
        
            entryButton.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 16),
            entryButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            entryButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            entryButton.heightAnchor.constraint(equalToConstant: 50),
            entryButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        
        ]
        NSLayoutConstraint.activate(constraints)
    
    
    }
    
}


//MARK: Keyboard Notifications
private extension LogInViewController {
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
            scrollView.verticalScrollIndicatorInsets = UIEdgeInsets(top: 0, left: 0, bottom: keyboardSize.height, right: 0)
        }
    }
    
    
    @objc func keyboardWillHide(notification: NSNotification) {
        scrollView.contentInset.bottom = .zero
        scrollView.verticalScrollIndicatorInsets = .zero
    }
}

