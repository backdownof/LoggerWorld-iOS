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
            charsAvatarImageView.avatarImage = nil
            charsAvatarImageView.classId = classId
            charsAvatarImageView.setNeedsDisplay()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
//    override func prepareForReuse() {
//        super.prepareForReuse()
//    }
}
