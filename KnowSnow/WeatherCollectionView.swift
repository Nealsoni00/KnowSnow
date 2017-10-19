//
//  WeatherCollectionView.swift
//  KnowSnow
//
//  Created by Neal Soni on 10/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit


class WeatherCollectionView:  UICollectionView, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var allWeatherObjects: [WeatherObject]?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return allWeatherObjects!.count
    }
 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "weatherCell", for: indexPath) as! WeatherCell
        cell.high.text = allWeatherObjects![indexPath.row].high
        cell.low.text = allWeatherObjects![indexPath.row].low
        cell.dayOfWeek.text = allWeatherObjects![indexPath.row].weekday
        
        let myColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0)
        cell.layer.cornerRadius = 3
        cell.layer.borderColor = myColor.cgColor
        cell.layer.masksToBounds = true
        cell.layer.shadowColor = UIColor.black.cgColor
        cell.layer.shadowOpacity = 1
        cell.layer.shadowOffset = CGSize.zero
        cell.layer.shadowRadius = 4
        
        switch allWeatherObjects![indexPath.row].icon {
        case "partly-cloudy-day":
            cell.image.image = UIImage(named:  "partly-cloudy-day.png")
        case "partly-cloudy-night":
           cell.image.image = UIImage(named:  "partly-cloudy-day.png")
        case "rain":
            cell.image.image =  UIImage(named:  "rain.png")
        case "cloudy":
            cell.image.image = UIImage(named:  "cloudy.png")
        case "fog":
            cell.image.image =  UIImage(named:  "fog.png")
        case "tornado":
            cell.image.image =  UIImage(named:  "tornado.png")
        case "snow":
            cell.image.image =  UIImage(named:  "snow.png")
        case "thunderstorm":
            cell.image.image =  UIImage(named:  "thunderstorm.png")
        case "clear-day":
            cell.image.image =  UIImage(named:  "clear-day.png")
        case "windy":
            cell.image.image =  UIImage(named:  "windy.png")
        default: break
        }
        return cell
    }
    
}
