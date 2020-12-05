//
//  CharStatusBar.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 20.11.2020.
//

import UIKit

@IBDesignable
class CharStatusBar: UIView {

    @IBOutlet weak var mpLabel: UILabel!
    @IBOutlet weak var hpLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet var contentView: UIView!
    @IBOutlet weak var charAvatar: CharacterAvatar!
    
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
        loadCharInfo()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
        loadCharInfo()
    }
    
    private func loadCharInfo() {
        nicknameLabel.text = ActiveCharacter.shared.info.name
        lvlLabel.text = "\(Int(ActiveCharacter.shared.info.stats.id12)) lvl"
        hpLabel.text = "0/\(Int(ActiveCharacter.shared.info.stats.id1)) hp"
        mpLabel.text = "0/\(Int(ActiveCharacter.shared.info.stats.id2)) mp"
        charAvatar.classId = ActiveCharacter.shared.info.classId
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CharStatusBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
