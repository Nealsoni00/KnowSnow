//
//  SetSchoolViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 6/5/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

class SetSchoolViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var fullNames = [String()]

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
        let button = SecondViewController().delayInt;
        var myCell = tableView.cellForRow(at: indexPath) as! TownCellTableViewCell
        //TODO: SET Default VC controller's Town label to selecred row text
        dismiss(animated: true, completion: nil)

    }
    
    
    
    
    
}




