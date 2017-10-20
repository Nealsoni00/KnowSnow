
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

var dateString = "date"


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
    @IBOutlet var progressText: [UILabel]!
    
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
        
            self.title = school;


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
        dateString = self.f.string(from:Date().tomorrow)
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
        
        print("set zoom scale to \(minZoom)")
        
        print(allWeatherObjects)
        
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
    
  
    
    @IBAction func calenderPushed(_ sender: Any) {
        let minDate = Date()
        DatePickerDialog().show(title: "Select Date", doneButtonTitle: "Done", cancelButtonTitle: "Cancel", defaultDate: self.selectedDate, minimumDate: minDate, maximumDate: nil, datePickerMode: UIDatePickerMode.date) { (date) in
            if (date != nil) {
                self.selectedDate = date!
                
                let data = date!
                self.dataModel.userDidEnterData(data:data)
                SwiftSpinner.show("Loading Percentages...")
                
                
                self.f.dateFormat = "EEEE, MMMM dd"
                dateString = self.f.string(from:date!)
                
            }
        }
    }
    
    
    func newDataReceieved() {
        print("New Data Recieved Func Called")

        school = school?.lowercased()
        self.title = school;

        if (school == "new canaan" || school == "newcanaan") {
            school = "newCanaan"
            self.title = "new canaan";

        } else if (school == "new fairfield" || school == "newfairfield") {
            school = "newFairfield"
            self.title = "new fairfield";

        } else {
            self.title = school;

        }
        self.navigationItem.title = "Know Snow"

        self.dateLabel.text = dateString

        let correctObject = allTownObjects.first(where: { $0.name == school })

        let delay = correctObject!.delay
        let closing = correctObject!.closing
        let early = correctObject!.early
     
        
        townButton.setTitle(correctObject?.fullName, for: .normal)
        
        firstProgressText.text = delay;
        secondProgressText.text = closing;
        thirdProgressText.text = early;
        let indexies: [String] = [delay, closing, early]
        var ints: [Double] = [delayInt, closingInt, earlyInt]

        if (delay != "-") {
            for i in 0 ... indexies.count - 1{
                let indexFirst = indexies[i].index(indexies[i].startIndex, offsetBy: 1)
                let indexSecond = indexies[i].index(indexies[i].startIndex, offsetBy: 2)
                var intIndex: Double = 0.0
                
                if (indexies[i].substring(from: indexFirst) == "%") { //single digit percentage
                    intIndex = Double(indexies[i].substring(to: indexFirst))!
                } else if (indexies[i].substring(from: indexSecond) == "%") { //two digit
                    intIndex = Double(indexies[i].substring(to: indexSecond))!
                } else { //100%
                    let indexThird = indexies[i].index(indexies[i].startIndex, offsetBy: 3)
                    progressText[i].font = progressText[i].font.withSize(30)
                    intIndex = Double(indexies[i].substring(to: indexThird))!
                }
                ints[i] = 360.00 * (intIndex / 100)
            }

            delayInt = ints[0]
            closingInt = ints[1]
            earlyInt = ints[2]
        } else {
             earlyInt = 0;
             closingInt = 0;
             delayInt = 0;
            
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



