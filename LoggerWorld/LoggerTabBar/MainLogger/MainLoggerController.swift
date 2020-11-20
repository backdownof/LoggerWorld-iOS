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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        logsTableView.delegate = self
        logsTableView.dataSource = self
        
        playersNearTableView.delegate = self
        playersNearTableView.dataSource = self
        
        setupView()
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
        logsTableView.separatorColor = R.color.brown()
        logsTableView.separatorInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        playersNearTableView.separatorInset = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5)
    }
}

extension MainLoggerController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30
    }
}

extension MainLoggerController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == logsTableView {
            return 10
        }
        if tableView == playersNearTableView {
            return 20
        }
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if tableView == logsTableView {
            let cell = UITableViewCell()
            return cell
        }
        if tableView == playersNearTableView {
            let cell = UITableViewCell()
            return cell
        }
        return UITableViewCell()
    }
    
    
}
