//
//  MainLoggerController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 19.11.2020.
//

import UIKit

class MainLoggerController: UIViewController {

    @IBOutlet weak var charStatusBar: CharStatusBar!
    @IBOutlet weak var leftButton: ButtonWImage!
    @IBOutlet weak var middleButton: ButtonWImage!
    @IBOutlet weak var rightButton: ButtonWImage!
    @IBOutlet weak var logsTableView: UITableView!
    @IBOutlet weak var playersNearTableView: UITableView!
    
//    var locationInfo: LocationInfo? {
//        didSet {
//            if let
//        }
//    }
    var playersInLocation: [PlayersInLocation]? {
        didSet {
            print(1111)
            print(playersInLocation)
            playersNearTableView.reloadData()
        }
    }
    
    var socketManager = SocketManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logsTableView.delegate = self
        logsTableView.dataSource = self
        
        playersNearTableView.delegate = self
        playersNearTableView.dataSource = self
        
        socketManager.delegate = self
        
        setupView()
        playersNearTableView.register(UINib(nibName: R.nib.charsInLocationCell.name, bundle: nil), forCellReuseIdentifier: "charInLocation")
//        charactersTableView.register(UINib(nibName: R.nib.addCharCell.name, bundle: nil), forCellReuseIdentifier: "addCell")
        print(LocationService.shared.getCharsInLocation())
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        logsTableView.backgroundColor = .clear
        logsTableView.backgroundView = UIImageView(image: R.image.backgroundFrame())
        logsTableView.backgroundView?.contentMode = .scaleToFill
        logsTableView.backgroundView?.clipsToBounds = true
        
        playersNearTableView.backgroundColor = .clear
//        playersNearTableView.backgroundView = UIImageView(image: R.image.backgroundFrame())
        playersNearTableView.backgroundView?.contentMode = .scaleToFill
        playersNearTableView.backgroundView?.clipsToBounds = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    private func setupView() {
        guard let mageImage = R.image.mageImage() else { return }
        charStatusBar.charAvatar.avatarImage = mageImage
        
        logsTableView.separatorColor = R.color.brown()
        logsTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        playersNearTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension MainLoggerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 30
//    }
}

extension MainLoggerController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == logsTableView {
            return 10
        }
        if tableView == playersNearTableView {
            guard let playersInLocationCount = playersInLocation?.count else { return 1 }
            return playersInLocationCount
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == logsTableView {
            let cell = UITableViewCell()
            return cell
        }
        if tableView == playersNearTableView {
            let cell = playersNearTableView.dequeueReusableCell(withIdentifier: "charInLocation", for: indexPath) as! CharsInLocationCell
            print(2222)
            guard let someImage = R.image.warriorImage(), let playersInLoc = playersInLocation, let icon = R.image.icWarSword() else { return UITableViewCell() }
            print(3333)
            print(playersInLoc[0].name)
            cell.charsAvatarImageView.avatarImage = someImage
            let level = playersInLoc[indexPath.row].level!
            let name = playersInLoc[indexPath.row].name!
            cell.levelLabel.text = "\(level) лвл"
            cell.shordNicknameLabel.text = "\(name.prefix(3))"
            cell.charClassIcon.image = icon
            cell.charsAvatarImageView.characterStatus = .defaultStatus
            return cell
        }
        return UITableViewCell()
    }
}

extension MainLoggerController: SocketManagerDelegate {
    func updatedLocationInfo(info: LocationInfo) {
        playersInLocation = info.players
    }
}
