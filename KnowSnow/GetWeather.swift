//
//  GetWeather.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/24/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

var allWeatherObjects = [WeatherObject]()


class GetWeather {
    
    func getWeather() {
        let lat = String(allTownObjects[4].lat)
        let long = String(allTownObjects[4].long)
        
        
        let link = "https://api.darksky.net/forecast/59091b6f95a4650a6e932c300e9bfbab/" + lat + "," + long
        
        print(lat)
        print(long)
        print(link)
        
        Alamofire.request(link).responseJSON { response in
            
            var j = 1;
            
            while (j <= 4) {
                let decodedJSON = JSON(response.result.value!)
                
                allWeatherObjects.append(WeatherObject(timeStamp: String(describing: decodedJSON["daily"]["data"][j]["time"]), icon: String(describing: decodedJSON["daily"]["data"][j]["icon"]), low: String(describing: decodedJSON["daily"]["data"][j]["temperatureMin"]), high: String(describing: decodedJSON["daily"]["data"][j]["temperatureMax"])));
                
                j += 1;
            }
        }
        
    }
    
}
