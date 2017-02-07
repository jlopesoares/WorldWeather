//
//  Forecast.swift
//  WorldWeather
//
//  Created by João Soares on 07/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation


class Forecast {
    
    var _minTemp: String!
    var _maxTemp: String!
    var _date: String!
    var _weatherType: String!
    
    var minTemp: String {
        if _minTemp == nil{
            _minTemp = ""
        }
        return _minTemp
    }
    
    var maxTemp: String {
        if _maxTemp == nil{
            _maxTemp = ""
        }
        return _minTemp
    }
    
    var date: String {
        if _date == nil{
            _date = ""
        }
        return _date
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    init(weatherDict: Dictionary<String, AnyObject>) {
    
        if let temp = weatherDict["temp"] as? Dictionary<String, AnyObject> {
            
            if let min = temp["temp_min"] as? Double {
                _minTemp = min.convertKelvinToDegree()
            }
            
            if let max = temp["temp_max"] as? Double {
                _maxTemp = max.convertKelvinToDegree()
            }
            
        }
        
//        if let weather = weatherDict[0]["weather"] as? [Dictionary<String, AnyObject>] {
//            
//            if let main = weather["main"] as? String {
//                
//            }
//            
//        }
    }
}






