//
//  CurrentWeather.swift
//  WorldWeather
//
//  Created by João Soares on 16/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit
import Alamofire

class CurrentWeather {
    
    var _cityName: String!
    var _date: String!
    var _wheatherType: String!
    var _currentTemperature: Double!
    
    
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
    
    var currentTemperature: Double {
        if _currentTemperature == nil {
            _currentTemperature = 0.0
        }
        return _currentTemperature
    }
    
    
    func downloadWeatherDetails(completed: DownloadComplete){
        
        
        let currentWeatherURL = URL(string: "")!
        Alamofire.request(currentWeatherURL).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject>{
                
                if let name = dict["name"] as? String {
                    self._cityName = name
                    print(self._cityName)
                }
                
                if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                    
                    if let main = weather[0]["main"] as? String {
                        self._wheatherType = main.capitalized
                        print(self._wheatherType)
                    }
                }
                
                if let date = dict["date"] as? String {
                    self._date = date
                    print(self._date)
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    
                    if let currentTemperature = main["temp"] as? Double {
                        
                        let kelvinToDegree = currentTemperature - 273.15
                        self._currentTemperature = kelvinToDegree
                        print(self._currentTemperature)
                    }
                    
                }
            }
        }
    }
}
