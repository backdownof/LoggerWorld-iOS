//
//  RegisterController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 16.11.2020.
//

import UIKit

class RegisterController: ViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repeatPasswordTextField: UITextField!
    @IBOutlet weak var registerButton: ButtonWOImage!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        registerButton.delegate = self
        // Do any additional setup after loading the view.
        setupView()
    }
    
    // MARK: - Private function
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = false
        registerButton.label = "Регистрация"
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: R.color.creame()?.withAlphaComponent(0.4)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: R.color.creame()?.withAlphaComponent(0.4)])
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: repeatPasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: R.color.creame()?.withAlphaComponent(0.4)])
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
        dismiss(animated: true, completion: nil)
    }
    
}

extension RegisterController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        guard let email = emailTextField.text, let password = passwordTextField.text else { return }
        if Validator.validEmail(for: email) && Validator.passwordIsStrong(for: password) && passwordTextField.text == repeatPasswordTextField.text {
            print("Registered successfuly")
//            let credentials = Credentials(email: email, password: password)
//            let playerCredetials = PlayerRegistration(registration: credentials)
//
//            let encoder = JSONEncoder()
//            let data = try! encoder.encode(playerCredetials)
//
//            SocketManager.shared.socket.write(data: data)
            dismiss(animated: true, completion: nil)
        } else {
            print("error: некорректный email или password")
        }
    }
    
    
}
