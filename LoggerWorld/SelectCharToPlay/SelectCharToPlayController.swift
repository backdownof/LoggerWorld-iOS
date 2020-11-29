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
    
    var charsListData: [CharListToLogin] = [] {
        didSet {
            charactersTableView.reloadData()
        }
    }
    var selectedCharId: Int?
    var socketManager = SocketManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        enterButton.delegate = self
        socketManager.delegate = self
        
        setupView()
        loadPlayerChars()
        
        charactersTableView.register(UINib(nibName: R.nib.characterPickCell.name, bundle: nil), forCellReuseIdentifier: "charCell")
        charactersTableView.register(UINib(nibName: R.nib.addCharCell.name, bundle: nil), forCellReuseIdentifier: "addCell")
    }
    
    private func setupView() {
        self.navigationController?.isNavigationBarHidden = false
        enterButton.label = "Играть"
        charactersTableView.separatorColor = R.color.brown()
    }
    
    private func loadPlayerChars() {
        let seconds = 0.3
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds) {
//            self.socketManager.loadPlayerChars()
            Network.requestCharacters(completion: { chars in
                self.charsListData = chars
                print("xxxx")
                print(self.charsListData)
            }, failure: {
                print("fucked loading characters")
            })
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        charactersTableView.backgroundColor = .clear
        charactersTableView.backgroundView = UIImageView(image: R.image.backgroundFrame())
        charactersTableView.backgroundView?.contentMode = .scaleToFill
        charactersTableView.backgroundView?.clipsToBounds = true
        
        charactersTableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    @IBAction func backNavButtonPressed(_ sender: Any) {
        UI.setRootController(R.storyboard.login.instantiateInitialViewController())
    }
    
}


extension SelectCharToPlayController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return charsListData.count + 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.row < charsListData.count {
            let cell = charactersTableView.dequeueReusableCell(withIdentifier: "charCell", for: indexPath) as! CharacterPickCell
            cell.charInfo = charsListData[indexPath.row]
            
            return cell
        } else {
//            charactersTableView.register(UINib(nibName: R.nib.addCharCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.cellCharacterPick.identifier)
            let cell = charactersTableView.dequeueReusableCell(withIdentifier: "addCell", for: indexPath) as! AddCharCell
            
            return cell
        }
    }
}

extension SelectCharToPlayController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == charsListData.count {
            UI.setRootController(R.storyboard.createChar.instantiateInitialViewController())
        } else {
            print(indexPath.row - 1)
            if let id = charsListData[indexPath.row].id {
                selectedCharId = id
            }
        }
    }
}

extension SelectCharToPlayController: ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        print("enter")
        if let id = selectedCharId {
            socketManager.loginCharacter(playerId: id)
        }
//        socketManager.createCharacter()
        
    
    }
}

extension SelectCharToPlayController: SocketManagerDelegate {
    func connected() { }
    
    func listOfCharactersToSelect(chars: [CharListToLogin]) {
        charsListData = chars
    }
    
    func charLoggedIn() {
        UI.setRootController(R.storyboard.loggerTabBar.instantiateInitialViewController())
    }
}

