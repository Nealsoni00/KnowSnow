//
//  TownObject.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/24/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation

struct WeatherObject {
    var timeStamp: String
    var icon: String
    var low: String
    var high: String
    var precip: String
    var weekday: String
    let f = DateFormatter()
    
    init(timeStamp: String, icon: String, low: String, high: String, precip: String) {
        self.f.dateFormat = "EEEE, MMMM dd"
        self.timeStamp = timeStamp
        self.weekday = f.weekdaySymbols[(Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: (Double(timeStamp)!)))) - 1]
        self.icon = icon
        self.low = String(format: "%.0f", round(Double(low)!)) + "°"
        self.high = String(format: "%.0f", round(Double(high)!)) + "°"
        self.precip = precip;
        
    }
    
}
