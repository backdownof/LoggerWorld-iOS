//
//  CharacterCreationViewController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 04.11.2020.
//

import UIKit

class CharacterCreationViewController: UIViewController, SocketManagerDelegate{
    
    @IBOutlet weak var createdCharactersTableView: UITableView!
    
    @IBOutlet weak var nicknameField: UITextField!
    @IBOutlet weak var selectedClassLabel: UILabel!
    
    var classSelected = ""
    var socketManager = SocketManager.shared.socket!
    
    var createdCharacters: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.createdCharactersTableView.register(UITableViewCell.self, forCellReuseIdentifier: Constants.Cell.createdCharacters)
        
        createdCharactersTableView.delegate = self
        createdCharactersTableView.dataSource = self
    }
    
    @IBAction func classSelectedPressed(_ sender: Any) {
        var button = sender as! UIButton
        classSelected = button.titleLabel!.text!
        if classSelected != "" {
            selectedClassLabel.text = classSelected
        }
    }
    
    // TODO: Обработать ошибки создания персонажа
    @IBAction func createButtonTapped(_ sender: Any) {
        let nickname = nicknameField.text!
        if classSelected != "" && nickname != "" {
            
            let charCreate = CreateChar(command: "create_char", args: Char(charName: nickname, className: classSelected))

            let encoder = JSONEncoder()
            let data = try! encoder.encode(charCreate)
            print(String(data: data, encoding: .utf8))
            
            socketManager.write(data: data)
        }
    }
    
    func dataReceived(data: String) {
        if data.contains("create_char") {
            let dataString: Data? = data.data(using: .utf8)
            guard let string = dataString else {return}
            let created: CharIsCreated = try! JSONDecoder().decode(CharIsCreated.self, from: string)
            if created.create_char == "True" {
                performSegue(withIdentifier: Constants.Segue.selectedCharWhenLogin, sender: nil)
            }
        }
    }
    
}

extension CharacterCreationViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let nicknames = createdCharacters else { return 0 }
        return nicknames.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: UITableViewCell = createdCharactersTableView.dequeueReusableCell(withIdentifier: Constants.Cell.createdCharacters)!
        guard let nicknames = createdCharacters else { return cell}
        cell.textLabel?.text = nicknames[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print(1)
        if let char = tableView.cellForRow(at: indexPath)?.textLabel?.text {
            print(2)
            let charSelected = SelectChar(command: "select_char_to_player", args: char)

            let encoder = JSONEncoder()
            let data = try! encoder.encode(charSelected)
            print(String(data: data, encoding: .utf8))
            
            socketManager.write(data: data)
        }
    }
}
