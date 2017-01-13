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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Alamofire.request("http://date.jsontest.com/").responseJSON { response in
            debugPrint(response.result.value ?? "Empty response")
        }
        
        
    }
    
    
    
    
}
