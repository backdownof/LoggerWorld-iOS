//
//  LoginControllerViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class LoginControllerViewController: ViewController, SocketManagerDelegate {

    @IBOutlet weak var loginButton: ButtonWOImage!
    
    var chars: [String] = []
    
    func dataReceived(data: String) {
        if data.contains("login") {
            let dataString: Data? = data.data(using: .utf8)
            guard let string = dataString else {return}
            let login: LoginSuccess = try! JSONDecoder().decode(LoginSuccess.self, from: string)
            print(login)
            if login.login == "success" {
                if let playerCharacters = login.chars {
                    chars = playerCharacters
                }
                performSegue(withIdentifier: Constants.Segue.login, sender: nil)
            } else if login.login == "fail" {
                // TODO: обработать ошибку логина
            }
        }
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let socketManager = SocketManager.shared.socket!
    
    @objc func buttonTapped(_ sender: UITapGestureRecognizer? = nil) {
        // handling code
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loginButton.delegate = self
        SocketManager.shared.delegate = self
        
//        loginButton.addTarget(self, action: #selector(self.buttonPressed(_:)), for: .touchUpInside);
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            let destinationVC = segue.destination as! CharacterCreationViewController
            destinationVC.createdCharacters = chars
        }
    }
    
    private func setupView() {
        loginButton.label = "Вход"
    }
    
}

extension LoginControllerViewController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        print("ButtonPressed")
        //        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        //        if emailTextField.text != "" &&
        //            email.contains("@") &&
        //            email.contains(".") &&
        //            password != "" &&
        //            password.count > 5 &&
        //            password.count < 17
        //        {
        //            let credentials = Credentials(email: email, password: password)
        //            let playerLogin = PlayerLogin(command: "login", args: credentials)
        //
        //            let encoder = JSONEncoder()
        //            let data = try! encoder.encode(playerLogin)
        //
        //            socketManager.write(data: data)
        //
        //
        //        } else {
        //            print("error: некорректный email или password")
        //        }
    }


}
