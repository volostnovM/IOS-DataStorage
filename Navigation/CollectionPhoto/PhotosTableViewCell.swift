//
//  PhotosTableViewCell.swift
//  Navigation
//

import UIKit

class PhotosTableViewCell: UITableViewCell {
    
    var contentPhoto: Photo? {
        didSet {
            firstPhotoImageView.image = UIImage(named: "photo_1")
            secondPhotoImageView.image = UIImage(named: "photo_2")
            thirdPhotoImageView.image = UIImage(named: "photo_3")
            fourthPhotoImageView.image = UIImage(named: "photo_4")
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    private let photoWidth = (UIScreen.main.bounds.width - 12 - 12 - 8 - 8 - 8)/4
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.text = "Photos"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var jumpImageView: UIImageView = {
        let imageView = UIImageView()
        
        imageView.image = UIImage(named: "strelka")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true

        imageView.layer.cornerRadius = 6
        return imageView
    }()
    

    
    var firstPhotoImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo_\(arc4random_uniform(20)+1)")
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    var secondPhotoImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo_\(arc4random_uniform(20)+1)")
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    var thirdPhotoImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo_\(arc4random_uniform(20)+1)")
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    var fourthPhotoImageView: UIImageView = {
        let imageView = UIImageView()

        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.clipsToBounds = true
        imageView.image = UIImage(named: "photo_\(arc4random_uniform(20)+1)")
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
}

extension PhotosTableViewCell {
    func setupViews(){
        
        contentView.addSubview(titleLabel)
        contentView.addSubview(jumpImageView)
        contentView.addSubview(firstPhotoImageView)
        contentView.addSubview(secondPhotoImageView)
        contentView.addSubview(thirdPhotoImageView)
        contentView.addSubview(fourthPhotoImageView)
        

        
        let constraints = [
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            
            jumpImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            jumpImageView.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            jumpImageView.widthAnchor.constraint(equalToConstant: 30),
            jumpImageView.heightAnchor.constraint(equalToConstant: 30),
            
            firstPhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            firstPhotoImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 12),
            firstPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            firstPhotoImageView.widthAnchor.constraint(equalToConstant: photoWidth),
            firstPhotoImageView.heightAnchor.constraint(equalToConstant: photoWidth),
            
            secondPhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            secondPhotoImageView.leadingAnchor.constraint(equalTo: firstPhotoImageView.trailingAnchor, constant: 8),
            secondPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            secondPhotoImageView.widthAnchor.constraint(equalToConstant: photoWidth),
            secondPhotoImageView.heightAnchor.constraint(equalToConstant: photoWidth),
            
            thirdPhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            thirdPhotoImageView.leadingAnchor.constraint(equalTo: secondPhotoImageView.trailingAnchor, constant: 8),
            thirdPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            thirdPhotoImageView.widthAnchor.constraint(equalToConstant: photoWidth),
            thirdPhotoImageView.heightAnchor.constraint(equalToConstant: photoWidth),
            
            fourthPhotoImageView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            fourthPhotoImageView.leadingAnchor.constraint(equalTo: thirdPhotoImageView.trailingAnchor, constant: 8),
            fourthPhotoImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            fourthPhotoImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            fourthPhotoImageView.widthAnchor.constraint(equalToConstant: photoWidth),
            fourthPhotoImageView.heightAnchor.constraint(equalToConstant: photoWidth)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
    }
}

extension PhotosTableViewCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = UICollectionViewCell()
        return cell
    }
}
