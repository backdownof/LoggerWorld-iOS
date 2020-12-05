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
            if let lvl = charInfo?.stats.id12 {
                print(1)
                charLvlLabel.text = "\(Int(lvl)) лвл"
            }
            if let location = charInfo?.locationId {
                guard let allLocations = LocationService.shared.locations else { return }
                for loc in allLocations {
                    if loc.id == location {
                        charLocationLabel.text = loc.name!
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
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
