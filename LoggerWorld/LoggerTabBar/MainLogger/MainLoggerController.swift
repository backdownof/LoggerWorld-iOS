//
//  MainLoggerController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 19.11.2020.
//

import UIKit
import OSLog

class MainLoggerController: UIViewController {

    @IBOutlet weak var charStatusBar: CharStatusBar!
    @IBOutlet weak var leftButton: ButtonWImage!
    @IBOutlet weak var middleButton: ButtonWImage!
    @IBOutlet weak var rightButton: ButtonWImage!
    @IBOutlet weak var logsTableView: UITableView!
    @IBOutlet weak var playersNearTableView: UITableView!
    @IBOutlet var logsTypeSelectButton: [UIButton]!
    @IBOutlet weak var aimsCollectionView: UICollectionView!
    
    private lazy var mapView: LocationsMap = {
        let mapView: LocationsMap = LocationsMap.loadFromNib()
        return mapView
    }()
    
    private lazy var nestsView: NestsSelect = {
        let nestsView: NestsSelect = NestsSelect.loadFromNib()
        return nestsView
    }()
    
    let visualEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let view = UIVisualEffectView(effect: blurEffect)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let currentLocationSubview = UIView()
    let currentLocationTitle = UILabel()
    
    var playersInLocation: [PlayersInLocation]? = LocationManager.shared.locationInfo?.players {
        didSet {
            playersNearTableView.reloadData()
        }
    }
    
    var allLogsMessages: [LogMessage] = [] {
        didSet {
            logsTableView.reloadData()
        }
    }
    
    var fightLogsMessages: [LogMessage] = [] {
        didSet {
            logsTableView.reloadData()
        }
    }
    
    var inventoryLogsMessages: [LogMessage] = [] {
        didSet {
            logsTableView.reloadData()
        }
    }
    
    var logsToDisaply: [LogMessage]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        
        playersNearTableView.register(UINib(nibName: R.nib.charsInLocationCell.name, bundle: nil), forCellReuseIdentifier: "charInLocation")
        logsTableView.register(UINib(nibName: R.nib.logCell.name, bundle: nil), forCellReuseIdentifier: "logCell")
        aimsCollectionView.register(UINib(nibName: R.nib.aimCell.name, bundle: nil), forCellWithReuseIdentifier: R.nib.aimCell.name)
        
        logsTableView.delegate = self
        logsTableView.dataSource = self
        
        playersNearTableView.delegate = self
        playersNearTableView.dataSource = self
        
        LocationManager.shared.delegate = self
        rightButton.delegate = self
        middleButton.delegate = self
        
        mapView.mapDelegate = self
        
        nestsView.delegate = self
        SocketManager.shared.messageDelegate = self
        
