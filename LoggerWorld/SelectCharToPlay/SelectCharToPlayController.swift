//
//  SelectCharToPlayController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit
import StompClientLib

class SelectCharToPlayController: ViewController {
    
    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var enterButton: ButtonWOImage!
    
    var characters: [CharacterInformation] = []
    
    var selectedCharId: Int?
    var socketManager = SocketManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        LocationService.shared.delegate = self
        CharStats.shared.delegate = self
        Characters.shared.delegate = self
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        enterButton.delegate = self
        socketManager.delegate = self
        
        setupView()
        Characters.shared.reloadData()
        
        charactersTableView.register(UINib(nibName: R.nib.characterPickCell.name, bundle: nil), forCellReuseIdentifier: "charCell")
        charactersTableView.register(UINib(nibName: R.nib.addCharCell.name, bundle: nil), forCellReuseIdentifier: "addCell")
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = false
        enterButton.label = "Играть"
        charactersTableView.separatorColor = R.color.brown()
    }
    
//    private func loadPlayerChars() {
//        let seconds = 0.3
//        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//            Network.requestCharacters(completion: { chars in
//                self.charsListData = chars
//            }, failure: { message in
//                print(message)
//            })
//        }
//    }
    
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
//            charactersTableView.register(UINib(nibName: R.nib.addCharCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.cellCharacterPick.identifier)
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

extension SelectCharToPlayController: WorldMapDelegate {
    func mapLoaded() {
        charactersTableView.reloadData()
    }
}

extension SelectCharToPlayController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == characters.count {
//            UI.setRootController(R.storyboard.createChar.instantiateInitialViewController())
            performSegue(withIdentifier: "createChar", sender: self)
//            performSegue(withIdentifier: "goToLoggerTB", sender: self)
        } else {
            selectedCharId = characters[indexPath.row].id
        }
    }
}

extension SelectCharToPlayController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        if let id = selectedCharId {
            ActiveCharacter.setup(ActiveCharacter.Config(id: id))
            socketManager.loginCharacter(playerId: id)
        }
//        socketManager.createCharacter()
    }
}

extension SelectCharToPlayController: SocketManagerDelegate {
    func connected() { }
    
//    func listOfCharactersToSelect(chars: [CharListToLogin]) {
//        characters = chars
//    }
    
    func charLoggedIn() {
//        UI.setRootController(R.storyboard.loggerTabBar.instantiateInitialViewController())
        performSegue(withIdentifier: "goToLoggerTB", sender: self)
    }
}

