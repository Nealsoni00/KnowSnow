//
//  weatherDay.swift
//  KnowSnow
//
//  Created by Neal Soni on 10/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation

class WeatherDay: NSObject {
    var lowTemp: Int
    var highTemp: Int
    var weatherGraphic: String
    var date: String?
    var dayOfWeek: String
    init(lowTemp: Int, highTemp: Int, weatherGraphic: String, dayOfWeek: String){
        self.lowTemp = lowTemp
        self.highTemp = highTemp
        self.weatherGraphic = weatherGraphic
        self.dayOfWeek = dayOfWeek
    }

}
