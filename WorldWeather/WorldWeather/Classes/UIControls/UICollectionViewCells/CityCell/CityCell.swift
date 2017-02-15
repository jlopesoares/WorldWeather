//
//  CityCell.swift
//  WorldWeather
//
//  Created by João Soares on 15/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit

class CityCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    
    func setupCell() {
        backgroundImageView.image = UIImage(named: "portugal")
        cityNameLabel.text = "Lisboa"
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cityNameLabel.textColor = UIColor.white
        backgroundImageView.shouldHaveOverlay()
    }
    
}