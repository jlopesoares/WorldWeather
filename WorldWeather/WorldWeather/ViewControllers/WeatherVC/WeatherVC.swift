//
//  WeatherVC.swift
//  WorldWeather
//
//  Created by João Soares on 12/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit
import Alamofire

class WeatherVC: UIViewController, UICollectionViewDataSource {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTypeLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var currentWeather: CurrentWeather!
    var forestcastWeather: Forecast!
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currentWeather = CurrentWeather()
        
        currentWeather.downloadWeatherDetails {
            self.downloadForecastData {
                self.updateMainUI()
            }
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-weather", for: indexPath) as? WeatherCell {
            weatherCell.configureCell(weather: forecastArray[indexPath.row])
            return weatherCell
        }

        return UICollectionViewCell()
    }
    
    func downloadForecastData(completed: @escaping DownloadComplete) {
        //Download forecast data
        
        Alamofire.request(URL(string: FORECAST_WEATHER_URL_CITY_NAME)!).responseJSON { response in
            
            let result = response.result.value
            
            if let dict = result as? Dictionary<String, AnyObject> {
                
                if let list = dict["list"] as? [Dictionary<String, AnyObject>] {
                    
                    for obj in list {
                        let forecast = Forecast(weatherDict: obj)
                        self.forecastArray.append(forecast)
                    }
                }
            }
            
            completed()
            
        }
    }
    
    func updateMainUI() {
        temperatureLabel.text = currentWeather.currentTemperature
        cityLabel.text = currentWeather.cityName
        currentDayLabel.text = currentWeather.date
        weatherTypeImageView.image = UIImage(named: currentWeather.weatherType)
        
        collectionView.reloadData()
        
    }

}
