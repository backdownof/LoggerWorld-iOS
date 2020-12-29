//
//  CharacterStatsController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 05.12.2020.
//

import UIKit

class Stats {
    var type: String?
    var names: [String]?
    
    init(type: String, names: [String]) {
        self.type = type
        self.names = names
    }
}

class CharacterStatsController: ViewController {

    @IBOutlet weak var avatarView: CharacterAvatar!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    var stats = [Stats]()
    
    let stats1: [String : [String: String]] = [
        "Основные:": [
            "Здоровье:" : "0",
            "Мана:" : "0",
            "Урон:" : "0",
            "Защита:" : "0",
            "Критический шанс:" : "0",
            "Уклонение:" : "0",
            "Скорость атаки:" : "0",
        ],
        "Атрибуты:": [
            "STR:" : "10",
            "CON:" : "10",
            "AGI:" : "10",
            "INT:" : "10",
            "Нераспределенные очки:" : "10"
        ]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        stats.append(Stats.init(type: "Основные", names: ["Здоровье", "Мана", "Урон", "Защита", "Критический шанс", "Уклонение", "Скорость атаки"]))
        stats.append(Stats.init(type: "Атрибуты", names: ["STR", "CON", "AGI", "INT", "Нераспределенные очки"]))
        
        tableView.register(UINib(nibName: R.nib.statCell.name, bundle: nil), forCellReuseIdentifier: "statCell")
        
        tableView.separatorColor = R.color.brown()?.withAlphaComponent(0.1)
    }

}

extension CharacterStatsController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return stats.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return stats[section].names?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "statCell", for: indexPath) as! StatCell
        
        cell.statNameLabel.text = "\(stats[indexPath.section].names![indexPath.row]):"
        cell.statValueLabel.text = "0"
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return stats[section].type
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.height, height: 30))
        view.backgroundColor = .clear
        
        let headerLabel = UILabel(frame: CGRect(x: 10, y: 0, width: view.frame.width - 10, height: 30))
        headerLabel.text = stats[section].type
        headerLabel.font = UIFont(name: R.font.alegreyaSCBold.fontName, size: 16)
        headerLabel.textColor = R.color.brown()
        
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 10, y: Int(view.frame.height), width: Int(tableView.frame.width) - 20, height: 1)
        bottomBorder.backgroundColor = R.color.brown()?.cgColor
        
        view.layer.addSublayer(bottomBorder)
        view.addSubview(headerLabel)
        return view
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
}
