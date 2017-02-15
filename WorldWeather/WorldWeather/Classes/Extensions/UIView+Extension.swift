//
//  UIView+Extension.swift
//  WorldWeather
//
//  Created by João Soares on 15/02/2017.
//  Copyright © 2017 OnSoares. All rights reserved.
//

import UIKit

extension UIView {
    
    func shouldBeShadowed() {
        
        let layer = self.layer
        layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 1).cgColor
        layer.shadowOpacity = 1
        layer.shadowOffset = CGSize.zero
        layer.shadowRadius = 1
        
        self.clipsToBounds = false

    }
    
    func shouldHaveOverlay() {
        var overlay = self.viewWithTag(777)
        
        if overlay == nil {
            overlay = UIView(frame: self.bounds)
            overlay!.backgroundColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.5)
            overlay!.tag = 777
            self.addSubview(overlay!)
            
        }

    }
    
    
}
