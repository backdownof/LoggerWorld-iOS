//
//  SelectCharToPlayController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit
import StompClientLib
import RealmSwift

class SelectCharToPlayController: ViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var enterButton: ButtonWOImage!
    
    var characters: [CharacterInformation] = []
    
    var selectedCharId: Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ConnectionService.shared.socketConnect()
        
        LocationManager.shared.delegate = self
        CharStats.shared.delegate = self
        Characters.shared.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        enterButton.delegate = self
        SocketManager.shared.loggingDelegate = self
        
        setupView()
        Characters.shared.loadData()
        
        print(Realm.Configuration.defaultConfiguration.fileURL!)
        
        charactersTableView.register(UINib(nibName: R.nib.characterPickCell.name, bundle: nil), forCellReuseIdentifier: "charCell")
        charactersTableView.register(UINib(nibName: R.nib.addCharCell.name, bundle: nil), forCellReuseIdentifier: "addCell")
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = false
        enterButton.label = "Играть"
        charactersTableView.separatorColor = R.color.brown()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        charactersTableView.backgroundColor = .clear
        charactersTableView.backgroundView = UIImageView(image: R.image.backgroundFrame())
        charactersTableView.backgroundView?.contentMode = .scaleToFill
        charactersTableView.backgroundView?.clipsToBounds = true
        
        charactersTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: false)
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    @IBAction func backNavButtonPressed(_ sender: Any) {
//        UI.setRootController(R.storyboard.login.instantiateInitialViewController())
        self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
    }
}


extension SelectCharToPlayController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return characters.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < characters.count {
            let cell = charactersTableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterPickCell
            cell.charInfo = characters[indexPath.row]
            
            return cell
        } else {
            let cell = charactersTableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddCharCell
            
            return cell
        }
    }
}

extension SelectCharToPlayController: CharactersDelegate {
    func chardLoaded() {
        characters = Characters.shared.characters
        charactersTableView.reloadData()
    }
}

extension SelectCharToPlayController: CharStatsDelegate {
    func charStatsLoaded() {
//        charactersTableView.reloadData()
    }
}

extension SelectCharToPlayController: LocationServiceDelegate {
    func mapLoaded() {
        charactersTableView.reloadData()
    }
}

extension SelectCharToPlayController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count {
            performSegue(withIdentifier: "createChar", sender: self)
        } else {
            selectedCharId = characters[indexPath.row].id
        }
    }
}

extension SelectCharToPlayController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        if ConnectionService.shared.socketConnected {
            if let id = selectedCharId{
                ActiveCharacter.setup(ActiveCharacter.Config(id: id))
                SocketManager.shared.loginCharacter(playerId: id)
            }
        }
    }
}

extension SelectCharToPlayController: SocketManagerDelegate {
    
    func charLoggedIn() {
        performSegue(withIdentifier: "goToLoggerTB", sender: self)
    }
}
