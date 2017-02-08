//
//  WeatherCell.swift
//  WorldWeather
//
//  Created by João Soares on 08/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit

class WeatherCell: UICollectionViewCell {
    
    @IBOutlet weak var labelWeekDay: UILabel!
    @IBOutlet weak var imageViewWeatherType: UIImageView!
    @IBOutlet weak var labelMinTemperature: UILabel!
    @IBOutlet weak var labelMaxTemperature: UILabel!

    
    func configureCell(weather: Forecast) {
        labelWeekDay.text = weather.date
        labelMinTemperature.text = weather.minTemp
        labelMaxTemperature.text = weather.maxTemp
        imageViewWeatherType.image = UIImage(named: weather.weatherType)        
    }
    
    
}
