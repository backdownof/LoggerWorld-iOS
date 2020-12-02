//
//  ButtonWImage.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 20.11.2020.
//

import UIKit

protocol ButtonWImageDelegate: class {
    func buttonTapped(_ button: ButtonWImage)
}

@IBDesignable
class ButtonWImage: UIView, NibLoadable {
    
    @IBOutlet weak var buttonBackgroundImageView: UIImageView!
    @IBOutlet var contentView: UIButton!
    @IBOutlet weak var image: UIImageView!
    @IBOutlet weak var label: UILabel!
    
    weak var delegate: ButtonWImageDelegate?
    var buttonLabel: String = "" {
        didSet {
            label.text = buttonLabel
        }
    }
    
    convenience init() {
        self.init(frame: .zero)
        self.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        loadFromNib(owner: self)
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        translatesAutoresizingMaskIntoConstraints = false
        loadFromNib(owner: self)
        
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        delegate?.buttonTapped(self)
    }    
}
