//
//  AlertView.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 17.11.2020.
//

import UIKit

protocol AlertDelegate {
    func okButtonTyped()
}

class AlertView: UIView, ButtonWOImageDelegate {
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var button: ButtonWOImage!
    @IBOutlet weak var statusLabel: UILabel!
    
    var delegate: AlertDelegate?
    
    var statusIsSuccess: Bool = false

    override func awakeFromNib() {
        button.delegate = self
        button.label = "ОК"
    }
    
    func buttonTapped(_ button: ButtonWOImage) {
        delegate?.okButtonTyped()
    }
    
    func set(status: String, title: String, buttonTitle: String) {
        titleLabel.text = title
        button.label = buttonTitle
        statusLabel.text = status
    }
}
