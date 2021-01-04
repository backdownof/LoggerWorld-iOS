//
//  Map.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 03.12.2020.
//

import UIKit

protocol MapDelegate {
    func mapIsClosed()
}

class LocationsMap: UIView {
    @IBOutlet weak var mapScrollView: UIScrollView!
    @IBOutlet weak var topMapView: UIView!
    @IBOutlet weak var youAtLocationLabel: UILabel!
    @IBOutlet weak var currentLocationIcon: UIImageView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var selectedLocationLabel: UILabel!
    @IBOutlet weak var selectedLocationIcon: UIImageView!
    @IBOutlet weak var selectedLocationPathLabel: UILabel!
    @IBOutlet weak var mapCellsCollectionView: UICollectionView!
    @IBOutlet weak var goButton: UIButton!
    
//    var locsXcoord: [[LocationNameAndCoords]] = []
    var locations: [WorldMapModel] = []
    var maxXcoord = 0
    var maxYcoord = 0
//    let collectionReusableIdentifier = "mapCollection"
    var currentLocationCell: MapCell?
    var selectedLocationCellId: Int = 0
    
    var mapDelegate: MapDelegate?
    
    override func awakeFromNib() {
        setupMapView()
        mapCellsCollectionView.delegate = self
        mapCellsCollectionView.dataSource = self
        mapCellsCollectionView.register(UINib(nibName: R.nib.mapCell.name, bundle: nil), forCellWithReuseIdentifier: R.nib.mapCell.name)
        selectedLocationLabel.text = "Выберите локацию"
    }
    
    func set(status: String, title: String, buttonTitle: String) {
    }
    
    func setupMapView() {
        let worldMapData = LocationManager.shared.getWorldMap()
        locations = worldMapData.0
        maxXcoord = worldMapData.1
        maxYcoord = worldMapData.2
        
        mapView.widthAnchor.constraint(equalToConstant: CGFloat(maxYcoord * 60)).isActive = true
        mapView.heightAnchor.constraint(equalToConstant: CGFloat(maxYcoord * 60)).isActive = true
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
        mapDelegate?.mapIsClosed()
        currentLocationCell?.mapCellImageView.image = nil
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
        if selectedLocationCellId != 0 {
            SocketManager.shared.playerMoveToAnotherLocation(locationId: selectedLocationCellId)
            mapDelegate?.mapIsClosed()
            currentLocationCell!.mapCellImageView.image = nil   
        }
    }
}

extension LocationsMap: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellWidth = 60
        let cellHeight = 60

        return CGSize(width: cellWidth, height: cellHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! MapCell
        guard let locId = cell.locInfo?.id else { return }
        selectedLocationLabel.text = "\(LocationManager.shared.getNameById(id: locId))"
        selectedLocationCellId = (cell.locInfo?.id)!
    }
}


// TODO: - Сделать персонажа полупрозрачным, когда в пути
// TODO: - Запомнить выбранную локацию, и при развороте экрана снова выбрать
extension LocationsMap: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxYcoord * maxXcoord
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mapCellsCollectionView.dequeueReusableCell(withReuseIdentifier: R.nib.mapCell.name, for: indexPath) as! MapCell
        cell.locInfo = locations[indexPath.row]
        
        if cell.locInfo?.id == LocationManager.shared.locationInfo?.locationId {
            currentLocationCell = cell
            youAtLocationLabel.text = "Вы в \(LocationManager.shared.getNameById(id: cell.locInfo!.id))"
            
            if LocationManager.shared.characterInMove == false {
                cell.mapCellImageView.image = UIImage.getCharImage(classId: ActiveCharacter.shared.info.classId)
            }
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) { // Change `2.0` to the desired number of seconds.
            collectionView.deselectItem(at: indexPath, animated: true)
        }
    }
}
