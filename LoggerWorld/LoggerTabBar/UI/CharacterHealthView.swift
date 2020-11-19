//
//  characterHealtView.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 19.11.2020.
//

import UIKit

@IBDesignable
class CharacterHealthView: UIView, NibLoadable {

    @IBOutlet var contentView: UIView!
    @IBOutlet weak var charImageView: UIImageView!
    @IBOutlet var charBGView: UIView!
    @IBOutlet weak var lvlLabel: UILabel!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var currentManaLabel: UILabel!
    @IBOutlet weak var currentHealtLabel: UILabel!
    
    // MARK: - Override methods/Lifecycl
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("CharacterHealthView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }

}
