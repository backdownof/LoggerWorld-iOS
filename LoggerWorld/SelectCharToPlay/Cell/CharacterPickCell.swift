//
//  CharacterPickCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class CharacterPickCell: UITableViewCell {

    @IBOutlet weak var imageBackgroundView: UIView!
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet weak var charNicknameLabel: UILabel!
    @IBOutlet weak var charLocationLabel: UILabel!
    @IBOutlet weak var charLvlLabel: UILabel!
    
    var charInfo: CharInfo? {
        didSet {
            if let classImage = charInfo?.classImage {
                charImageView.image = classImage
            }
            if let color = charInfo?.classColor {
                imageBackgroundView.backgroundColor = color
            }
            if let nickname = charInfo?.charName {
                charNicknameLabel.text = nickname
            }
            if let location = charInfo?.charLocation {
                charLocationLabel.text = location
            }
            if let lvl = charInfo?.charLvl {
                charLvlLabel.text = "\(lvl) лвл"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        imageBackgroundView.layer.borderWidth = 1
        guard let color = R.color.brown() else { return }
        imageBackgroundView.layer.borderColor = color.cgColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
