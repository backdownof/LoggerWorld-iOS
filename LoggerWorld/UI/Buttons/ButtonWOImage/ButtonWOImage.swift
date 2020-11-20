//
//  ButtonWOImage.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

protocol ButtonWOImageDelegate: class {
    func buttonTapped(_ button: ButtonWOImage)
}

@IBDesignable
class ButtonWOImage: UIButton, NibLoadable {
    
    @IBOutlet var button: UIButton!
    
    weak var delegate: ButtonWOImageDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var buttonImageView: UIImageView!
    @IBOutlet weak var buttonTitleLabel: UILabel!
    
    // MARK: - Public Properties
    
    var label: String = "" {
        didSet {
            buttonTitleLabel.text = label
        }
    }
    
    // MARK: - Override methods/Lifecycle
    convenience init() {
        self.init(frame: .zero)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        loadFromNib(owner: self)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadFromNib(owner: self)
    }
    
    @IBAction func buttonTapped(_ sender: Any) {
        delegate?.buttonTapped(self)
    }
    
    /*
     // Only override draw() if you perform custom drawing.
     // An empty implementation adversely affects performance during animation.
     override func draw(_ rect: CGRect) {
     // Drawing code
     }
     */
    
}
