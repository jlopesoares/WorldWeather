//
//  Date+Extensions.swift
//  WorldWeather
//
//  Created by João Soares on 08/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import Foundation

extension Date {
    
    func dayOfTheWeek(format dateFormat: String?) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = (dateFormat != nil) ? dateFormat : "EEEE"
        return dateFormatter.string(from: self)
    }
    
}
