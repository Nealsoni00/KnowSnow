
//
//  SecondViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 2/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import KDCircularProgress
import SwiftSpinner
import PopupDialog

var school = defaults.string(forKey: "default")



class SecondViewController: UIViewController, DataReturnedDelegate, SchoolChosenDelegate {
    
    
    var selectedDate = Date()
    
    @IBOutlet weak var progressScrollView: UIScrollView!
    @IBOutlet weak var weatherScrollView: UIScrollView!
    
    @IBOutlet weak var weatherView: UIView!
    @IBOutlet weak var progressView: UIView!
    
    
    @IBOutlet weak var dismissalProgress: KDCircularProgress!
    @IBOutlet weak var closureProgress: KDCircularProgress!
    @IBOutlet weak var delayProgress: KDCircularProgress!
    
    @IBOutlet weak var townButton: UIButton!
    @IBOutlet weak var firstProgressText: UILabel!
    @IBOutlet weak var secondProgressText: UILabel!
    @IBOutlet weak var thirdProgressText: UILabel!
    
    //weather images
    @IBOutlet weak var image1: UIImageView!
    @IBOutlet weak var image2: UIImageView!
    @IBOutlet weak var image3: UIImageView!
    @IBOutlet weak var image4: UIImageView!
    
    //weather boxes
    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    //weather temps
    @IBOutlet weak var low1: UILabel!
    @IBOutlet weak var high4: UILabel!
    @IBOutlet weak var high1: UILabel!
    @IBOutlet weak var high3: UILabel!
    @IBOutlet weak var low3: UILabel!
    @IBOutlet weak var high2: UILabel!
    @IBOutlet weak var low2: UILabel!
    @IBOutlet weak var low4: UILabel!
    
    //weather days
    
    @IBOutlet weak var day1: UILabel!
    @IBOutlet weak var day2: UILabel!
    @IBOutlet weak var day3: UILabel!
    @IBOutlet weak var day4: UILabel!
    @IBOutlet weak var schoolNameLabel: UIButton!
    
    @IBOutlet weak var inchesOfSnow: UILabel!
    
    private let dataModel = RetrieveMapInfo()

    var dateString = "date"

    @IBOutlet weak var dateLabel: UILabel!
    
    var delayInt = Double();
    var closingInt = Double();
    var earlyInt = Double();
    

    let f = DateFormatter()
    
    
    override func viewDidLoad() {
        
//
        let darkGrey = UIColor(red:0.27, green:0.33, blue:0.36, alpha:1.0)
        


        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = darkGrey
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir Light", size: 22)!, NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(SecondViewController.infoPressed), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.leftBarButtonItem = infoBarButtonItem

        
        
        super.viewDidLoad()
        
//        newDataReceieved();
        
        //UNCOMMENT
        dataModel.delegate = self

        weatherStuff()
        

        self.f.dateFormat = "EEEE, MMMM dd"
        dateString = self.f.string(from:Date().tomorrow)
        
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        newDataReceieved()
    }
    
