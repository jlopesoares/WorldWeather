//
//  Date+Extensions.swift
//  WorldWeather
//
//  Created by João Soares on 08/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfTheWeek() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: self)
    }
    
}
