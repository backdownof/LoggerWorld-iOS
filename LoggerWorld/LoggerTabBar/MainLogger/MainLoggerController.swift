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
    
    let currentLocationSubview = UIView()
    let currentLocationTitle = UILabel()
    
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
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        view.bringSubviewToFront(currentLocationSubview)
        currentLocationSubview.dropShadow(color: R.color.brown()!, offSet: CGSize(width: 0, height: 3))
    }
    
    private func setupView() {
        view.addSubview(currentLocationSubview)
        currentLocationSubview.translatesAutoresizingMaskIntoConstraints = false
        currentLocationSubview.backgroundColor = R.color.creame()
        NSLayoutConstraint.activate([
            currentLocationSubview.widthAnchor.constraint(equalTo: logsTableView.widthAnchor, multiplier: 1),
            currentLocationSubview.heightAnchor.constraint(equalToConstant: 25),
            currentLocationSubview.topAnchor.constraint(equalTo: logsTableView.topAnchor),
            currentLocationSubview.leadingAnchor.constraint(equalTo: logsTableView.leadingAnchor)
        ])
        
        charStatusBar.charAvatar.classId = 1
        charStatusBar.charAvatar.characterStatus = .defaultStatus
        
//        currentLocationSubview.dropShadow(color: UIColor.black, opacity: 1, offSet: CGSize(width: 0, height:-3), radius: 0, scale: false)
        
        currentLocationTitle.font = R.font.alegreyaSCBold(size: 16)
        currentLocationTitle.textColor = R.color.brown()
        
        currentLocationSubview.addSubview(currentLocationTitle)
        currentLocationSubview.bringSubviewToFront(currentLocationTitle)
        
        currentLocationTitle.translatesAutoresizingMaskIntoConstraints = false
        currentLocationTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        currentLocationTitle.centerXAnchor.constraint(equalTo: currentLocationSubview.centerXAnchor).isActive = true
        currentLocationTitle.centerYAnchor.constraint(equalTo: currentLocationSubview.centerYAnchor).isActive = true
        
        logsTableView.separatorColor = R.color.brown()
        logsTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        playersNearTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension MainLoggerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
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

            guard let playersInLoc = playersInLocation else { return UITableViewCell() }
            
            let level = playersInLoc[indexPath.row].level ?? 0
            let name = playersInLoc[indexPath.row].name ?? ""
            let id = playersInLoc[indexPath.row].classId ?? 1
            
            cell.levelLabel.text = "\(level) лвл"
            cell.shordNicknameLabel.text = "\(name.prefix(3))"
            print("____ \(playersInLoc[indexPath.row].id)")
            cell.classId = id
            cell.charsAvatarImageView.characterStatus = .defaultStatus
            return cell
        }
        return UITableViewCell()
    }
}

extension MainLoggerController: SocketManagerDelegate {
    func updatedLocationInfo(info: LocationInfo) {
        playersInLocation = info.players
        if let locID = info.locationId {
            currentLocationTitle.text = LocationService.shared.getNameById(id: locID)
        }
    }
}
