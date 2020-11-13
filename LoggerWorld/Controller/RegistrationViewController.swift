//
//  RegistrationViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 02.11.2020.
//

import UIKit
import Starscream

class RegistrationViewController: UIViewController {
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func registerPressed(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if emailTextField.text != "" &&
            email.contains("@") &&
            email.contains(".") &&
            password != "" &&
            password.count > 5 &&
            password.count < 17
        {
            let credentials = Credentials(email: email, password: password)
            let playerCredetials = PlayerRegistration(registration: credentials)
            
            let encoder = JSONEncoder()
            let data = try! encoder.encode(playerCredetials)
            
            SocketManager.shared.socket.write(data: data)
            
            
        } else {
            print("error: некорректный email или password")
        }
    }
}
