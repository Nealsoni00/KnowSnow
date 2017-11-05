//
//  FirstViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 2/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import SideMenu
import PopupDialog
import SwiftSpinner
import GoogleMobileAds

class FirstViewController: UIViewController, UIScrollViewDelegate, DataReturnedDelegate, GADBannerViewDelegate {
    
    
    
    //array of towns

    var townLabels = [String: UILabel]()
    
    @IBOutlet weak var mapScrollView: UIScrollView!
    @IBOutlet weak var mapView: UIView!
    private let dataModel = RetrieveMapInfo()

    
    @IBOutlet weak var ridgefield: UILabel!
    @IBOutlet weak var bethel: UILabel!
    @IBOutlet weak var danbury: UILabel!
    @IBOutlet weak var norwalk: UILabel!
    @IBOutlet weak var westport: UILabel!
    @IBOutlet weak var sherman: UILabel!
    @IBOutlet weak var newFairfield: UILabel!
    @IBOutlet weak var brookfield: UILabel!
    @IBOutlet weak var newtown: UILabel!
    @IBOutlet weak var redding: UILabel!
    @IBOutlet weak var monroe: UILabel!
    @IBOutlet weak var shelton: UILabel!
    @IBOutlet weak var trumbull: UILabel!
    @IBOutlet weak var easton: UILabel!
    @IBOutlet weak var weston: UILabel!
    @IBOutlet weak var wilton: UILabel!
    @IBOutlet weak var greenwich: UILabel!
    @IBOutlet weak var stamford: UILabel!
    @IBOutlet weak var bridgeport: UILabel!
    @IBOutlet weak var newCanaan: UILabel!
    @IBOutlet weak var fairfield: UILabel!
    @IBOutlet weak var darien: UILabel!
    @IBOutlet weak var stratford: UILabel!
    
    @IBOutlet weak var dateLabel: UILabel!
    
    var bannerView: GADBannerView! //Ads
    var selectedDate = Date()
    let f = DateFormatter();
    //init

    override func viewDidLoad() {
        super.viewDidLoad()
        mapScrollView.delegate = self
        
        mapScrollView.clipsToBounds = true
        
        let darkGrey = UIColor(red:0.27, green:0.33, blue:0.36, alpha:1.0)
        dataModel.delegate = self
        
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
        self.navigationItem.title = "Map"

        bannerView =  GADBannerView(adSize: kGADAdSizeSmartBannerPortrait)
        
        addBannerViewToView(bannerView)
        //ca-app-pub-6421137549100021~9702408169
        bannerView.adUnitID = "ca-app-pub-6421137549100021/7399678458" // real one
//        bannerView.adUnitID = "ca-app-pub-3940256099942544/2934735716" // Test one
        //request.testDevices = @[ kGADSimulatorID ]
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID ];
        bannerView.rootViewController = self
        bannerView.load(GADRequest())
        bannerView.delegate = self

        //TODO: MOVE THIS TO GET DONE BEFORE SCREEN SHOWS
        townLabels = ["weston": weston, "norwalk": norwalk, "redding": redding, "westport": westport, "shelton": shelton, "danbury": danbury, "sherman": sherman, "newCanaan": newCanaan, "ridgefield": ridgefield, "newFairfield": newFairfield, "bridgeport": bridgeport, "trumbull": trumbull, "newtown": newtown, "darien": darien, "bethel": bethel, "fairfield": fairfield, "stamford": stamford, "brookfield": brookfield, "easton": easton, "monroe": monroe, "greenwich": greenwich, "wilton": wilton, "stratford": stratford]

        //townLabels = [weston, norwalk, redding, westport, shelton, danbury, sherman, newCanaan, ridgefield, newFairfield, bridgeport, trumbull, newtown, darien, bethel, fairfield, stamford, brookfield, easton, monroe, greenwich, wilton, stratford]
        
        
        
