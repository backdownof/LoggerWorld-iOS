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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
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
                
        UI.setRootController(R.storyboard.selectCharToPlay.instantiateInitialViewController())
//        let storyboard = UIStoryboard(name: R.storyboard.selectCharToPlay.name, bundle: nil)
//        let loginVCtrl = storyboard.instantiateViewController(withIdentifier: "SelectCharToPlay")
//        present(loginVCtrl, animated: true)
        
        
//        let storyBoard: UIStoryboard = UIStoryboard(name: R.storyboard.selectCharToPlay.name, bundle: nil)
//        let selectCharVC = storyBoard.instantiateViewController(withIdentifier: "SelectCharToPlayNav") as! UINavigationController
//        selectCharVC.modalPresentationStyle = .fullScreen
//        self.present(selectCharVC, animated: true, completion: nil)
        
        
        //        let nav = self.navigationController
        //        nav?.view.window!.layer.add(CATransition().segueFromLeft(), forKey: kCATransition)
//        nav?.pushViewController(selectCharVC, animated: false)
//        self.navigationController?.pushViewController(selectCharVC, animated: true)

        
        
        
        
        
        
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


