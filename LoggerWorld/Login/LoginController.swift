//
//  LoginControllerViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class LoginController: ViewController, SocketManagerDelegate {

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
//                performSegue(withIdentifier: R.segue.createCharController.loggedInWithChar.identifier, sender: nil)
            } else if login.login == "fail" {
                // TODO: обработать ошибку логина
            }
        }
    }
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    let socketManager = SocketManager.shared.socket
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loginButton.delegate = self
        SocketManager.shared.delegate = self
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if segue.identifier == R.segue.loginController.segueSelectCharToPlay.identifier {
//            let navc = segue.destination as! UINavigationController
//            let vc = navc.topViewController as! SelectCharToPlayController
//                segue.destination
//            destinationVC.createdCharacters = chars
    
//        }
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        loginButton.label = "Вход"
    }
    
}

extension LoginController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        let storyBoard: UIStoryboard = UIStoryboard(name: R.storyboard.selectCharToPlay.name, bundle: nil)
        let selectCharVC = storyBoard.instantiateViewController(withIdentifier: "SelectCharToPlay") as! SelectCharToPlayController
        selectCharVC.modalPresentationStyle = .fullScreen
        self.present(selectCharVC, animated: true, completion: nil)
        
        
        
        print("ButtonPressed")
//        print(R.segue.loginController.segueSelectCharToPlay.identifier)
//        let selectCharVC = SelectCharToPlayController()
//        selectCharVC.modalPresentationStyle = .fullScreen
        
        
        
        
//        performSegue(withIdentifier: R.segue.loginController.segueSelectCharToPlay.identifier, sender: nil)
        
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
