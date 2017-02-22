//
//  CityCell.swift
//  WorldWeather
//
//  Created by João Soares on 15/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit

protocol CityCellDelegate {
    func deleteCity(cell: CityCell, city: City)
}

class CityCell: UICollectionViewCell {
    
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var deleteButton: UIButton!
    var delegate: CityCellDelegate?
    var _city: City?
    
    
    func setupCellWith(city: City, editAvailable: Bool) {
        
        _city = city
        
        backgroundImageView.image = UIImage(named: "portugal")
        cityNameLabel.text = city.name
        cityNameLabel.font = UIFont.boldSystemFont(ofSize: 15)
        cityNameLabel.textColor = UIColor.white
        backgroundImageView.shouldHaveOverlay()
        
        editable(editAvailable)
        
    }
    
    func editable(_ editable: Bool) {
        
        deleteButton.isHidden = (editable) ? false : true
        
    }
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
//        if delegate?.responds(to: #selector(deleteCity:cityCell:city:)) {
            delegate?.deleteCity(cell: self, city: _city!)
//        }
        
    }
}
