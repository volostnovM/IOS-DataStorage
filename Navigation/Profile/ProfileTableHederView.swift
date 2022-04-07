//
//  ProfileTableHederView.swift
//  Navigation
//

import UIKit
import SnapKit

class ProfileHederView: UITableViewHeaderFooterView {
    
    private var statusText :String? = nil
    
    var profileHeaderView: UIView = {
        let view = UIView()
        view.backgroundColor = .init(white: 0.95, alpha: 1.0)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
        var fullNameLabel: UILabel = {
            let label = UILabel()
            label.textColor = .black
            label.font = UIFont.systemFont(ofSize: 18, weight: .bold)
            label.text = "Hipster Cat"
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        var statusLabel: UILabel = {
            let label = UILabel()
            label.textColor = .gray
            label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
            label.text = "Waiting for something..."
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        var avatarImageView: UIImageView = {
            let imageView = UIImageView()

            imageView.isUserInteractionEnabled = true
            imageView.image = UIImage(named: "avatar")
            imageView.clipsToBounds = true
            imageView.translatesAutoresizingMaskIntoConstraints = false
            imageView.layer.borderWidth = 3.0
            imageView.layer.borderColor = UIColor.white.cgColor
            return imageView
        }()
    
    
    private lazy var setStatusButton: CustomButton = {
        let button = CustomButton(title: "Set status", titleColor: .white, backgroundColor: nil, backgroundImage: UIImage(imageLiteralResourceName: "pixel"), buttonAction: { [weak self] in
            if ((self?.statusText?.isEmpty) != nil) {
                self?.statusText = "Set up status"
            }
            self?.statusLabel.text = self?.statusText
            self?.endEditing(true)
        })
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()


        var statusTextField: UITextField = {
            let textField = UITextField()
            textField.textColor = .black
            textField.backgroundColor = .white
            textField.font = UIFont.systemFont(ofSize: 15, weight: .regular)
            textField.placeholder = "Write status"
            textField.addTarget(self, action: #selector(textFieldwriteStatus), for: .editingChanged)
            textField.translatesAutoresizingMaskIntoConstraints = false
            textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 10, height: textField.frame.height))
            textField.leftViewMode = .always
            textField.layer.cornerRadius = 12
            textField.layer.borderWidth = 1
            textField.layer.borderColor = UIColor.white.cgColor
            
            return textField
        }()
    
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        nil
    }
    

//    @objc func pressButtonWriteStatus() {
//        if let outputStatus = statusText {
//            print(outputStatus)
//            statusLabel.text = outputStatus
//        }
//        else {
//            print("Ничего менять!")
//        }
//    }
    
    @objc func textFieldwriteStatus() {
        statusText = statusTextField.text
        
        if let outputStatus = statusText{
            print(outputStatus)
        }
        else {
            print("Ничего не вводили!")
        }
    }
        
    
    override func layoutSubviews() {
        super.layoutSubviews()
        avatarImageView.layer.cornerRadius = avatarImageView.frame.size.width / 2
    }
}

private extension ProfileHederView{

    func setupViews() {
        
        contentView.addSubview(profileHeaderView)
        profileHeaderView.addSubview(avatarImageView)
        profileHeaderView.addSubview(fullNameLabel)
        profileHeaderView.addSubview(statusLabel)
        profileHeaderView.addSubview(statusTextField)
        profileHeaderView.addSubview(setStatusButton)
        
        profileHeaderView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(safeAreaLayoutGuide)
            make.left.equalTo(safeAreaLayoutGuide)
            make.right.equalTo(safeAreaLayoutGuide)
            make.height.equalTo(220)
        }
        
        avatarImageView.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(profileHeaderView).offset(16)
            make.left.equalTo(profileHeaderView).offset(16)
            make.width.height.equalTo(110)
        }
        
        fullNameLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(profileHeaderView).offset(27)
            make.left.equalTo(profileHeaderView).offset(132)
            make.height.equalTo(30)
            make.width.equalTo(180)
        }
        
        statusLabel.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(fullNameLabel.snp.bottom).offset(25)
            make.left.equalTo(profileHeaderView).offset(132)
            make.right.equalTo(profileHeaderView).offset(-16)
            make.height.equalTo(14)
        }

        statusTextField.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(statusLabel.snp.bottom).offset(10)
            make.left.equalTo(profileHeaderView).offset(132)
            make.right.equalTo(profileHeaderView).offset(-16)
            make.height.equalTo(40)
        }

        setStatusButton.snp.makeConstraints{(make) -> Void in
            make.top.equalTo(statusTextField.snp.bottom).offset(16)
            make.left.equalTo(profileHeaderView).offset(16)
            make.right.equalTo(profileHeaderView).offset(-16)
            make.height.equalTo(50)
        }
    }
}
