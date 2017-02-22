//
//  CurrentCityWeatherCell.swift
//  WorldWeather
//
//  Created by João Soares on 21/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit

class CurrentCityWeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTypeLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var currentDayLabel: UILabel!
    
    
    func configureCell(currentWeather: CurrentWeather) {
        
        temperatureLabel.text = currentWeather.currentTemperature
        cityLabel.text = currentWeather.cityName
        currentDayLabel.text = currentWeather.date
        weatherTypeImageView.image = UIImage(named: currentWeather.weatherType)
    
    }
    
}
