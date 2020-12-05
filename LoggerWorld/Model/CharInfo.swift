//
//  CharListToLogin.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 14.11.2020.
//

import UIKit

class CharInfo {
    var classType: String?{
        didSet {
            if classType == "mage" {
                classImage = R.image.mageImage()
                classColor = R.color.green()
            }
            
        }
    }
    var classImage: UIImage?
    var classColor: UIColor?
    var charName: String = "Василиск123"
    var charLocation: String = "Прибрежная деревня"
    var charLvl: Int = 5
    
    init(classType: String, charName: String, charLocation: String, charLvl: Int) {
        self.classType = classType
        self.charName = charName
        self.charLocation = charLocation
        self.charLvl = charLvl
    }
}
