//
//  Location+Extensions.swift
//  WorldWeather
//
//  Created by João Soares on 08/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import CoreLocation

extension CLLocationManager {
    
    func locationAuthStatus(completed: (_: CLLocation) -> () ) {
        
        switch CLLocationManager.authorizationStatus() {
        case .authorizedWhenInUse, .authorizedAlways:
            
            if let currentLocation = self.location {
                completed(currentLocation)
            }
            
            break
        default:
            self.requestWhenInUseAuthorization()
            
        }
    }
    
}
