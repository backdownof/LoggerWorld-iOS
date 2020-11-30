//
//  CharsInLocationCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 30.11.2020.
//

import UIKit

class CharsInLocationCell: UITableViewCell {
    @IBOutlet weak var levelLabel: UILabel!
    @IBOutlet weak var charsAvatarImageView: CharacterAvatar!
    @IBOutlet weak var shordNicknameLabel: UILabel!
    @IBOutlet weak var charClassIcon: UIImageView!
    
    var classId: Int? {
        didSet {
            switch classId {
            case 1:
                charClassIcon.image = R.image.icWarSword()!
            case 2:
                charClassIcon.image = R.image.icArcherBow()!
            case 3:
                charClassIcon.image = R.image.icMageStuff()!
            default:
                charClassIcon.image = R.image.icAssasignShuriken()!
            }
            charsAvatarImageView.classId = classId
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
}
