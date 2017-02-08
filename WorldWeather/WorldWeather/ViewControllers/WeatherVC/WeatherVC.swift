//
//  WeatherVC.swift
//  WorldWeather
//
//  Created by João Soares on 12/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit
import CoreLocation
import Alamofire

class WeatherVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTypeLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    
    let locationManager = CLLocationManager()
    var currentLocation: CLLocation!
    var currentWeather: CurrentWeather!
    var forestcastWeather: Forecast!
    var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        currentWeather = CurrentWeather()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        locationManager.locationAuthStatus { location in
            currentLocation = location
            
            currentWeather.downloadWeatherDetails(currentLocation: location, completed: { 
                self.downloadForecastData {
                    self.updateMainUI()
                }
            })
        }
    }
    
    func downloadForecastData(completed: @escaping CompleteClosure) {
        //Download forecast data
        
        Alamofire.request(URL(string: String(format: FORECAST_WEATHER_URL, self.currentLocation.coordinate.latitude, self.currentLocation.coordinate.longitude))!).responseJSON { response in
            
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


extension WeatherVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastArray.count - 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-weather", for: indexPath) as? WeatherCell {
            weatherCell.configureCell(weather: forecastArray[indexPath.row + 1])
            return weatherCell
        }
        
        return UICollectionViewCell()
    }
    
}
