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

    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var currentWeatherCollectionView: UICollectionView!
    
    @IBOutlet weak var imageViewBackground : UIImageView!
    
    private let locationManager = CLLocationManager()
    private var currentLocation: CLLocation!
    var currentWeather: CurrentWeather!
    private var forestcastWeather: Forecast!
    var selectedCities: [Int]!
    fileprivate var forecastArray = [Forecast]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }
    
    func setup(){
        imageViewBackground.shouldHaveOverlay()
        currentWeatherCollectionView.delegate = self
        locationManager.delegate = self
        currentWeather = CurrentWeather()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
        selectedCities = UserDefaults.standard.array(forKey: "selectedCities") as? [Int]
        
        if let cities = selectedCities{
            pageControl.numberOfPages = cities.count
            getCurrentLocationByCity(city: (pageControl.currentPage > 0) ? pageControl.currentPage : 0)
        } else {
            selectedCities = [Int]()
            pageControl.numberOfPages = 0
            getCurrentWeatherByLocation()
        }
    }
    
    func getCurrentWeatherByLocation() {
        var weatherService: WeatherServices!
        locationManager.locationAuthStatus { location in
            weatherService = WeatherServices(currentLocation: location)
            getCurrentWeather(weatherService: weatherService)
        }
    }
    
    func getCurrentLocationByCity(city: Int) {
        if let listOfCities = selectedCities {
            let weatherService = WeatherServices(city: "\(listOfCities[city])")
            getCurrentWeather(weatherService: weatherService)
        }
    }

    func getCurrentWeather(weatherService: WeatherServices) {
        weatherService.getCurrentWeather(completed: { wrapper in
            self.currentWeather = wrapper
            weatherService.getForecastWeather(completed: { forecastData in
                self.forecastArray = forecastData
                self.updateMainUI()
            })
        })
    }
    
    func updateMainUI() {
        forecastCollectionView.reloadData()
        currentWeatherCollectionView.reloadData()
    }

    @IBAction func openCitiesListButtonPressed(_ sender: Any) {
    
        if let citiesViewController = storyboard?.instantiateViewController(withIdentifier: CitiesViewControllerIdentifier) as? CitiesVC {
            citiesViewController._selectedCities = selectedCities
            navigationController?.pushViewController(citiesViewController, animated: true)
        }
        
    }
}


//MARK: UICollectionViewDataSource

extension WeatherVC: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if (collectionView == currentWeatherCollectionView && selectedCities.count > 0) {
            return selectedCities.count
        } else if (collectionView == currentWeatherCollectionView && selectedCities.count == 0 && currentWeather != nil) {
            return 1;
        } else {
            return forecastArray.count - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == currentWeatherCollectionView {
            if let cityWeatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-currentCityWeather", for: indexPath) as? CurrentCityWeatherCell {
                cityWeatherCell.configureCell(currentWeather: currentWeather)
                
                return cityWeatherCell
            }
        } else {
            
            if let weatherCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell-weather", for: indexPath) as? WeatherCell {
                weatherCell.configureCell(weather: forecastArray[indexPath.row + 1])
                return weatherCell
            }
        }
    
        return UICollectionViewCell()
    }
    
}

//MARK: UICollectionVieeDelegate

extension WeatherVC: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = currentWeatherCollectionView.bounds.size.width;
        let currentPage = currentWeatherCollectionView.contentOffset.x / pageWidth;
    
        getCurrentLocationByCity(city: Int(currentPage))
        pageControl.currentPage = (0.0 != fmodf(Float(currentPage), 1.0)) ? Int(currentPage + 1) : Int(currentPage)
        
    }
    
}

//MARK: UICollectionViewDelegateFlowLayout

extension WeatherVC: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if collectionView == currentWeatherCollectionView {
            return collectionView.bounds.size
        }
        
        return CGSize(width: 100, height: 100)
        
    }
    
}




