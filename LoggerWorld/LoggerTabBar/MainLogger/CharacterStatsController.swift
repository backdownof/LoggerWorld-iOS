//
//  CharacterStatsController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 05.12.2020.
//

import UIKit

class CharacterStatsController: ViewController {

    @IBOutlet weak var avatarView: CharacterAvatar!
    @IBOutlet weak var nicknameLabel: UILabel!
    @IBOutlet weak var classLabel: UILabel!
    @IBOutlet weak var levelNumberLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
//    let stats: [String : [String: String]] = [
//        "Основные:": [
//            "Здоровье:" : "0",
//            "Мана:" : "0",
//            "Урон:" : "0",
//            "Защита:" : "0",
//            "Критический шанс:" : "0",
//            "Уклонение:" : "0",
//            "Скорость атаки:" : "0",
//        ],
//        "Атрибуты:": [
//            "STR:" : "10",
//            "CON:" : "10",
//            "AGI:" : "10",
//            "INT:" : "10",
//            "Нераспределенные очки:" : "10"
//        ]
//    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

}

//extension CharacterStatsController: UITableViewDelegate, UITableViewDataSource {
//    func numberOfSections(in tableView: UITableView) -> Int {
//        return 1//stats.count
//    }
//    
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return 0//stats[section].count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        return UITableViewCell()
//    }
//}
