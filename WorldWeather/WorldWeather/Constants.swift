//
//  constants.swift
//  WorldWeather
//
//  Created by João Soares on 16/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation


typealias DownloadComplete = () -> ()

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "36760d022429c477270d15cc089ac815"

let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)35\(LONGITUDE)139\(APP_ID)\(APP_KEY)"