    func weatherStuff () {
        
        //Add weather stuff
        
        let myColor = UIColor(red:0.72, green:0.72, blue:0.72, alpha:1.0)
        
        
        view1.layer.borderColor = myColor.cgColor
        view2.layer.borderColor = myColor.cgColor
        view3.layer.borderColor = myColor.cgColor
        view4.layer.borderColor = myColor.cgColor
        
        print(allWeatherObjects)
        
        
        for w in 0...3 {
            //change lows and highs
            
            switch w {
            case 0:
                
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                let precip = allWeatherObjects[w].precip
                
                
                if (precip == "null") {
                    inchesOfSnow.text = ""
                }
                
                
                low1.text = low + "°";
                high1.text = high + "°";
                
                //show day of week
                let date = (Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: (Double(allWeatherObjects[w].timeStamp)!) ))) - 1
                
                let day = f.weekdaySymbols[date]
                day1.text = day;
                
            case 1:
                
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                
                low2.text = low + "°";
                high2.text = high + "°";
                
                let date = (Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: (Double(allWeatherObjects[w].timeStamp)!) ))) - 1
                
                let day = f.weekdaySymbols[date]
                day2.text = day;
                
                
            case 2:
                
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                
                low3.text = low + "°";
                high3.text = high + "°";
                
                
                let date = (Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: (Double(allWeatherObjects[w].timeStamp)!) ))) - 1
                
                let day = f.weekdaySymbols[date]
                day3.text = day;
            case 3:
                
                let low = String(format: "%.0f", round(Double(allWeatherObjects[w].low)!))
                let high = String(format: "%.0f", round(Double(allWeatherObjects[w].high)!))
                
                low4.text = low + "°";
                high4.text = high + "°";
                
                let date = (Calendar.current.component(.weekday, from: Date(timeIntervalSince1970: (Double(allWeatherObjects[w].timeStamp)!) ))) - 1
                
                let day = f.weekdaySymbols[date]
                day4.text = day;
                
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
            case "partly-cloudy-night":
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
            default: break
            }
            
            
        }
    }
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func settingsPushed(_ sender: Any) {
        let minDate = Date()
        DatePickerDialog().show(title: "Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: self.selectedDate, minimumDate: minDate, maximumDate: nil, datePickerMode: UIDatePickerMode.date) { (date) in
            if (date != nil) {
                self.selectedDate = date!
                
                let data = date!
                self.dataModel.userDidEnterData(data:data)
                SwiftSpinner.show("Loading Percentages...")
                
                
                self.f.dateFormat = "EEEE, MMMM dd"
                self.dateString = self.f.string(from:date!)
                
            }
        }
    }
    
    
    
    
    func newDataReceieved() {
        print("New Data Recieved Func Called")

        school = school?.lowercased()
        
        if (school == "new canaan" || school == "newcanaan") {
            school = "newCanaan"
        }
        if (school == "new fairfield" || school == "newfairfield") {
            school = "newFairfield"
        }
        self.dateLabel.text = dateString
        
        let correctObject = allTownObjects.first(where: { $0.name == school })
        
        
        
        let delay = correctObject!.delay
        let closing = correctObject!.closing
        let early = correctObject!.early
     
        
        townButton.setTitle(correctObject?.fullName, for: .normal)
        
        firstProgressText.text = delay;
        secondProgressText.text = closing;
        thirdProgressText.text = early;
    
        
        //delay wheel stuff
        
        
        
        if (delay != "-") {
            
        

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
        } else {
             earlyInt = 0;
             closingInt = 0;
             delayInt = 0;
            
        }

        SwiftSpinner.hide()

        //INIT CIRCLE
        //let progress = KDCircularProgress(frame: CGRect(x: 170, y: 0, width: 140, height: 140))
        //let progress2 = KDCircularProgress(frame: CGRect(x: 170, y: 0, width: 140, height: 140))
        //let progress3 = KDCircularProgress(frame: CGRect(x: 340, y: 0, width: 140, height: 140))
        let scale = CGFloat(self.progressScrollView.frame.size.width/self.progressView.frame.size.width)
        self.progressScrollView.setZoomScale(scale, animated: true)
        //self.progressScrollView.minimumZoomScale = self.progressScrollView.frame.size.width/self.progressView.frame.size.width
        
        
        delayProgress.startAngle = -90
        delayProgress.progressThickness = 0.2
        delayProgress.trackThickness = 0.3
        delayProgress.clockwise = true
        delayProgress.gradientRotateSpeed = 2
        delayProgress.roundedCorners = false
        delayProgress.glowMode = .noGlow
        delayProgress.glowAmount = 0.9
        delayProgress.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        delayProgress.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        //delayProgress.center = CGPoint(x: firstProgressText.center.x, y: firstProgressText.center.y + 150)
        
        closureProgress.startAngle = -90
        closureProgress.progressThickness = 0.2
        closureProgress.trackThickness = 0.3
        closureProgress.clockwise = true
        closureProgress.gradientRotateSpeed = 2
        closureProgress.roundedCorners = false
        closureProgress.glowMode = .noGlow
        closureProgress.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        closureProgress.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        //progress2.center = CGPoint(x: secondProgressText.center.x, y: secondProgressText.center.y + 150)
        
        dismissalProgress.startAngle = -90
        dismissalProgress.progressThickness = 0.2
        dismissalProgress.trackThickness = 0.3
        dismissalProgress.clockwise = true
        dismissalProgress.gradientRotateSpeed = 2
        dismissalProgress.roundedCorners = false
        dismissalProgress.glowMode = .noGlow
        dismissalProgress.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
        dismissalProgress.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        //dismissalProgress.center = CGPoint(x: thirdProgressText.center.x, y: thirdProgressText.center.y + 150)
        
        
        //view.addSubview(progress)
        //view.addSubview(progress2)
        //view.addSubview(progress3)
        
        // Do any additional setup after loading the view, typically from a nib.
        
        delayProgress.animate(fromAngle: 0, toAngle: delayInt, duration: 1) { completed in
        }
        
        closureProgress.animate(fromAngle: 0, toAngle: closingInt, duration: 1) { completed in
        }
        
        dismissalProgress.animate(fromAngle: 0, toAngle: earlyInt, duration: 1) { completed in
        }
        

    }
    
    func userChoseSchool(name: String) {
        var index = allTownObjects.index(where: { $0.fullName == name })
        if (index == nil){
            index = allTownObjects.index(where: { $0.name == name })
        }
        townButton.setTitle(allTownObjects[index!].fullName, for: .normal)
        school = allTownObjects[index!].name
//          tabBarController.selectedIndex = 1
//        newDataReceieved();
        //change weather
        
        
        
    }
    
   
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSendingVC" {
            let DestViewController = segue.destination as! UINavigationController
            let targetController = DestViewController.topViewController as! SetSchoolViewController
            targetController.delegate = self
        }
    }
    
    @IBAction func setDefaultSchool(_ sender: Any) {
        
        let index = allTownObjects.index(where: { $0.fullName == townButton.currentTitle })
        
        let schoolName = allTownObjects[index!].name
        defaults.set(schoolName, forKey: "default")
        print("saved")
        
        let title = "Default School Successfully Saved."
        
        // Create the dialog
        let popup = PopupDialog(title: title, message: "")
        popup.transitionStyle = .fadeIn
        
        // Create buttons
      
        let buttonOne = DefaultButton(title: "Dismiss") {
        }
        
         popup.addButton(buttonOne)
        // to add a single button
        popup.addButton(buttonOne)
        // Present dialog
        self.present(popup, animated: true, completion: nil)
    }
    
    func createParticles() {
        let view = UIImageView(frame: CGRect(x: 0.0, y: 0.0, width: self.view.frame.size.width, height: self.view.frame.size.height))
        view.contentMode = UIViewContentMode.scaleAspectFill
        
        self.view.addSubview(view)
        
        let cloud = CAEmitterLayer()
        cloud.emitterPosition = CGPoint(x: view.center.x, y: -50)
        cloud.emitterShape = kCAEmitterLayerLine
        cloud.emitterSize = CGSize(width: view.frame.size.width, height: 1)
        
        let flake = makeEmitterCell()
        
        cloud.emitterCells = [flake]
        
        view.layer.addSublayer(cloud)
    }
    
    func makeEmitterCell() -> CAEmitterCell {
        let cell = CAEmitterCell()
        cell.contentsScale = 8
        cell.birthRate = 4
        cell.lifetime = 50.0
        cell.velocity = 50
        cell.emissionLongitude = CGFloat.pi
        cell.emissionRange = CGFloat.pi / 4
        cell.spin = 0.5
        cell.spinRange = 1.2
        cell.scaleRange = -0.05
        cell.contents = UIImage(named: "snow")?.cgImage
        
        return cell
    }
    
    func percentagesRecievedRetrieveWeather () {
        
    }
    
   
    
    func infoPressed() {
        let infoPage = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! UINavigationController
        self.tabBarController?.present(infoPage, animated: true, completion: nil)
    }
    
    @IBAction func settingsPressed(_ sender: Any) {
        let settingsPage = self.storyboard?.instantiateViewController(withIdentifier: "settingsVC") as! UINavigationController
        
        self.tabBarController?.present(settingsPage, animated: true, completion: nil)
        
        //make new settings page and do same thing as when school is changed
    }
    
}



