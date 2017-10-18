
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



class SecondViewController: UIViewController, UIScrollViewDelegate, DataReturnedDelegate, SchoolChosenDelegate {
    
    
    var selectedDate = Date()
    
    @IBOutlet weak var progressScrollView: UIScrollView!
    @IBOutlet weak var progressView: UIView!

//    @IBOutlet weak var weatherScrollView: UIScrollView!
//    @IBOutlet weak var weatherView: UIView!
    
    @IBOutlet weak var collectionView: WeatherCollectionView!

    
    
    @IBOutlet weak var dismissalProgress: KDCircularProgress!
    @IBOutlet weak var closureProgress: KDCircularProgress!
    @IBOutlet weak var delayProgress: KDCircularProgress!
    
    @IBOutlet weak var townButton: UIButton!
    @IBOutlet weak var firstProgressText: UILabel!
    @IBOutlet weak var secondProgressText: UILabel!
    @IBOutlet weak var thirdProgressText: UILabel!
  
    @IBOutlet weak var schoolNameLabel: UIButton!
    
    @IBOutlet weak var inchesOfSnow: UILabel!
    
    private let dataModel = RetrieveMapInfo()

    
    @IBOutlet weak var dateLabel: UILabel!
    
    var delayInt = Double();
    var closingInt = Double();
    var earlyInt = Double();
    
    let f = DateFormatter();
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        progressScrollView.delegate = self
        progressScrollView.clipsToBounds = true
        
//        weatherScrollView.delegate = self
//        weatherScrollView.clipsToBounds = true
        
        collectionView.allowsSelection = false
        collectionView.dataSource = collectionView
        collectionView.delegate = collectionView
        collectionView.allWeatherObjects = allWeatherObjects
        collectionView.isScrollEnabled = true
        collectionView.allowsSelection = true
        collectionView.allowsMultipleSelection = false
        
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

        
        
        
//        newDataReceieved();
        
        //UNCOMMENT
        dataModel.delegate = self

        

        self.f.dateFormat = "EEEE, MMMM dd"
        self.dateLabel.text = self.f.string(from:Date().tomorrow)

        
    }
    override func viewDidAppear(_ animated: Bool) {
        newDataReceieved()
        collectionView.allWeatherObjects = allWeatherObjects

    }
    
    override func viewWillLayoutSubviews(){
        setZoomScale(view: progressView, scrollView: progressScrollView)
        //setZoomScale(view: weatherView, scrollView: weatherScrollView)
    }
    
    func centerScrollViewContents() {
        let boundsSize = progressScrollView.bounds.size
        var contentsFrame = progressView.frame
        
        if contentsFrame.size.width < boundsSize.width {
            contentsFrame.origin.x = (boundsSize.width - contentsFrame.size.width) / 2.0
        } else {
            contentsFrame.origin.x = 0.0
        }
        
        if contentsFrame.size.height < boundsSize.height {
            contentsFrame.origin.y = (boundsSize.height - contentsFrame.size.height) / 2.0
        } else {
            contentsFrame.origin.y = 0.0
        }
        
        progressView.frame = contentsFrame
    }
    
    func setZoomScale(view: UIView, scrollView: UIScrollView) {
        let minZoom = min(self.view.bounds.size.width / view.bounds.size.width, self.view.bounds.size.height / view.bounds.size.height)
        
        //        if (minZoom > 1.0) {
        //            minZoom = 1.0;
        //        }
        print("set zoom scale to \(minZoom)")
        
        scrollView.minimumZoomScale = minZoom
        scrollView.maximumZoomScale = minZoom
        scrollView.zoomScale = minZoom
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return progressView
    }
    

    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func datePicker(_ sender: Any) {
        let minDate = Date()
        DatePickerDialog().show(title: "Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: self.selectedDate, minimumDate: minDate, maximumDate: nil, datePickerMode: UIDatePickerMode.date) { (date) in
            if (date != nil) {
                self.selectedDate = date!
                
                let data = date!
                self.dataModel.userDidEnterData(data:data)
                SwiftSpinner.show("Loading Percentages...")

                
                self.f.dateFormat = "EEEE, MMMM dd"
                self.dateLabel.text = self.f.string(from:date!)

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
        
        let correctObject = allTownObjects.first(where: { $0.name == school })

        let delay = correctObject!.delay
        let closing = correctObject!.closing
        let early = correctObject!.early
     
        
        townButton.setTitle(correctObject?.fullName, for: .normal)
        
        firstProgressText.text = delay;
        secondProgressText.text = closing;
        thirdProgressText.text = early;

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
            let intEarly = 0;
            let intClosing = 0;
            let intDelay = 0;
            
        }

        SwiftSpinner.hide()

        let scale = CGFloat(self.progressScrollView.frame.size.width/self.progressView.frame.size.width)
        self.progressScrollView.setZoomScale(scale, animated: true)
        let progresses: [KDCircularProgress] = [delayProgress, closureProgress, dismissalProgress]
        for progress in progresses {
            progress.startAngle = -90
            progress.progressThickness = 0.2
            progress.trackThickness = 0.3
            progress.clockwise = true
            progress.gradientRotateSpeed = 2
            progress.roundedCorners = false
            progress.glowMode = .noGlow
            progress.glowAmount = 0.9
            progress.trackColor = UIColor(red:0.84, green:0.84, blue:0.84, alpha:1.0)
            progress.set(colors: UIColor(red:0.39, green:0.71, blue:0.96, alpha:1.0))
        }
        
        delayProgress.animate(fromAngle: 0, toAngle: delayInt, duration: 1) { completed in }
        closureProgress.animate(fromAngle: 0, toAngle: closingInt, duration: 1) { completed in }
        dismissalProgress.animate(fromAngle: 0, toAngle: earlyInt, duration: 1) { completed in }
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



