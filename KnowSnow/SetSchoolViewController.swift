//
//  SetSchoolViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 6/5/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit
import SwiftSpinner

protocol SchoolChosenDelegate {
    func userChoseSchool(name: String)
}

class SetSchoolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    private let dbInstance = RetrieveMapInfo()

    var fullNames = [String]()
    var delegate:SchoolChosenDelegate? = nil;
    
    override func viewDidLoad() {
        
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()
//        towns.sort { $0.compare($1, options: .numeric) == .orderedAscending }
        
//        let indexPath = IndexPath(row: 0, section: 0)
//        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
//        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)
//        
        for town in allTownObjects {
            self.fullNames.append(town.fullName)
        }
        
        
        fullNames.sort{ $0.compare($1, options: .numeric) == .orderedAscending }


        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return(self.fullNames.count)
        
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TownCell") as! TownCellTableViewCell
        
        let current = self.fullNames[indexPath.row].capitalized
        cell.town.text = ""
        
        
        cell.town.text = current

        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let myCell = tableView.cellForRow(at: indexPath) as! TownCellTableViewCell
        //TODO: SET Default VC controller's Town label to selecred row text
        let fullName = myCell.town.text 
        if delegate != nil {
            GetWeather().getWeather(school: fullName!)
            delegate?.userChoseSchool(name: fullName!)
            dismiss(animated: true, completion: nil)
        }
        
         let defaultSchool = defaults.string(forKey: "default")
        if defaultSchool == nil {
            let index = allTownObjects.index(where: { $0.fullName == fullName })
            defaults.set(allTownObjects[index!].name, forKey: "default")
            GetWeather().getWeatherInitial()
            SwiftSpinner.show("Loading Data...")

//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let tabBarController = storyboard.instantiateViewController(withIdentifier: "TabBarViewController") as! UITabBarController
//            let appDelegate = UIApplication.shared.delegate as! AppDelegate
//            appDelegate.window?.rootViewController = tabBarController


        }
        

        
    }
 
}









