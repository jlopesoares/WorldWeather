//
//  WeatherVC.swift
//  WorldWeather
//
//  Created by João Soares on 12/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTypeLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentWeather: CurrentWeather!
    var forestcastWeather: Forecast!
    var forecastArray: [Forecast()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print(CURRENT_WEATHER_URL)
    
        currentWeather = CurrentWeather()
        forestcastWeather = Forecast()
        
        print(FORECAST_WEATHER_URL)
        
        currentWeather.downloadWeatherDetails { 
            self.updateMainUI()
        }
    }
    
    func downloadForecastData(completed: DownloadComplete) {
        //Download forecast data
        
        Alamofire.request(URL(string: FORECAST_WEATHER_URL)!).responseJSON { response in
            
            let result = response.result
            
            if let dict = result.value as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecastArray.append(forecast)
                    }
                }
            }
        }
    }
    
    func updateMainUI() {
        print("teste")
    }

}
