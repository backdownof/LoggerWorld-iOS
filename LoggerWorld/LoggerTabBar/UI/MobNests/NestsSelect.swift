//
//  NestsSelect.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 09.12.2020.
//

import UIKit

protocol NestsDelegate {
    func nestsViewClosed()
}

class NestsSelect: UIView {
    
    @IBOutlet weak var tableView: UITableView!
    
    
    var tableViewReuseIdentifier = "tableViewCell"
    var mobsNests: [MobNests]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    var delegate: NestsDelegate?
    
    override func awakeFromNib() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.nib.nestCell.name, bundle: nil), forCellReuseIdentifier: tableViewReuseIdentifier)
    }
    
    @IBAction func closeButtonPressed(_ sender: Any) {
        print("Close nests pressed")
        print("Nest delegate is \(delegate)")
        delegate?.nestsViewClosed()
    }
    
    @IBAction func cancelFightBtnPressed(_ sender: Any) {
        
    }
    
    @IBAction func atackBtnPressed(_ sender: Any) {
        let cells = self.tableView.visibleCells as! Array<NestCell>
        var selectedNestsIds: [Int] = []
        
        for cell in cells {
            guard let selectedStateForNest = cell.selectedState else { return }
            if selectedStateForNest {
                guard let nestId = cell.nest?.id else { continue }
                selectedNestsIds.append(nestId)
            }
        }
        
        guard selectedNestsIds.count != 0 else { return }
        for id in selectedNestsIds {
            print(id)
            SocketManager.shared.kickNest(nestId: id)
        }
        delegate?.nestsViewClosed()
    }
}

extension NestsSelect: UITableViewDelegate {
    
}

extension NestsSelect: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return mobsNests.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: tableViewReuseIdentifier, for: indexPath) as! NestCell
        cell.avatarView.avatarImage = R.image.mobGrayRat()
        cell.nest = mobsNests[indexPath.row]
        return cell
    }
    
    
}
