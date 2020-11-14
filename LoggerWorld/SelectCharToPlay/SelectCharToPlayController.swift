//
//  SelectCharToPlayController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class SelectCharToPlayController: ViewController, ButtonWOImageDelegate {
    func buttonTapped(_ button: ButtonWOImage) {
        print("enter")
    }
    

    @IBOutlet weak var charactersTableView: UITableView!
    @IBOutlet weak var underView: UIView!
    @IBOutlet weak var enterButton: ButtonWOImage!
    
    var chars: [CharInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        charactersTableView.dataSource = self
        charactersTableView.delegate = self
        enterButton.delegate = self
        setupView()
        
        let char = CharInfo(classType: "mage", charName: "Василиск3", charLocation: "Какая-то деревня", charLvl: 5)
        chars.append(char)
        chars.append(char)
        chars.append(char)
        chars.append(char)
        chars.append(char)
        
        charactersTableView.register(UINib(nibName: R.nib.characterPickCell.name, bundle: nil), forCellReuseIdentifier: R.reuseIdentifier.cellCharacterPick.identifier)
    }
    
    private func setupView() {
        enterButton.label = "Играть"
        charactersTableView.separatorColor = R.color.brown()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        charactersTableView.backgroundColor = .clear
//        let imageView = UIImageView(image: R.image.backgroundFrame())
//        imageView.contentMode = .scaleAspectFit
//        imageView.clipsToBounds = true
        charactersTableView.backgroundView = UIImageView(image: R.image.backgroundFrame())
        charactersTableView.backgroundView?.contentMode = .scaleToFill
        charactersTableView.backgroundView?.clipsToBounds = true
        
//        let imageView = UIImageView(image: R.image.backgroundFrame())
//        imageView.contentMode = .scaleAspectFit
//        underView.addSubview(imageView)
//        underView.contentMode = .scaleToFill
//        underView.clipsToBounds = true
        
        
        charactersTableView.tableFooterView = UIView(frame: CGRect.zero)
        print(underView.frame.size.height)
        underView.frame.size.height = charactersTableView.contentSize.height
        print(underView.frame.size.height)
        print(charactersTableView.frame.size)
        print(charactersTableView.contentSize.height)
//            CGRect(x: charactersTableView.frame.origin.x, y: charactersTableView.frame.origin.y, width: charactersTableView.frame.size.width, height: )
//        charactersTableView.setNeedsDisplay()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.clear
    }
    
    
}


extension SelectCharToPlayController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chars.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = charactersTableView.dequeueReusableCell(withIdentifier: R.reuseIdentifier.cellCharacterPick, for: indexPath) as! CharacterPickCell
        cell.charInfo = chars[indexPath.row]
        
        return cell
    }
}

extension SelectCharToPlayController: UITableViewDelegate {

}
