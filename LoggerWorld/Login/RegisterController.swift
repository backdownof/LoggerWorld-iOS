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
    @IBOutlet weak var nicknameTextField: UITextField!
    
    private lazy var alertView: AlertView = {
        let alerView: AlertView = AlertView.loadFromNib()
        alerView.delegate = self
        return alerView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.hideKeyboardWhenTappedAround()
        registerButton.delegate = self
        alertView.delegate = self
        // Do any additional setup after loading the view.
        setupView()
        
        
    }
    
    // MARK: - Private function
    
    private func setupView() {
        setupVisualEffectView()
        
        self.navigationController?.isNavigationBarHidden = false
        registerButton.label = "Регистрация"
        
        var colorCreame = UIColor.white
        
        if let creameColorSource = R.color.creame() {
            colorCreame = creameColorSource
        }
        
        emailTextField.attributedPlaceholder = NSAttributedString(string: emailTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: colorCreame.withAlphaComponent(0.4)])
        passwordTextField.attributedPlaceholder = NSAttributedString(string: passwordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: colorCreame.withAlphaComponent(0.4)])
        repeatPasswordTextField.attributedPlaceholder = NSAttributedString(string: repeatPasswordTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: colorCreame.withAlphaComponent(0.4)])
        nicknameTextField.attributedPlaceholder = NSAttributedString(string: nicknameTextField.placeholder!, attributes: [NSAttributedString.Key.foregroundColor: colorCreame.withAlphaComponent(0.4)])
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
    
//    @IBAction func showAlertPressed(_ sender: Any) {
//
//    }
    
    func animateAlertIn() {
        alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        alertView.alpha = 0
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.alertView.alpha = 1
            self.alertView.transform = CGAffineTransform.identity
        }
    }
    
    func animateAlertOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.visualEffectView.alpha = 0
            self.alertView.alpha = 0
            self.alertView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.alertView.removeFromSuperview()
        }
    }
    
    func setAlert(status: String, message: String) {
        view.addSubview(alertView)
        alertView.center = view.center
        alertView.set(status: status, title: message, buttonTitle: "ОК")
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
}

extension RegisterController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        alertView.isUserInteractionEnabled = false
        guard let email = emailTextField.text, let password = passwordTextField.text, let nickname = nicknameTextField.text else { return }
        if Validator.validEmail(for: email) &&/* Validator.passwordIsStrong(for: password) &&*/ passwordTextField.text == repeatPasswordTextField.text && Validator.nicknameIsValid(for: nickname) {
            
            Network.requestRegister(userName: nickname,
                                    password: password,
                                    email: email,
                                    completion: { message in
                                        self.setAlert(status: "Успех", message: message)
                                        self.animateAlertIn()
                                        self.alertView.isUserInteractionEnabled = true
                                        self.alertView.statusIsSuccess = true
                                    },
                                    failure: { message in
                                        self.setAlert(status: "Ошибка", message: message)
                                        self.animateAlertIn()
                                        self.alertView.isUserInteractionEnabled = true
                                    })
            dismiss(animated: true, completion: nil)
        } else {
            print("error: некорректный email или password")
        }
    }
}

extension RegisterController: AlertDelegate {
    func okButtonTyped() {
        animateAlertOut()
        if alertView.statusIsSuccess == true {
            navigationController?.popViewController(animated: true)
            dismiss(animated: true, completion: nil)
        }
    }
}
