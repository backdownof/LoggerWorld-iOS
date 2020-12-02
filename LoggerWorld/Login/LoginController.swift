//
//  LoginControllerViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class LoginController: ViewController, SocketManagerDelegate {
    func connected() {
        UI.setRootController(R.storyboard.selectCharToPlay.instantiateInitialViewController())
    }
    
    @IBOutlet weak var loginButton: ButtonWOImage!
    
    var chars: [String] = []
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var socketManager = SocketManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        
        loginButton.delegate = self
        socketManager.delegate = self
        
        Network.getStatsDescription(completion: {
            
        }, failure: {
            
        })
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        loginButton.label = "Вход"
    }
    
}

extension LoginController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        if let userName = emailTextField.text, let password = passwordTextField.text {
            UserSettings.clear()
            
            Network.requestLogin(userName: userName,
                                 password: password,
                                 completion: {
                                    self.connectToWs()
                                 },
                                 failure: {
                                    print("error Occured try again")
                                 })
            
        }
    }
    
    func connectToWs() {
        SocketManager.shared.connectToWS()
    }
    
    
}


