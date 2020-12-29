//
//  ItemDetailController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 28.12.2020.
//

import UIKit

class ItemDetailController: UIViewController {
    
    @IBOutlet weak var itemImage: UIImageView!
    
    var item: SlotMap!

    init(item: SlotMap) {
        self.item = item
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
    }
    
    @IBAction func equipButtonTapped(_ sender: Any) {
        SocketManager.shared.equipItem(itemId: item.id, slotId: 7)
        dismiss(animated: true, completion: nil)
    }
    
    func setupView() {
        switch item?.category {
        case 9:
            itemImage.image = R.image.icWarSword()
        case 5:
            itemImage.image = R.image.gold()
        default:
            break
        }
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
