//
//  LoginControllerViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class LoginController: ViewController {
    
    func connected() {
//        UI.setRootController(R.storyboard.selectCharToPlay.instantiateInitialViewController())
//        performSegue(withIdentifier: R.segue.login .identifier, sender: self)
        
    }
    
    @IBOutlet weak var loginButton: ButtonWOImage!
    
    
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: private properties
    
    private lazy var alertView: AlertView = {
        let alerView: AlertView = AlertView.loadFromNib()
        alerView.delegate = self
        return alerView
    }()
    
    private let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        setupView()
        
        loginButton.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.isNavigationBarHidden = true
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = true
        setupVisualEffectView()
        loginButton.label = "Вход"
    }
    
    private func getMaps() {
        MapsService.loadAllMaps(complition: {
            self.performSegue(withIdentifier: "segue.selectCharacterToPlay", sender: self)
//            let mSavedItemCategories = realm.objects(ItemCategoryModel.self)
//
//            let category = realm.objects(ItemCategoryModel.self).filter("id == \(9)").first
//
//            let mSavedItemStatsMap = realm.objects(ItemStatModel.self)
//            let mSavedSlotsMap = realm.objects(EquipmentSlotModel.self)
//            let mSavedItemQualities = realm.objects(ItemQualityModel.self)
//            let mSavedWorldMap = realm.objects(WorldMapModel.self)
        }, failure: {
            
        })
    }
    
}

extension LoginController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        button.isUserInteractionEnabled = false
        if let userName = emailTextField.text, let password = passwordTextField.text {
            UserSettings.clear()
            
            Network.requestLogin(userName: userName,
                                 password: password,
                                 completion: { [weak self] in
                                    self?.getMaps()
                                    button.isUserInteractionEnabled = true
                                 },
                                 failure: { response in
                                    self.setAlert(status: "Успех", message: response)
                                    self.animateAlertIn()
                                    
                                    print("error Occured try again")
                                    button.isUserInteractionEnabled = true
                                 })
            
        }
    }
}

extension LoginController: AlertDelegate {
    func okButtonTyped() {
        animateAlertOut()
    }
    
    func setAlert(status: String, message: String) {
        view.addSubview(alertView)
        alertView.center = view.center
        alertView.set(status: status, title: message, buttonTitle: "ОК")
    }
    
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
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
}


