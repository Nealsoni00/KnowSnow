//
//  SetSchoolFromInfoViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 10/5/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

class SetSchoolFromInfoViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var fullNames = [String]()
    var delegate:SchoolChosenDelegate? = nil;

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
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
        
       
            let index = allTownObjects.index(where: { $0.fullName == fullName })
            defaults.set(allTownObjects[index!].name, forKey: "default")
            school = allTownObjects[index!].name
        
        navigationController?.popViewController(animated: true)

    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
