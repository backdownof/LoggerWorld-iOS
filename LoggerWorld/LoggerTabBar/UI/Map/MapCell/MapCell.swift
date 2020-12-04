//
//  MapCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 04.12.2020.
//

import UIKit

class MapCell: UICollectionViewCell {
    @IBOutlet weak var mapCellImageView: UIImageView!
    @IBOutlet weak var mapCellBorderView: UIView!
    @IBOutlet weak var tintView: UIView!
    var locInfo: LocationNameAndCoords?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        tintView.isHidden = true
        layer.borderWidth = 1
        layer.borderColor = R.color.brown()?.cgColor
    }
    
    override var isSelected: Bool{
        didSet {
            if self.isSelected {
                super.isSelected = true
                tintView.isHidden = false
            } else {
                super.isSelected = false
                tintView.isHidden = true
            }
        }
    }
}
