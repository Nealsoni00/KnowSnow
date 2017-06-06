//
//  SlideMenuViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/22/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

class SlideMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    

    @IBOutlet weak var tableView: UITableView!
    var instance = FirstViewController();
    
    var towns = ["weston", "norwalk", "redding", "westport", "shelton", "danbury", "sherman", "newCanaan", "ridgefield", "newFairfield", "bridgeport", "trumbull", "newtown", "darien", "bethel", "fairfield", "stamford", "brookfield", "easton", "monroe", "greenwich", "wilton"]

    
    override func viewDidLoad() {
     
        tableView.delegate = self
        tableView.dataSource = self
        
        super.viewDidLoad()

        towns.sort { $0.compare($1, options: .numeric) == .orderedAscending }
        
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: true, scrollPosition: .bottom)
        tableView.delegate?.tableView!(tableView, didSelectRowAt: indexPath)

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
        cell.status.text = ""
        
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
        var myCell = tableView.cellForRow(at: indexPath) as! CustomCell
        myCell.name.textColor = UIColor(red:0.31, green:0.64, blue:0.71, alpha:1.0)
        myCell.status.textColor = UIColor(red:0.31, green:0.64, blue:0.71, alpha:1.0)
        myCell.status.text = "No School"

    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        var myCell = tableView.cellForRow(at: indexPath) as! CustomCell
        myCell.name.textColor = UIColor.white
        myCell.status.textColor = UIColor.white
        myCell.status.text = ""

    }
    
   
    
}
