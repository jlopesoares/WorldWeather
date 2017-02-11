//
//  WeatherServices.swift
//  WorldWeather
//
//  Created by João Soares on 11/02/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class WeatherServices {
    
    var currentLocation: CLLocation?
    
    init(currentLocation: CLLocation) {
        self.currentLocation = currentLocation
    }
    
    func getCurrentWeather(completed: @escaping (_: CurrentWeather) -> ()){
        
        if let location = self.currentLocation {
            
            let currentWeatherURL = URL(string: String(format: CURRENT_WEATHER_URL, location.coordinate.latitude, location.coordinate.longitude))!
            Alamofire.request(currentWeatherURL).responseJSON { response in
                
                let result = response.result
                let currentWeatherWrapper = CurrentWeather()
                
                if let dict = result.value as? Dictionary<String, AnyObject>{
                    
                    if let name = dict["name"] as? String {
                        currentWeatherWrapper._cityName = name
                    }
                    
                    if let weather = dict["weather"] as? [Dictionary<String, AnyObject>]{
                        
                        if let main = weather[0]["main"] as? String {
                            currentWeatherWrapper._wheatherType = main.capitalized
                        }
                    }
                    
                    if let date = dict["dt"] as? Double {
                        let dateFromUnix = Date(timeIntervalSince1970: date)
                        currentWeatherWrapper._date = dateFromUnix.dayOfTheWeek(format: "EEEE")
                    }
                    
                    if let main = dict["main"] as? Dictionary<String, AnyObject>{
                        if let currentTemperature = main["temp"] as? Double {
                            currentWeatherWrapper._currentTemperature = currentTemperature.convertKelvinToDegree()
                        }
                    }
                    completed(currentWeatherWrapper)
                }
            }
        }
    }

    func getForecastWeather(completed: @escaping (_ : [Forecast]) -> ()) {
        //Download forecast data
        
        if let location = self.currentLocation {
            
            Alamofire.request(URL(string: String(format: FORECAST_WEATHER_URL, location.coordinate.latitude, location.coordinate.longitude))!).responseJSON { response in
                
                let result = response.result.value
                var forecastArray = [Forecast]()
                if let dict = result as? Dictionary<String, AnyObject> {
                    
                    if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                        
                        for obj in list {
                            let forecast = Forecast(weatherDict: obj)
                            forecastArray.append(forecast)
                        }
                    }
                }
                completed(forecastArray)
            }
        }
    }
}
