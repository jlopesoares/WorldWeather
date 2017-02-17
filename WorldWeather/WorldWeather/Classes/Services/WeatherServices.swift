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
    var city: String?
    
    init(currentLocation: CLLocation) {
        self.currentLocation = currentLocation
    }
    
    init(city: String) {
        self.city = city
    }
    
    
    func getCurrentWeather(completed: @escaping (_: CurrentWeather) -> ()){
        
        var currentWeatherURL: URL!
        
        if let location = currentLocation {
            currentWeatherURL = URL(string: String(format: CURRENT_WEATHER_URL, location.coordinate.latitude, location.coordinate.longitude))!
        } else if let selectedCity = city {
            currentWeatherURL = URL(string: String(format: CURRENT_WEATHER_URL_CITY_NAME, selectedCity))
        }
        
        Alamofire.request(currentWeatherURL!).responseJSON { response in
            
            completed(self.currentWeatherParse(response: response))
            
        }
    }

    func getForecastWeather(completed: @escaping (_ : [Forecast]) -> ()) {
        //Download forecast data
        
        var forecastWeatherURL: URL!
        
        if let location = currentLocation {
            forecastWeatherURL = URL(string: String(format: FORECAST_WEATHER_URL, location.coordinate.latitude, location.coordinate.longitude))!
        } else {
            forecastWeatherURL = URL(string: String(format: FORECAST_WEATHER_URL_CITY_NAME, city!))
        }
        
        Alamofire.request(forecastWeatherURL).responseJSON { response in
            
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

    func currentWeatherParse(response: DataResponse<Any>) -> CurrentWeather {
        
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
        }
        
        return currentWeatherWrapper
        
    }

}

