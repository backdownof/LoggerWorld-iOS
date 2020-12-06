//
//  Image.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 06.12.2020.
//

import UIKit

extension UIImage {
    static func getCharImage(classId: Int) -> UIImage {
        switch classId {
        case 1:
            return R.image.warriorImage()!
        case 2:
            return R.image.archerImage()!
        case 3:
            return R.image.mageImage()!
        default:
            return R.image.assassinImage()!
        }
    }
}
