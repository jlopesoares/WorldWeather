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
    var _latitude: String!
    var _longitude: String!
    
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

    var latitude: String {
        if _latitude == nil {
            _latitude = ""
        }
        return _latitude
    }

    var longitude: String {
        if _longitude == nil {
            _longitude = ""
        }
        return _longitude
    }

    init(name: String, identifier: Int, country: String, latitude: String, longitude: String) {
        _name = name
        _identifier = identifier
        _country = country
        _latitude = latitude
        _longitude = longitude
    }
    
    init(city: Dictionary<String, AnyObject>) {
        
        if let identifier = city["_id"] as? Int {
            _identifier = identifier
        }
        
        if let coords = city["coord"] as? Dictionary<String, AnyObject> {
        
            if let lat = coords["lat"] as? String {
                _latitude = lat
            }
            
            if let lon = coords["lon"] as? String {
                _longitude = lon
            }
            
        }
        
        if let country = city["country"] as? String {
            _country = country
        }
        
        if let name = city["name"] as? String {
            _name = name
        }
        
    }
    
    
}
