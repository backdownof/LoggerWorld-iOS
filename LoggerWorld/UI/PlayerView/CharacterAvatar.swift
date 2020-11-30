//
//  CharacterAvatar.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import UIKit

class CharacterAvatar: UIView {
    
    var characterStatus: PlayerStatus? {
        didSet {
            switch characterStatus {
            case .playerKiller:
                backgroundColor = R.color.charPKBG()
                layer.borderColor = R.color.creame()?.cgColor
            case .hero1st:
                backgroundColor = R.color.charHero1BG()
                layer.borderColor = UIColor.black.cgColor
            case .hero2nd:
                backgroundColor = R.color.charHero2BG()
                layer.borderColor = UIColor.black.cgColor
            case .pvp:
                backgroundColor = R.color.charPVPBG()
                layer.borderColor = R.color.creame()?.cgColor
            default:
                backgroundColor = R.color.green()
                layer.borderColor = R.color.creame()?.cgColor
            }
        }
    }
    
    var avatarImage = UIImage()
    
    override func draw(_ rect: CGRect) {
        setupView()
    }
    
    private func setupView() {
        layer.cornerRadius = 5
        layer.borderWidth = 1
        
        let imageView = UIImageView()
        self.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        imageView.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        imageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.66).isActive = true
        imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.66).isActive = true
        imageView.image = avatarImage
    }
}
