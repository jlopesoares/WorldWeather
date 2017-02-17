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

private let CitiesViewControllerIdentifier = "citiesViewController"

class WeatherVC: UIViewController, CLLocationManagerDelegate {

    @IBOutlet weak var pageControl: UIPageControl!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var temperatureTypeLabel: UILabel!
    @IBOutlet weak var weatherTypeImageView: UIImageView!
    @IBOutlet weak var currentDayLabel: UILabel!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var imageViewBackground : UIImageView!
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    private var currentWeather: CurrentWeather!
    private var forestcastWeather: Forecast!
    var selectedCities: [String]!
    fileprivate var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        imageViewBackground.shouldHaveOverlay()
        
        locationManager.delegate = self
        currentWeather = CurrentWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        
        selectedCities = UserDefaults.standard.array(forKey: "selectedCities") as? [String]
        
        if let cities = selectedCities{
            pageControl.numberOfPages = cities.count
             getCurrentWeather()
        } else {
            selectedCities = [String]()
            pageControl.numberOfPages = 0
            
            locationManager.locationAuthStatus { location in
                currentLocation = location
                getCurrentWeather()
            }
        }
        
    }
    
    func getCurrentWeather() {
        
        var weatherService: WeatherServices!
        
        if let selectedCity = selectedCities.first {
            weatherService = WeatherServices(city: selectedCity)
        } else {
            weatherService = WeatherServices(currentLocation: currentLocation)
        }
        
        weatherService.getCurrentWeather(completed: { wrapper in
            self.currentWeather = wrapper
            weatherService.getForecastWeather(completed: { forecastData in
                self.forecastArray = forecastData
                self.updateMainUI()
            })
        })
    }

    
    func updateMainUI() {
        temperatureLabel.text = currentWeather.currentTemperature
        cityLabel.text = currentWeather.cityName
        currentDayLabel.text = currentWeather.date
        weatherTypeImageView.image = UIImage(named: currentWeather.weatherType)
        
        collectionView.reloadData()
    }

    @IBAction func openCitiesListButtonPressed(_ sender: Any) {
    
        if let citiesViewController = storyboard?.instantiateViewController(withIdentifier: CitiesViewControllerIdentifier) as? CitiesVC {
            citiesViewController._selectedCities = selectedCities
            navigationController?.pushViewController(citiesViewController, animated: true)
        }
        
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
