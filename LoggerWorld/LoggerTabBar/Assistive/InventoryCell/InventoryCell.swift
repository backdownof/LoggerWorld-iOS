//
//  InventoryCell.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 28.12.2020.
//

import UIKit

class InventoryCell: UICollectionViewCell {
    
    @IBOutlet weak var itemImageView: UIImageView!
    
    var item: SlotMap? {
        didSet {
            switch item?.category {
            case 9:
                itemImageView.image = R.image.icWarSword()
            case 5:
                itemImageView.image = R.image.gold()
            default:
                break
            }
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func prepareForReuse() {
        itemImageView.image = nil
    }
}
