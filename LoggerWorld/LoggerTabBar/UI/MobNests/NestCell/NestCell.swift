//
//  NestCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 10.12.2020.
//

import UIKit

class NestCell: UITableViewCell {
    
    @IBOutlet weak var avatarView: MobAvatar!
    @IBOutlet weak var nestName: UILabel!
    @IBOutlet weak var nestLevel: UILabel!
    @IBOutlet weak var nestAverageDamage: UILabel!
    @IBOutlet weak var amountMobsInNest: UILabel!
    @IBOutlet weak var checmpionChance: UILabel!
    @IBOutlet weak var mobHealth: UILabel!
    @IBOutlet weak var selectedButton: UIButton!
    
    var selectedState: Bool? {
        didSet {
            //            selectedButton.imageView?.image = selectedState! ? R.image.checkboxOff() : R.image.checkboxOn()
            if selectedState! {
                selectedButton.setImage(R.image.checkboxOn(), for: .normal)
            } else {
                selectedButton.setImage(R.image.checkboxOff(), for: .normal)
            }
        }
    }
    
    var nest: MobNests? {
        didSet {
            if let name = nest?.mobClass {
                nestName.text = name
            }
            
            if let level = nest?.level {
                nestLevel.text = "Уровень: \(level)"
            }
            
            if let amount = nest?.amount {
                amountMobsInNest.text = "Мобов в локации: \(amount)"
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func selectButtonPressed(_ sender: Any) {
        if let selected = selectedState {
            selectedState = !selected
        } else {
            selectedState = true
        }
    }
    
}
