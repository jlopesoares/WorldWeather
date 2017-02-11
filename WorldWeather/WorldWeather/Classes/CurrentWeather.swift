//
//  CurrentWeather.swift
//  WorldWeather
//
//  Created by João Soares on 16/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _wheatherType: String!
    var _currentTemperature: String!
    
    
    var cityName: String {
        if _cityName == nil {
            _cityName = ""
        }
        return _cityName
    }
    
    var date: String {
        if _date == nil {
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _wheatherType == nil {
            _wheatherType = ""
        }
        return _wheatherType
    }
    
    var currentTemperature: String {
        if _currentTemperature == nil {
            _currentTemperature = ""
        }
        return _currentTemperature
    }
}
