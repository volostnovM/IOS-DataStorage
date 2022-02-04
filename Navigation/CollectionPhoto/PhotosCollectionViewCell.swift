//
//  PhotosCollectionViewCell.swift
//  Navigation
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {
    
    var deviceImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .black
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        contentView.addSubview(deviceImageView)
        contentView.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupViews()
    }
    
}

extension PhotosCollectionViewCell {
    
    private func setupViews() {
       
        
        let constraints = [
            deviceImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            deviceImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            deviceImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            deviceImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
}
