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
        return _maxTemp
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
            
            if let min = temp["min"] as? Double {
                _minTemp = min.convertKelvinToDegree()
            }
            
            if let max = temp["max"] as? Double {
                _maxTemp = max.convertKelvinToDegree()
            }
            
        }
        
        if let weather = weatherDict["weather"] as? [Dictionary<String, AnyObject>] {
            
            if let main = weather[0]["main"] as? String {
                _weatherType = main
            }
        }
        
        if let date = weatherDict["dt"] as? Double {
            
            let unixConvertedDate = Date(timeIntervalSince1970: date)
            _date = unixConvertedDate.dayOfTheWeek()
            
        }
        
    }
}



extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
}




