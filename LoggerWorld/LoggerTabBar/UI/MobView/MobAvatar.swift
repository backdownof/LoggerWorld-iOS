//
//  MobAvatar.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 13.12.2020.
//

import UIKit

class MobAvatar: UIView {
    
    var imageView = UIImageView()
    var avatarImage: UIImage? {
        didSet {
            backgroundColor = R.color.creame()
        }
    }
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        clipsToBounds = true
        
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.66).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.66).isActive = true
        imageView.image = avatarImage
        
    }
}
