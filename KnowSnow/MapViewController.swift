//
//  FirstViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 2/17/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import SideMenu

class FirstViewController: UIViewController {
    
    //array of towns

    var towns = ["weston", "norwalk", "redding", "westport", "shelton", "danbury", "sherman", "newCanaan", "ridgefield", "newFairfield", "bridgeport", "trumbull", "newtown", "darien", "bethel", "fairfield", "stamford", "brookfield", "easton", "monroe", "greenwich", "wilton"]
    
    

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
    
    //init
    
    override func viewDidLoad() {
        super.viewDidLoad()

        GetWeather().getWeather()

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
        // UISideMenuNavigationController is a subclass of UINavigationController, so do any additional configuration
        // of it here like setting its viewControllers. If you're using storyboards, you'll want to do something like:
        // let menuLeftNavigationController = storyboard!.instantiateViewController(withIdentifier: "LeftMenuNavigationController") as! UISideMenuNavigationController
        SideMenuManager.menuLeftNavigationController = menuLeftNavigationController
        
        SideMenuManager.menuAddPanGestureToPresent(toView: self.navigationController!.navigationBar)
        SideMenuManager.menuAddScreenEdgePanGesturesToPresent(toView: self.navigationController!.view)
        
        SideMenuManager.menuPresentMode = .menuSlideIn
        SideMenuManager.menuWidth = max(round(min((FirstViewController.appScreenRect.width), (FirstViewController.appScreenRect.height)) * 0.88), 240)
        var j = 0
        for i in allTownObjects {
            changeMap(percentage: allTownObjects[j].closing, town: allTownObjects[j].name)

            j = j + 1
        }
    }
    
    
    
    internal static var appScreenRect: CGRect {
        let appWindowRect = UIApplication.shared.keyWindow?.bounds ?? UIWindow().bounds
        return appWindowRect
    }
    
    func respondToSwipeGesture(gesture: UIGestureRecognizer) {
        if let swipeGesture = gesture as? UISwipeGestureRecognizer {
            switch swipeGesture.direction {
            case UISwipeGestureRecognizerDirection.right:
                present(SideMenuManager.menuLeftNavigationController!, animated: true, completion: nil)

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
        var j = 0;
        if(tabbedButtons.selectedSegmentIndex == 0)
        {
            for i in allTownObjects {
                changeMap(percentage: allTownObjects[j].closing, town: allTownObjects[j].name)
                j = j + 1
            }
        }
        else if(tabbedButtons.selectedSegmentIndex == 1)
        {
            for i in allTownObjects {
                changeMap(percentage: allTownObjects[j].delay, town: allTownObjects[j].name)
                j = j + 1
            }
        }
        else if(tabbedButtons.selectedSegmentIndex == 2)
        {
            for i in allTownObjects {
                changeMap(percentage: allTownObjects[j].early, town: allTownObjects[j].name)
                j = j + 1
            }
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func changeMap(percentage: String, town: String) {
        switch town {
        case "sherman":
            sherman.text = percentage
            if (percentage == "100%") {
                sherman.font = sherman.font.withSize(12)
            }
          
        case "newFairfield":
            newFairfield.text = percentage
            if (percentage == "100%") {
                newFairfield.font = newFairfield.font.withSize(15)
            }
        case "brookfield":
            brookfield.text = percentage
            if (percentage == "100%") {
                brookfield.font = brookfield.font.withSize(13)
            }
        case "danbury":
            danbury.text = percentage
            if (percentage == "100%") {
                danbury.font = danbury.font.withSize(15)
            }
        case "bethel":
            bethel.text = percentage
            if (percentage == "100%") {
                bethel.font = bethel.font.withSize(12)
            }
        case "newtown":
            newtown.text = percentage;
            if (percentage == "100%") {
                newtown.font = newtown.font.withSize(15)
            }
        case "ridgefield":
            ridgefield.text = percentage;
            if (percentage == "100%") {
                ridgefield.font = ridgefield.font.withSize(15)
            }
        case "redding":
            redding.text = percentage
            if (percentage == "100%") {
                redding.font = redding.font.withSize(15)
            }
        case "monroe":
            monroe.text = percentage
            if (percentage == "100%") {
                monroe.font = monroe.font.withSize(15)
            }
        case "shelton":
            shelton.text = percentage
            if (percentage == "100%") {
                shelton.font = shelton.font.withSize(15)
            }
        case "trumbull":
            trumbull.text = percentage
            if (percentage == "100%") {
                trumbull.font = trumbull.font.withSize(15)
            }
        case "easton":
            easton.text = percentage
            if (percentage == "100%") {
                easton.font = easton.font.withSize(15)
            }
        case "weston":
            weston.text = percentage;
            if (percentage == "100%") {
                weston.font = weston.font.withSize(15)
            }
        case "wilton":
            wilton.text = percentage;
            if (percentage == "100%") {
                wilton.font = wilton.font.withSize(15)
            }
        case "newCanaan":
            newCanaan.text = percentage
            if (percentage == "100%") {
                newCanaan.font = newCanaan.font.withSize(15)
            }
        case "stamford":
            stamford.text = percentage
            if (percentage == "100%") {
                stamford.font = stamford.font.withSize(15)
            }
        case "greenwich":
            greenwich.text = percentage
            if (percentage == "100%") {
                greenwich.font = greenwich.font.withSize(15)
            }
        case "darien":
            darien.text = percentage
            if (percentage == "100%") {
                darien.font = darien.font.withSize(12)
            }
        case "norwalk":
            norwalk.text = percentage
            if (percentage == "100%") {
                norwalk.font = norwalk.font.withSize(15)
            }
        case "westport":
            westport.text = percentage;
            if (percentage == "100%") {
                westport.font = westport.font.withSize(15)
            }
        case "fairfield":
            fairfield.text = percentage;
            if (percentage == "100%") {
                fairfield.font = fairfield.font.withSize(15)
            }
        case "bridgeport":
            bridgeport.text = percentage
            if (percentage == "100%") {
                bridgeport.font = bridgeport.font.withSize(13)
            }
        case "stratford":
            stratford.text = percentage
            if (percentage == "100%") {
                stratford.font = stratford.font.withSize(11)
            }
        default:
            print("error")
        }
        
        
        
    }
    
}

