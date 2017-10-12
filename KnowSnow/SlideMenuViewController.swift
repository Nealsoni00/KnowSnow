//
//  SlideMenuViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/22/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import SwiftSpinner



class SlideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var towns = ["weston", "norwalk", "redding", "westport", "shelton", "danbury", "sherman", "newCanaan", "ridgefield", "newFairfield", "bridgeport", "trumbull", "newtown", "darien", "bethel", "fairfield", "stamford", "brookfield", "easton", "monroe", "greenwich", "wilton"]
    let instance = SecondViewController()
    
    var delegate:SchoolChosenDelegate? = nil;
    override func viewDidLoad() {
        
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
        self.navigationItem.title = "Map"
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
        
        towns.sort { $0.compare($1, options: .numeric) == .orderedAscending }
        
        
        
        //        let indexPath = IndexPath(row: 0, section: 0)
        //        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        //        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(self.towns.count)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SideCell") as! CustomCell
        
        let current = self.towns[indexPath.row].capitalized
        
        if (current == "Newfairfield") {
            cell.name.text = "New Fairfield"
        } else if (current == "Newcanaan") {
            cell.name.text = "New Canaan"
        } else {
            cell.name.text = current
        }
        
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //        let controller = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        //        let _ = controller.view //force to load the view to initialize the IBOutlets
        //
        //        if let tabBarController = self.presentingViewController as? UITabBarController {
        //            self.dismiss(animated: true) {
        //
        //                //this doesnt work below
        //            }
        //            tabBarController.selectedIndex = 1
        //            controller.userChoseSchool(name: school!)
        ////            SwiftSpinner.show("Loading Percentages...")
        //
        //        }
        
        let myCell = tableView.cellForRow(at: indexPath) as! CustomCell
        myCell.name.textColor = UIColor(red:0.31, green:0.64, blue:0.71, alpha:1.0)
        school = myCell.name.text!
        myCell.name.textColor = UIColor(red:1.00, green:1.00, blue:1.00, alpha:1.0)
        
        self.dismiss(animated: true)
        self.delegate?.userChoseSchool(name: school!)
        
        if let tabBarController = self.presentingViewController as? UITabBarController {
            self.dismiss(animated: true) {
                
            }
            tabBarController.selectedIndex = 1
        }
            
            
            //
            
            //        let appDelegate = UIApplication.shared.delegate as! AppDelegate
            //        appDelegate.window?.rootViewController = tabBarController
            
            
            
            //change tabs not push new vc!!!!!!!!!!!!!!!!!!
            
            // Let's assume that the segue name is called playerSegue
            // This will perform the segue and pre-load the variable for you to use
            
            
        }
        
        
        
        
        
}