        loadCharacterLogs()
        logsToDisaply = allLogsMessages
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(handleStatusBarTap(sender:)))
        charStatusBar.addGestureRecognizer(tapGesture)
    }
    
    @objc func handleStatusBarTap(sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: R.segue.mainLoggerController.segueStatusBarStats.identifier, sender: self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: false)
        
        logsTableView.backgroundColor = .clear
        logsTableView.backgroundView = UIImageView(image: R.image.backgroundFrame())
        logsTableView.backgroundView?.contentMode = .scaleToFill
        logsTableView.backgroundView?.clipsToBounds = true
        logsTableView.transform = CGAffineTransform(scaleX: 1, y: -1)
        
        playersNearTableView.backgroundColor = .clear
        playersNearTableView.backgroundView?.contentMode = .scaleToFill
        playersNearTableView.backgroundView?.clipsToBounds = true
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        currentLocationSubview.dropShadow(color: R.color.brown()!, offSet: CGSize(width: 0, height: 3))
    }
    
    private func setupView() {
        view.addSubview(currentLocationSubview)
//        allLogTypesDeselected()
        
        currentLocationSubview.translatesAutoresizingMaskIntoConstraints = false
        currentLocationSubview.backgroundColor = R.color.creame()
        NSLayoutConstraint.activate([
            currentLocationSubview.widthAnchor.constraint(equalTo: logsTableView.widthAnchor, multiplier: 1),
            currentLocationSubview.heightAnchor.constraint(equalToConstant: 25),
            currentLocationSubview.topAnchor.constraint(equalTo: logsTableView.topAnchor),
            currentLocationSubview.leadingAnchor.constraint(equalTo: logsTableView.leadingAnchor)
        ])
        
        charStatusBar.charAvatar.characterStatus = .defaultStatus
        
        currentLocationTitle.font = R.font.alegreyaSCBold(size: 16)
        currentLocationTitle.textColor = R.color.brown()
        
        currentLocationSubview.addSubview(currentLocationTitle)
        currentLocationSubview.bringSubviewToFront(currentLocationTitle)
        
        currentLocationTitle.translatesAutoresizingMaskIntoConstraints = false
        currentLocationTitle.heightAnchor.constraint(equalToConstant: 25).isActive = true
        currentLocationTitle.centerXAnchor.constraint(equalTo: currentLocationSubview.centerXAnchor).isActive = true
        currentLocationTitle.centerYAnchor.constraint(equalTo: currentLocationSubview.centerYAnchor).isActive = true
        currentLocationTitle.text = LocationManager.shared.getCurrentLocationName()
        
        logsTableView.separatorColor = R.color.brown()
        logsTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        playersNearTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
        
        rightButton.buttonLabel = "Карта"
        rightButton.iconImage = R.image.icMap()
        
        middleButton.buttonLabel = "Мобы"
        middleButton.iconImage = R.image.icAtack()
        
        setupVisualEffectView()
    }
    
    func setupVisualEffectView() {
        view.addSubview(visualEffectView)
        visualEffectView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        visualEffectView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        visualEffectView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        visualEffectView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        visualEffectView.alpha = 0
    }
    
    @IBAction func didSelectLogsType(_ sender: UIButton) {
        allLogTypesDeselected()
        selectLogType(selectedButton: sender)
        if let selection = selectedLogsTypeIndex() {
            switch selection {
            case 0:
                logsToDisaply = allLogsMessages
                dump(allLogsMessages)
            case 1:
                logsToDisaply = fightLogsMessages
                dump(fightLogsMessages)
            default:
                logsToDisaply = inventoryLogsMessages
                dump(inventoryLogsMessages)
            }
        }
        logsTableView.reloadData()
    }
    
    func loadCharacterLogs() {
        Network.getUserLogs(completion: { [weak self] entries in
            for log in entries {
                self?.addLog(log: log)
            }
            print(self?.logsToDisaply)
        }, failure: {
            // TODO: deal the error getting logs
        })
    }
    
    func addLog(log: LogMessage) {
        switch log.logClass {
        case "LOOT":
            inventoryLogsMessages.append(log)
        case "COMBAT":
            fightLogsMessages.append(log)
        default:
            break
        }
        allLogsMessages.append(log)
        logsToDisaply = allLogsMessages
        print("Some: \(logsToDisaply)")
        logsTableView.reloadData()
    }
    
    func allLogTypesDeselected() {
        for button in logsTypeSelectButton {
            button.isEnabled = true
        }
    }
    
    func selectLogType(selectedButton: UIButton) {
        selectedButton.isEnabled = false
    }
    
    func selectedLogsTypeIndex() -> Int?{
        return logsTypeSelectButton.firstIndex(where: {(button) -> Bool in
                                                button.isEnabled == false})
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
            return logsToDisaply.count
        }
        if tableView == playersNearTableView {
            guard let playersInLocationCount = playersInLocation?.count else { return 0 }
            return playersInLocationCount
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == logsTableView {
            let cell = logsTableView.dequeueReusableCell(withIdentifier: "logCell", for: indexPath) as! LogCell
            cell.message = logsToDisaply[logsToDisaply.count - 1 - indexPath.row]
            cell.transform = CGAffineTransform(scaleX: 1, y: -1)
            return cell
        }
        
        if tableView == playersNearTableView {
            let cell = playersNearTableView.dequeueReusableCell(withIdentifier: "charInLocation", for: indexPath) as! CharsInLocationCell
            cell.charsAvatarImageView.avatarImage = nil
            
            guard let playersInLoc = playersInLocation else { return UITableViewCell() }
            let level = playersInLoc[indexPath.row].level
            let name = playersInLoc[indexPath.row].name
            let id = playersInLoc[indexPath.row].classId
            
            cell.levelLabel.text = "\(level) лвл"
            cell.shordNicknameLabel.text = "\(name.prefix(3))"
            cell.classId = id
            cell.charsAvatarImageView.characterStatus = .defaultStatus
            return cell
        }
        return UITableViewCell()
    }
    
}

