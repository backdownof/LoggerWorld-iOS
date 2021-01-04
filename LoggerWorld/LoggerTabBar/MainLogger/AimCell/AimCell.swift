//
//  AimCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 05.01.2021.
//

import UIKit

class AimCell: UICollectionViewCell {

    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var avatarView: MobAvatar!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
}
