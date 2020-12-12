//
//  NestsSelect.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 09.12.2020.
//

import UIKit

class NestsSelect: UIView {

    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var button: UIButton!
    
    var tableViewReuseIdentifier = "tableViewCell"
    var mobsNests: [MobNests]! {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func awakeFromNib() {
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: R.nib.nestCell.name, bundle: nil), forCellReuseIdentifier: tableViewReuseIdentifier)
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