extension MainLoggerController: LocationServiceDelegate {
    func locationHasChanged() {
        guard let charInMove = LocationManager.shared.characterInMove else { return }
        
        if charInMove {
            mapView.goButton.isUserInteractionEnabled = false
//            mapView.goButton.alpha = 0.4
        } else {
            mapView.goButton.isUserInteractionEnabled = true
//            mapView.goButton.alpha = 1
        }
        
        currentLocationTitle.text = LocationManager.shared.getCurrentLocationName()
        playersInLocation = LocationManager.shared.playersInLocation
    }
}

// TODO: FIX HERE
extension MainLoggerController: LogsDelegate {
    func messageReceived(log: LogMessage) {
        addLog(log: log)
    }
}

extension MainLoggerController: ButtonWImageDelegate {
    func buttonTapped(_ button: ButtonWImage) {
        if button == rightButton {
            setMapView()
            animateMapIn()
        }
        
        if button == middleButton {
            guard let nests = LocationManager.shared.locationInfo?.mobNests else { return }
            nestsView.mobsNests = nests
            setNestsView()
            animateNestsIn()
        }
        
        if button == leftButton {
//            print(LocationManager.shared.locationInfo?.locationId)
            dump(fightLogsMessages)
            dump(inventoryLogsMessages)
        }
    }
}

// - Settings: Map
extension MainLoggerController: MapDelegate {
    func mapIsClosed() {
        animateMapOut()
    }
    
    func animateMapIn() {
        mapView.mapCellsCollectionView.reloadData()
        mapView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        mapView.alpha = 0
        view.bringSubviewToFront(mapView)
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.mapView.alpha = 1
            self.mapView.transform = CGAffineTransform.identity
        }
    }
    
    func animateMapOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.visualEffectView.alpha = 0
            self.mapView.alpha = 0
            self.mapView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.mapView.removeFromSuperview()
        }
    }
    
    func setMapView() {
        view.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        mapView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}

// - Settings: Nests
extension MainLoggerController: NestsDelegate {
    func nestsViewClosed() {
        animateNestsOut()
    }
    
    func animateNestsIn() {
        nestsView.tableView.reloadData()
        nestsView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        nestsView.alpha = 0
        view.bringSubviewToFront(nestsView)
        
        UIView.animate(withDuration: 0.4) {
            self.visualEffectView.alpha = 1
            self.nestsView.alpha = 1
            self.nestsView.transform = CGAffineTransform.identity
        }
    }
    
    func animateNestsOut() {
        UIView.animate(withDuration: 0.4, animations: {
            self.visualEffectView.alpha = 0
            self.nestsView.alpha = 0
            self.nestsView.transform = CGAffineTransform.init(scaleX: 1.3, y: 1.3)
        }) { (_) in
            self.nestsView.removeFromSuperview()
        }
    }
    
    func setNestsView() {
        view.addSubview(nestsView)
        nestsView.translatesAutoresizingMaskIntoConstraints = false
        nestsView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        nestsView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20).isActive = true
        nestsView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20).isActive = true
    }
}
