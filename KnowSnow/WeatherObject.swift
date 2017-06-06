//
//  TownObject.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/24/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation

struct WeatherObject {
    var timeStamp = String()
    var icon = String()
    var low = String()
    var high = String()
   
    
    init(timeStamp: String, icon: String, low: String, high: String) {
        self.timeStamp = timeStamp;
        self.icon = icon
        self.low = low;
        self.high = high;
        
    }
    
}
