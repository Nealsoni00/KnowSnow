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
import SwiftSpinner

var allWeatherObjects = [WeatherObject]()

class GetWeather {
    //    weak var delegate: CompletionProtocol?
    
    
    func getWeather(school : String) {
        let correctObject = allTownObjects.first(where: { $0.fullName == school })
        let lat = String(correctObject!.lat)
        let long = String(correctObject!.long)
        
        let link = "https://api.darksky.net/forecast/59091b6f95a4650a6e932c300e9bfbab/" + lat + "," + long
        
        
        allWeatherObjects.removeAll()
        Alamofire.request(link).responseJSON { response in
            var j = 1;
            
            while (j <= 4) {
                let decodedJSON = JSON(response.result.value!)
                
                allWeatherObjects.append(WeatherObject(timeStamp: String(describing: decodedJSON["daily"]["data"][j]["time"]), icon: String(describing: decodedJSON["daily"]["data"][j]["icon"]), low: String(describing: decodedJSON["daily"]["data"][j]["temperatureMin"]), high: String(describing: decodedJSON["daily"]["data"][j]["temperatureMax"]), precip:String(describing: decodedJSON["daily"]["data"][j]["precipAccumullation"])));
                
                j += 1;
                
            }

            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            
            //UPDATE VC W/ NEW WEATHER
        }
        
    }
    
    //    weak var delegate: CompletionProtocol?
    
    
    func getWeatherInitial() {
        let correctObject = allTownObjects.first(where: { $0.name == school })
        let lat = String(correctObject!.lat)
        let long = String(correctObject!.long)
        
        let link = "https://api.darksky.net/forecast/59091b6f95a4650a6e932c300e9bfbab/" + lat + "," + long
        
        
        
        Alamofire.request(link).responseJSON { response in
            print("getting weather")
            var j = 1;
            
            while (j <= 4) {
                let decodedJSON = JSON(response.result.value!)
                
                allWeatherObjects.append(WeatherObject(timeStamp: String(describing: decodedJSON["daily"]["data"][j]["time"]), icon: String(describing: decodedJSON["daily"]["data"][j]["icon"]), low: String(describing: decodedJSON["daily"]["data"][j]["temperatureMin"]), high: String(describing: decodedJSON["daily"]["data"][j]["temperatureMax"]), precip:String(describing: decodedJSON["daily"]["data"][j]["precipAccumullation"])));
                
                j += 1;
                
            }
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window?.rootViewController = tabBarController
            SwiftSpinner.hide()

        }
        
    }
    
}

