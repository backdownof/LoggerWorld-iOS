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
class ButtonWImage: UIView {
    
    @IBOutlet var contentView: UIControl!
    @IBOutlet var image: UIImageView!
    @IBOutlet var label: UILabel!
    
    weak var delegate: ButtonWImageDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    var buttonLabel: String = "" {
        didSet {
            label.text = buttonLabel
        }
    }
    
    @IBAction func buttonPressed(_ sender: Any) {
        
    }
    
    private func commonInit() {
        Bundle.main.loadNibNamed("ButtonWImage", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    }
    
}
