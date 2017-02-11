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
    @IBOutlet weak var imageViewBackground : UIImageView!
    
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
        
        setup()
        
        
        
        locationManager.locationAuthStatus { location in
            
            let weatherServices = WeatherServices(currentLocation: location)
            
            weatherServices.getCurrentWeather(completed: { wrapper in
                self.currentWeather = wrapper
                
                weatherServices.getForecastWeather(completed: { forecastData in
                    self.forecastArray = forecastData
                    self.updateMainUI()
                })
                
            })
        }
    }
    
    func setup(){
        let overlay = UIView(frame: self.view.bounds)
        overlay.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
        imageViewBackground.addSubview(overlay)
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