        let scrollViewFrame = mapScrollView.frame
        let scaleWidth = scrollViewFrame.size.width / mapScrollView.contentSize.width
        let scaleHeight = scrollViewFrame.size.height / mapScrollView.contentSize.height
        let minScale = min(scaleWidth, scaleHeight);
        mapScrollView.minimumZoomScale = minScale * 0.7;

        // 5
        mapScrollView.maximumZoomScale = 1.0
        mapScrollView.zoomScale = minScale;

        // 6
        centerScrollViewContents()
        
  
        // Do any additional setup after loading the view, typically from a nib.
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(self.respondToSwipeGesture))

        
        swipeRight.direction = UISwipeGestureRecognizerDirection.right
        self.view.addGestureRecognizer(swipeRight)
        
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
        
        // Define the menus
        let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        menuLeftNavigationController.leftSide = true
       
        SideMenuManager.default.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.default.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.default.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        SideMenuManager.default.menuPresentMode = .menuSlideIn
        SideMenuManager.default.menuWidth = max(round(min((FirstViewController.appScreenRect.width), (FirstViewController.appScreenRect.height)) * 0.88), 240)
        var j = 0
        
        //init percentages set
        for _ in allTownObjects {
            changeMap(percentage: allTownObjects[j].closing, town: allTownObjects[j].name)
            j = j + 1
        }
        
      

        
    }

    override func viewWillLayoutSubviews(){
        setZoomScale()
        
    }

    func addBannerViewToView(_ bannerView: GADBannerView) {
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(bannerView)
        view.addConstraints(
            [NSLayoutConstraint(item: bannerView,
                                attribute: .bottom,
                                relatedBy: .equal,
                                toItem: bottomLayoutGuide,
                                attribute: .top,
                                multiplier: 1,
                                constant: 0),
             NSLayoutConstraint(item: bannerView,
                                attribute: .centerX,
                                relatedBy: .equal,
                                toItem: view,
                                attribute: .centerX,
                                multiplier: 1,
                                constant: 0)
            ])
    }
    func adViewDidReceiveAd(_ bannerView: GADBannerView) {
        bannerView.alpha = 0
        UIView.animate(withDuration: 1, animations: {
            bannerView.alpha = 1
        })
    }
    
    @IBAction func calenderPressed(_ sender: Any) {
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
    
    func centerScrollViewContents() {
        let boundsSize = mapScrollView.bounds.size
        var contentsFrame = mapView.frame
        
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
        
        mapView.frame = contentsFrame
    }
    func scrollViewDoubleTapped(recognizer: UITapGestureRecognizer) {
        // 1
        let pointInView = recognizer.location(in: mapView)
        
        // 2
        var newZoomScale = mapScrollView.zoomScale * 1.5
        newZoomScale = min(newZoomScale, mapScrollView.maximumZoomScale)
        
        // 3
        let scrollViewSize = mapScrollView.bounds.size
        let w = scrollViewSize.width / newZoomScale
        let h = scrollViewSize.height / newZoomScale
        let x = pointInView.x - (w / 2.0)
        let y = pointInView.y - (h / 2.0)
        
        let rectToZoomTo = CGRect(x: x, y: y,width: w, height: h)
        
        // 4
        mapScrollView.zoom(to: rectToZoomTo, animated: true)
    }
    func setZoomScale() {
        let minZoom = min(self.view.bounds.size.width / mapView!.bounds.size.width, self.view.bounds.size.height / mapView!.bounds.size.height);
        
//        if (minZoom > 1.0) {
//            minZoom = 1.0;
//        }
        print("set zoom scale to \(minZoom)")

        mapScrollView.minimumZoomScale = minZoom;
        mapScrollView.zoomScale = minZoom;
        mapScrollView.maximumZoomScale = minZoom*1.25
        
    }
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
        return mapView
    }
    
    internal static var appScreenRect: CGRect {
        let appWindowRect = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        return appWindowRect
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                present(SideMenuManager.default.menuLeftNavigationController!, animated: true, completion: nil)
            case UISwipeGestureRecognizerDirection.down: break
            case UISwipeGestureRecognizerDirection.left:
                dismiss(animated: true, completion: nil)
            case UISwipeGestureRecognizerDirection.up: break
            default:
                break
            }
        }
    }
   
    
    @IBOutlet weak var tabbedButtons: UISegmentedControl!
    
    
    @IBAction func tabbedButtons(_ sender: Any) {
        if(tabbedButtons.selectedSegmentIndex == 0){
            for j in 0...allTownObjects.count - 1 {
                changeMap(percentage: allTownObjects[j].closing, town: allTownObjects[j].name)
            }
        }
        else if(tabbedButtons.selectedSegmentIndex == 1){
            for j in 0...allTownObjects.count - 1 {
                changeMap(percentage: allTownObjects[j].delay, town: allTownObjects[j].name)
            }
        }
        else if(tabbedButtons.selectedSegmentIndex == 2){
            for j in 0...allTownObjects.count - 1 {
                changeMap(percentage: allTownObjects[j].early, town: allTownObjects[j].name)
            }
        }
    }
