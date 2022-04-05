//
//  ProfileViewController.swift
//  Navigation
//

import UIKit
import iOSIntPackage
import FirebaseAuth

protocol ProfileViewControllerCoordinatorDelegate: AnyObject {
    func navigateToNextPage()
    func navigateToPreviousPage()
}

class ProfileViewController: UIViewController {
    
    var delegate: LoginViewControllerDelegate?
    var coordinator: ProfileViewControllerCoordinatorDelegate?
    let header = ProfileHederView()
    
    private lazy var signOutButton: CustomButton = {
        let button = CustomButton(title: "Sign out", titleColor: .white, backgroundColor: nil, backgroundImage: UIImage(imageLiteralResourceName: "pixel"), buttonAction: { [weak self] in
            self?.delegate?.signOut()
            self?.coordinator?.navigateToPreviousPage()
        })
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        return button
    }()
    
    var backgroundView1: UIView = {
        let backview = UIView()
        backview.translatesAutoresizingMaskIntoConstraints = false
        backview.backgroundColor = .white
        backview.alpha = 0
        return backview
    }()
    
    var rect: UIView = {
        let rect = UIView()
        rect.translatesAutoresizingMaskIntoConstraints = false
        rect.backgroundColor = .clear
        rect.alpha = 0
        return rect
    }()
    
    
    var cancelButton: UIButton = {
        let cancelButton = UIButton(type: .close)
        cancelButton.alpha = 0
        cancelButton.isEnabled = true
        cancelButton.isUserInteractionEnabled = true
        return cancelButton
    }()
    
    
    private var tempStorage: [PostVK] = [] {
        didSet {
            tableView.reloadData()
        }
    }
    
    private var tempStoragePhoto: [Photo] = [] {
        didSet {
            tableView.reloadData()
        }
    }

    private let tableView = UITableView(frame: .zero, style: .grouped)
    private let headerID = String(describing:ProfileHederView.self)
    private let cellID = "cellID"
    private let cellPhoto = "cellPhoto"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = .white
        self.view.addSubview(tableView)
        self.view.addSubview(signOutButton)
        
        #if DEBUG
        tableView.backgroundColor = .green
        #else
        tableView.backgroundColor = .clear
        #endif
        
        setupTableView()
        setupConstraints()
        
        self.tempStorage = Storage.arrayPost
        
        //animation
        self.header.addSubview(self.backgroundView1)
        self.backgroundView1.frame = .init(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        self.header.addSubview(self.rect)
        self.rect.frame = backgroundView1.frame
        
        self.rect.addSubview(self.cancelButton)
        self.cancelButton.frame = .init(x: self.view.frame.width - 30, y: 0, width: 30, height: 30)
    }

    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(PostTableViewCell.self, forCellReuseIdentifier: cellID)
        tableView.register(PhotosTableViewCell.self, forCellReuseIdentifier: cellPhoto)
        
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    
    private func setupConstraints() {
        let constraints = [
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            signOutButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            signOutButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            signOutButton.heightAnchor.constraint(equalToConstant: 30)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    
    
    @objc func tap() {
        let opacityBackgroundAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.backgroundView1.alpha = 0.5
            self.rect.alpha = 1
        }
        
        let profileImageAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            
            self.rect.addSubview(self.header.avatarImageView)
            
            self.header.avatarImageView.frame = .init(
                x: 0,
                y: UIScreen.main.bounds.height / 2 - self.view.bounds.width / 2,
                width: self.view.bounds.width,
                height: self.view.bounds.width)
            
            self.header.avatarImageView.layer.cornerRadius = 0
            self.header.avatarImageView.layer.borderWidth = 0
        }
        
        let opacityButtonAnimation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.cancelButton.alpha = 1
        }
       
        opacityBackgroundAnimation.startAnimation()
        profileImageAnimation.startAnimation()
        opacityButtonAnimation.startAnimation(afterDelay: 0.5)
    }
    
    
    @objc func cancel() {
        
        let opacityButtonAnimation = UIViewPropertyAnimator(duration: 0.3, curve: .easeInOut) {
            self.cancelButton.alpha = 0
        }
        
        let profileImageAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.header.addSubview(self.header.avatarImageView)
            self.header.avatarImageView.frame = .init(x: 16, y: 16, width: 100, height: 100)
            
            
            self.header.avatarImageView.layer.cornerRadius = 50
            self.header.avatarImageView.layer.borderWidth = 3
            self.header.avatarImageView.layer.borderColor = UIColor.white.cgColor
        }
        
        let opacityBackgroundAnimation = UIViewPropertyAnimator(duration: 0.5, curve: .easeInOut) {
            self.backgroundView1.alpha = 0
            self.rect.alpha = 0
        }
        
        opacityButtonAnimation.startAnimation()
        profileImageAnimation.startAnimation(afterDelay: 0)
        opacityBackgroundAnimation.startAnimation(afterDelay: 0)
    }
}



extension ProfileViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == 0 {
            
            var imageArray: [UIImage] = []
            
            for i in 0...StoragePhoto.collectionModelObserver.count-1 {
                if let a = UIImage(named: "photo_\(i)") {
                    imageArray.append(a)
                } else {continue}
            }
            
            let openVC = PhotosViewController()
            
            openVC.imagePublisherFacade = ImagePublisherFacade()
            openVC.imagePublisherFacade.addImagesWithTimer(time: 0.5, repeat: 20, userImages: imageArray)
            
            
            navigationController?.isNavigationBarHidden = false
            openVC.title = "Photo Gallery"
            navigationController?.pushViewController(openVC, animated: true)
        }
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
//        let userInfo = userService.sendUser(userName: userName)
//
//        header.fullNameLabel.text = userInfo?.userName
//        header.avatarImageView.image = userInfo?.userAvatar
//        header.statusLabel.text = userInfo?.userStatus
        
        let tapGest = UITapGestureRecognizer(target: self, action: #selector(tap))
        header.avatarImageView.addGestureRecognizer(tapGest)
        
        let cancelGest = UITapGestureRecognizer(target: self, action: #selector(cancel))
        cancelButton.addGestureRecognizer(cancelGest)
        
        guard section == 0 else { return nil }
        return header
    }
    
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        switch section {
        case 0:
            return 220
        default:
            return 0
        }
    }
}

extension ProfileViewController: UITableViewDataSource {
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard section == 1 else { return 1 }
        return tempStorage.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: cellPhoto, for: indexPath) as! PhotosTableViewCell
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! PostTableViewCell
            
            cell.content = Storage.arrayPost[indexPath.row]
            
            return cell
        }
    }
}
