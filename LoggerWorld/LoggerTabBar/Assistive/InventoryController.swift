//
//  AssistiveController.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 19.11.2020.
//

import UIKit

class InventoryController: UIViewController {
    
    @IBOutlet var equipedInventoryCell: [UIControl]!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var inventoryCells: [SlotMap] = [] {
        didSet {
            collectionView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = self
        collectionView.delegate = self
        
        SocketManager.shared.inventoryDelegate = self
        SocketManager.shared.equipmentDelegate = self
        collectionView.register(UINib(nibName: R.nib.inventoryCell.name, bundle: nil), forCellWithReuseIdentifier: R.nib.inventoryCell.name)
        
        setupView()
        for cell in equipedInventoryCell {
//            cell.addGestureRecognizer(UIGestureRecognizer(target: self, action: #selector(self.)))
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        SocketManager.shared.loadInventory()
        SocketManager.shared.loadEquiped()
    }
    
    func setupView() {}
}

extension InventoryController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: R.nib.inventoryCell.name, for: indexPath) as! InventoryCell
        guard indexPath.row < inventoryCells.count else { return cell }
        let slot = inventoryCells[indexPath.row]
        cell.item = slot
        return cell
    }
}

extension InventoryController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let item = (collectionView.cellForItem(at: indexPath) as! InventoryCell).item else { return }
        let itemDetailVC = ItemDetailController(item: item)
        itemDetailVC.modalPresentationStyle = .popover
        self.present(itemDetailVC, animated: true, completion: nil)
    }
}

extension InventoryController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = (collectionView.bounds.width - 40)/5.0
        let yourHeight = yourWidth

        return CGSize(width: yourWidth, height: yourHeight)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 10
    }
}

extension InventoryController: InventoryDelegate {
    func inventoryReceived(items: InventoryMap) {
        inventoryCells = items.slots
    }
}

extension InventoryController: EquipmentDelegate {
    func equipmentReceived(items: EquipmentMap) {
        for cell in equipedInventoryCell {
            guard let cellId = cell.accessibilityIdentifier else { continue }
//            print(items.slots)
            switch cellId {
            case Slots.RIGHT_ARM.rawValue:
                guard items.slots.rightArm != nil else { continue }
                let equipmentView = UIView()
                cell.addSubview(equipmentView)
                let imageForSlot = UIImageView()
                cell.addSubview(imageForSlot)
                
                imageForSlot.image = R.image.icWarSword()
                imageForSlot.translatesAutoresizingMaskIntoConstraints = false
                imageForSlot.widthAnchor.constraint(equalTo: cell.widthAnchor, multiplier: 0.85).isActive = true
                imageForSlot.heightAnchor.constraint(equalTo: cell.heightAnchor, multiplier: 0.85).isActive = true
                imageForSlot.centerXAnchor.constraint(equalTo: cell.centerXAnchor).isActive = true
                imageForSlot.centerYAnchor.constraint(equalTo: cell.centerYAnchor).isActive = true
                // TODO: Fix - not displaying shadow
                imageForSlot.addShadow(to: [.top, .left], radius: 8.0)
                imageForSlot.backgroundColor = R.color.darkBrown()
            default:
                continue
            }
        }
    }
}