//    func swipeDate(_ sender: UISwipeGestureRecognizer) {
//        switch (sender.direction) {
//        case UISwipeGestureRecognizerDirection.left:
//            self.tabbedButtons.selectedSegmentIndex =   (self.tabbedButtons.selectedSegmentIndex - 1) % 4
//            for j in 0...allTownObjects.count - 1 {
//                changeMap(percentage: allTownObjects[j].closing, town: allTownObjects[j].name)
//            }
//        case UISwipeGestureRecognizerDirection.right:
//            self.tabbedButtons.selectedSegmentIndex =   (self.tabbedButtons.selectedSegmentIndex + 1) % 4
//            for j in 0...allTownObjects.count - 1 {
//                changeMap(percentage: allTownObjects[j].delay, town: allTownObjects[j].name)
//            }
//        default:
//            break
//        }
//    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeMap(percentage: String, town: String) {
        for _ in towns {
            if (percentage != "-") {
                townLabels[town]?.text = percentage
                let intPercentage = Int(percentage.replacingOccurrences(of: "%", with: ""))!
                if (intPercentage < 35){
                    townLabels[town]?.textColor = UIColor(red:0.31, green:0.64, blue:0.71, alpha:1.0)
                }else if(intPercentage < 70){
                    townLabels[town]?.textColor = UIColor.blue
                }else if(intPercentage < 99){
                    townLabels[town]?.textColor = UIColor.purple
                }else if(intPercentage >= 100){
                    townLabels[town]?.textColor = UIColor.red
                    switch tabbedButtons.selectedSegmentIndex {
                    case 0:
                        townLabels[town]?.text = "Closed"
                    case 1:
                        townLabels[town]?.text = "Delayed"
                    case 2:
                        townLabels[town]?.text = "Early"
                    default:
                        break
                    }
                }
            
            } else {
                townLabels[town]?.text = "n/a"
                townLabels[town]?.textColor = UIColor.red
            }
//            if (percentage == "100%") {
//                townLabels[town]?.font = townLabels[town]?.font.withSize(12)
//            }
        }
    }
    
    
    func infoPressed() {
        let infoPage = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! UINavigationController
        self.tabBarController?.present(infoPage, animated: true, completion: nil)
    }
    
    
    
    
    func newDataReceieved() {
        var j = 0
        for _ in allTownObjects {
            print(allTownObjects[j])
            changeMap(percentage: allTownObjects[j].closing, town: allTownObjects[j].name)
            j = j + 1
        }
        dateLabel.text = dateString
        SwiftSpinner.hide()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let f = DateFormatter()
        f.dateFormat = "M/dd/yyyy"
        
        dateLabel.text = "For: " + dateString
    }
    
  
}


