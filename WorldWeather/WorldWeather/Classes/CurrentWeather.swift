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
    
    
    func downloadWeatherDetails(completed: @escaping DownloadComplete){
        
        
        let currentWeatherURL = URL(string: CURRENT_WEATHER_URL_CITY_NAME)!
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
                
                if let date = dict["dt"] as? Double {
                    let dateFromUnix = Date(timeIntervalSince1970: date)
                    self._date = dateFromUnix.dayOfTheWeek()
                    print(self._date)
                }
                
                if let main = dict["main"] as? Dictionary<String, AnyObject>{
                    
                    if let currentTemperature = main["temp"] as? Double {
                        self._currentTemperature = currentTemperature.convertKelvinToDegree()
                    }
                }
                completed()
            }
        }
    }
}

extension Double {
    
    func convertKelvinToDegree() -> String {
        return String(format: "%.0f", self - 272.15)
    }
    
}
