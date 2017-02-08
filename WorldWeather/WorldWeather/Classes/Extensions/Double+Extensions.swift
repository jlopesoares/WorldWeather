//
//  Double+Extensions.swift
//  WorldWeather
//
//  Created by João Soares on 08/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation

extension Double {
    
    func convertKelvinToDegree() -> String {
        return String(format: "%.0f", self - 272.15)
    }
    
}
