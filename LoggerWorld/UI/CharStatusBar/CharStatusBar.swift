//
//  CharStatusBar.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 20.11.2020.
//

import UIKit

@IBDesignable
class CharStatusBar: UIView {

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
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CharStatusBar", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
//        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
