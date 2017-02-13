//
//  City.swift
//  WorldWeather
//
//  Created by João Soares on 13/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation

class City {
    
    var _name: String!
    var _identifier: Int!
    var _country: String!
    var _latitude: Double!
    var _longitude: Double!
    
    var name: String {
        if _name == nil {
            _name = ""
        }
        return _name
    }
    
    var identifier: Int {
        if _identifier == nil {
            _identifier = 0
        }
        return _identifier
    }

    var country: String {
        if _country == nil {
            _country = ""
        }
        return _country
    }

    var latitude: Double {
        if _latitude == nil {
            _latitude = 0.0
        }
        return _latitude
    }

    var longitude: Double {
        if _longitude == nil {
            _longitude = 0.0
        }
        return _longitude
    }

    init(name: String, identifier: Int, country: String, latitude: Double, longitude: Double) {
        _name = name
        _identifier = identifier
        _country = country
        _latitude = latitude
        _longitude = longitude
    }
    
}
