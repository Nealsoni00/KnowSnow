//
//  SecondViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 2/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import KDCircularProgress
let defaults = UserDefaults.standard

class SecondViewController: UIViewController {
    

  



    var selectedTown: String?

    @IBOutlet weak var townButton: UIButton!
    @IBOutlet weak var firstProgressText: UILabel!
    
    @IBOutlet weak var secondProgressText: UILabel!
    
    @IBOutlet weak var thirdProgressText: UILabel!
    
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    @IBOutlet weak var low1: UILabel!
    @IBOutlet weak var high4: UILabel!
    @IBOutlet weak var high1: UILabel!
    @IBOutlet weak var high3: UILabel!
    @IBOutlet weak var low3: UILabel!
    @IBOutlet weak var high2: UILabel!
    @IBOutlet weak var low2: UILabel!
    @IBOutlet weak var low4: UILabel!
    var delayInt = Double();
    var closingInt = Double();
    var earlyInt = Double();
    
    
    let school = defaults.string(forKey: "default")
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let correctObject = allTownObjects.first(where: { $0.name == school })
        
        
        let delay = correctObject!.delay
        let closing = correctObject!.closing
        let early = correctObject!.early
        
        firstProgressText.text = delay;
        secondProgressText.text = closing;
        thirdProgressText.text = early;
        
        //delay wheel stuff
        
        
        let indexFirst = delay.index(delay.startIndex, offsetBy: 1)
        let indexSecond = delay.index(delay.startIndex, offsetBy: 2)
        
        if (delay.substring(from: indexFirst) == "%") {
            //single digit percentage
            let intDelay = Double(delay.substring(to: indexFirst))
            delayInt = 360.00 * (intDelay! / 100);
        } else if (delay.substring(from: indexSecond) == "%") {
            //two digit
            let intDelay = Double(delay.substring(to: indexSecond))
            delayInt = 360.00 * (intDelay! / 100);
        } else {
            //100%
            firstProgressText.font = firstProgressText.font.withSize(30)
            let indexThird = delay.index(delay.startIndex, offsetBy: 3)
            let intDelay = Double(delay.substring(to: indexThird))
            delayInt = 360.00 * (intDelay! / 100);
        }
        
        //closing wheel stuff
        
        let indexFirst2 = closing.index(closing.startIndex, offsetBy: 1)
        let indexSecond2 = closing.index(closing.startIndex, offsetBy: 2)
        
        if (closing.substring(from: indexFirst2) == "%") {
            //single digit percentage
            let intClosing = Double(closing.substring(to: indexFirst2))
            closingInt = 360.00 * (intClosing! / 100);
        } else if (closing.substring(from: indexSecond2) == "%") {
            //two digit
            let intClosing = Double(closing.substring(to: indexSecond2))
            closingInt = 360.00 * (intClosing! / 100);
        } else {
            //100%
            secondProgressText.font = secondProgressText.font.withSize(30)
            let indexThird2 = closing.index(closing.startIndex, offsetBy: 3)
            let intClosing = Double(closing.substring(to: indexThird2))
            closingInt = 360.00 * (intClosing! / 100);
        }
        
        //early wheel stuff
        
        let indexFirst3 = early.index(early.startIndex, offsetBy: 1)
        let indexSecond3 = early.index(early.startIndex, offsetBy: 2)
        
        if (early.substring(from: indexFirst3) == "%") {
            //single digit percentage
            let intEarly = Double(early.substring(to: indexFirst3))
            earlyInt = 360.00 * (intEarly! / 100);
        } else if (early.substring(from: indexSecond3) == "%") {
            //two digit
            let intEarly = Double(early.substring(to: indexSecond3))
            earlyInt = 360.00 * (intEarly! / 100);
        } else {
            //100%
            thirdProgressText.font = thirdProgressText.font.withSize(30)
            
            let indexThird3 = early.index(early.startIndex, offsetBy: 3)
            let intEarly = Double(early.substring(to: indexThird3))
            earlyInt = 360.00 * (intEarly! / 100);
        }
        
        
        //INIT CIRCLE
        let progress = KDCircularProgress(frame: CGRect(x: 170, y: 0, width: 140, height: 140))
        let progress2 = KDCircularProgress(frame: CGRect(x: 170, y: 0, width: 140, height: 140))
        let progress3 = KDCircularProgress(frame: CGRect(x: 340, y: 0, width: 140, height: 140))
        
