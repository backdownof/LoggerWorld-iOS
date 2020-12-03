//
//  Map.swift
//  LoggerWorld
//
//  Created by Anatolii Bogdanov on 03.12.2020.
//

import UIKit

class LocationsMap: UIView {
    @IBOutlet weak var youAtLocationLabel: UILabel!
    @IBOutlet weak var currentLocationIcon: UIImageView!
    @IBOutlet weak var mapView: UIView!
    @IBOutlet weak var selectedLocationLabel: UILabel!
    @IBOutlet weak var selectedLocationIcon: UIImageView!
    @IBOutlet weak var selectedLocationPathLabel: UILabel!
    @IBOutlet weak var mapCellsCollectionView: UICollectionView!
    
    var locsXcoord: [[LocationNameAndCoords]] = []
    var locsYcoord: [LocationNameAndCoords] = []
    var maxXcoord = 0
    var maxYcoord = 0
    let collectionReusableIdentifier = "mapCollection"
    
    override func awakeFromNib() {
        setupMapView()
        mapCellsCollectionView.register(UINib(nibName: R.nib.mapCell.name, bundle: nil), forCellWithReuseIdentifier: collectionReusableIdentifier)
    }
    
    func set(status: String, title: String, buttonTitle: String) {
    }
    
    func setupMapView() {
        guard let locations = LocationService.shared.locations else { return }
        print(locations)
        for location in locations {
            maxXcoord = (location.xcoord! > maxXcoord) ? location.xcoord! : maxXcoord
            maxYcoord = (location.ycoord! > maxYcoord) ? location.ycoord! : maxYcoord
        }
        print("maxXcoord: \(maxXcoord) maxYcoord: \(maxYcoord)")
        
        for x in 0...maxXcoord {
            for y in 0...maxYcoord {
                for loc in locations {
                    if loc.xcoord == x && loc.ycoord == y {
                        locsYcoord.append(loc)
                    }
                }
            }
            locsXcoord.append(locsYcoord)
            locsYcoord = []
        }
        
        
        
        dump(locsXcoord)
    }

    @IBAction func closeButtonTapped(_ sender: Any) {
    }
    
    @IBAction func goButtonPressed(_ sender: Any) {
    }
}

extension LocationsMap: UICollectionViewDelegate {
    
}

extension LocationsMap: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxYcoord * maxXcoord
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = mapCellsCollectionView.dequeueReusableCell(withReuseIdentifier: collectionReusableIdentifier, for: indexPath) as! MapCell
        
    }
    
    
}
