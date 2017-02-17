//
//  constants.swift
//  WorldWeather
//
//  Created by João Soares on 16/01/17.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation


typealias CompleteClosure = () -> ()

let BASE_URL = "http://api.openweathermap.org/data/2.5/weather?"
let LATITUDE = "lat="
let LONGITUDE = "&lon="
let APP_ID = "&appid="
let APP_KEY = "36760d022429c477270d15cc089ac815"
let UNIT_FORMAT_CELCIUS = "&units=metric"
let CITY_NAME = "&q="

let FORECAST_BASE_URL = "http://api.openweathermap.org/data/2.5/forecast/daily?"

let CURRENT_WEATHER_URL_CITY_NAME = "\(BASE_URL)\(CITY_NAME)%@\(APP_ID)\(APP_KEY)"
let FORECAST_WEATHER_URL_CITY_NAME = "\(FORECAST_BASE_URL)\(CITY_NAME)%@\(APP_ID)\(APP_KEY)"



let CURRENT_WEATHER_URL = "\(BASE_URL)\(LATITUDE)%f\(LONGITUDE)%f\(APP_ID)\(APP_KEY)"
let FORECAST_WEATHER_URL = "\(FORECAST_BASE_URL)\(LATITUDE)%f\(LONGITUDE)%f\(APP_ID)\(APP_KEY)"