        progress.startAngle = -90
        progress.progressThickness = 0.2
        progress.trackThickness = 0.3
        progress.clockwise = true
        progress.gradientRotateSpeed = 2
        progress.roundedCorners = false
        progress.glowMode = .forward
        progress.glowAmount = 0.9
        progress.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        progress.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        progress.center = CGPoint(x: firstProgressText.center.x, y: firstProgressText.center.y + 150)
        
        progress2.startAngle = -90
        progress2.progressThickness = 0.2
        progress2.trackThickness = 0.3
        progress2.clockwise = true
        progress2.gradientRotateSpeed = 2
        progress2.roundedCorners = false
        progress2.glowMode = .forward
        progress2.glowAmount = 0.9
        progress2.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        progress2.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        progress2.center = CGPoint(x: secondProgressText.center.x, y: secondProgressText.center.y + 150)
        
        progress3.startAngle = -90
        progress3.progressThickness = 0.2
        progress3.trackThickness = 0.3
        progress3.clockwise = true
        progress3.gradientRotateSpeed = 2
        progress3.roundedCorners = false
        progress3.glowMode = .forward
        progress3.glowAmount = 0.9
        progress3.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        progress3.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        progress3.center = CGPoint(x: thirdProgressText.center.x, y: thirdProgressText.center.y + 150)
        
        
        view.addSubview(progress)
        view.addSubview(progress2)
        view.addSubview(progress3)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        progress.animate(fromAngle: 0, toAngle: delayInt, duration: 1) { completed in
        }
        
        progress2.animate(fromAngle: 0, toAngle: closingInt, duration: 1) { completed in
        }
        
        progress3.animate(fromAngle: 0, toAngle: earlyInt, duration: 1) { completed in
        }
        
        
        
        //Add weather stuff
        
        
        
        
        let myColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0)
        

        view1.layer.borderColor = myColor.cgColor
        view2.layer.borderColor = myColor.cgColor
        view3.layer.borderColor = myColor.cgColor
        view4.layer.borderColor = myColor.cgColor

        
        for w in 0...3 {
            //change lows and highs
            
            switch w {
            case 0:
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))

                low1.text = low + "°";
                high1.text = high + "°";
            case 1:
                
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                
                low2.text = low + "°";
                high2.text = high + "°";
            case 2:
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                
                low3.text = low + "°";
                high3.text = high + "°";
            case 3:
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                
                low4.text = low + "°";
                high4.text = high + "°";
            default:
                break;
            }
            
            
            
            //change icons
            switch allWeatherObjects[w].icon {
            case "partly-cloudy-day":
                let image = UIImage(named:  "partly-cloudy-day.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "rain":
                let image = UIImage(named:  "rain.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "cloudy":
                let image = UIImage(named:  "cloudy.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "fog":
                let image = UIImage(named:  "fog.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "tornado":
                let image = UIImage(named:  "tornado.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "snow":
                let image = UIImage(named:  "snow.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "thunderstorm":
                let image = UIImage(named:  "thunderstorm.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "clear-day":
                let image = UIImage(named:  "clear-day.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            case "windy":
                let image = UIImage(named:  "windy.png")
                if (w == 0) {
                    image1.image = image;
                } else if (w == 1) {
                    image2.image = image;
                } else if (w == 2) {
                    image3.image = image;
                } else {
                    image4.image = image;
                }
            default:
                print(allWeatherObjects[w].icon)
                //code
            }
            
            
        }
        
        print(allTownObjects[4].fullName)
        
        //pickerstuff
        
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
//    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
//        return allTownObjects.count;
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
//        return allTownObjects[row].fullName
//        
//    }
//    
//    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        
//        townButton.setTitle(allTownObjects[row].fullName ,for: .normal)
//        
//        picker.isHidden = true;
//
//
//
//        
//    //
//    }
    
//    func numberOfComponents(in pickerView: UIPickerView) -> Int {
//        return 1;
//    }
    
//    @IBAction func button(_ sender: Any) {
//        picker.isHidden = false;
//    }
    
}



