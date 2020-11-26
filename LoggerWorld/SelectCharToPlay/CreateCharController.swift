//
//  CreateCharController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 20.11.2020.
//

import UIKit

class CreateCharController: UIViewController {

    @IBOutlet var classView: [UIView]!
    @IBOutlet weak var createButton: ButtonWOImage!
    @IBOutlet weak var classDescriptionLabel: UILabel!
    @IBOutlet weak var nicknameTextField: UITextField!
    
    var selectedClass: String = "WARRIOR"
    
    override func viewDidLoad() {
        super.viewDidLoad()

        createButton.delegate = self
        setupView()
    }
    
    private func setupView() {
        createButton.label = "Создать"
        
        for charView in classView {
            charView.isUserInteractionEnabled = true
            charView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(self.tapClassView(_:))))
            if charView.accessibilityIdentifier == "WARRIOR" {
                addBorder(for: charView)
            }
        }
    }
    
    @objc func tapClassView(_ sender: UITapGestureRecognizer? = nil) {
        guard (sender?.view) != nil else { return }
        let sent = sender!.view!
        for charView in classView {
            if charView != sent {
                removeBorder(for: charView)
            } else {
                addBorder(for: sent)
                selectedClass = sent.accessibilityIdentifier!
            }
        }
    }
    
    private func addBorder(for charView: UIView) {
        charView.layer.borderWidth = 1
        charView.layer.borderColor = R.color.creame()?.cgColor
        charView.layer.cornerRadius = 10
        charView.clipsToBounds = true
    }
    
    private func removeBorder(for charView: UIView) {
        charView.layer.borderWidth = 0
    }
    
    @IBAction func backNavButtonPressed(_ sender: Any) {
        UI.setRootController(R.storyboard.selectCharToPlay.instantiateInitialViewController())
    }
}

extension CreateCharController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        if nicknameTextField.text != "" {
            
            SocketManager.shared.createCharacter(nickname: nicknameTextField.text!, className: selectedClass)
            print("Create char \(selectedClass) with nickname \(nicknameTextField.text)")
            SocketManager.shared.loadPlayerChars()
        }
    }
}

extension CreateCharController: SocketManagerDelegate {
    func success() {
        print("Success register")
    }
}
