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
    
    var charInfo: CharacterInformation? {
        didSet {
            if let classId = charInfo?.classId {
                switch classId {
                case 1: charImageView.image = R.image.warriorImage()
                case 2: charImageView.image = R.image.archerImage()
                case 3: charImageView.image = R.image.mageImage()
                default: charImageView.image = R.image.assassinImage()
                }
            }
            if let nickname = charInfo?.name {
                charNicknameLabel.text = nickname
            }
            if let lvl = charInfo?.baseStats.lvl {
                charLvlLabel.text = "\(Int(lvl)) лвл"
            }
            if let locationId = charInfo?.locationId {
                charLocationLabel.text = LocationManager.shared.getNameById(id: locationId)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageBackgroundView.layer.borderWidth = 1
        imageBackgroundView.layer.cornerRadius = 5
        guard let color = R.color.brown() else { return }
        imageBackgroundView.layer.borderColor = color.cgColor
        imageBackgroundView.backgroundColor = R.color.charBG()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
