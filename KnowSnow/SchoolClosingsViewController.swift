//
//  SchoolClosingsViewController.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 10/4/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import UIKit

class SchoolClosingsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    @IBOutlet weak var tableView: UITableView!
    
    var closings: [String] = ["Westport Public Schools", "Weston Public Schools"]
    var early: [String] = ["Sharkey Public Schools"]
    var dismisal: [String] = ["Westport Public Schools", "Weston Public Schools"]
    var labels: [String] = ["Closings", "Delay", "Early Dismisal"]
    var info: [[String]]?
    

    override func viewDidLoad() {
        
        super.viewDidLoad()
        self.tableView.delegate = self
        self.tableView.dataSource = self
        let darkGrey = UIColor(red:0.27, green:0.33, blue:0.36, alpha:1.0)
        
        self.navigationController?.view.backgroundColor = UIColor.white
        self.navigationController?.navigationBar.barTintColor = darkGrey
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.navigationBar.tintColor = UIColor.white
        self.navigationController?.navigationBar.titleTextAttributes = [ NSFontAttributeName: UIFont(name: "Avenir Light", size: 22)!, NSForegroundColorAttributeName: UIColor.white]
        UIApplication.shared.statusBarStyle = .lightContent
        self.navigationItem.title = "School Status"
        
        let infoButton = UIButton(type: .infoLight)
        infoButton.addTarget(self, action: #selector(SecondViewController.infoPressed), for: .touchUpInside)
        let infoBarButtonItem = UIBarButtonItem(customView: infoButton)
        navigationItem.leftBarButtonItem = infoBarButtonItem


        // Do any additional setup after loading the view.
        
        self.info = [self.closings, self.early, self.dismisal]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func infoPressed() {
        let infoPage = self.storyboard?.instantiateViewController(withIdentifier: "infoVC") as! UINavigationController
        self.tabBarController?.present(infoPage, animated: true, completion: nil)
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return self.info?[section].count ?? 0
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
//    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
//        if (section == 0){
//            return "Closings"
//        }else if(section == 1){
//            return "Delay"
//        }
//        return "Early Dismisal"
//
//    }
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView?
    {
        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        headerView.backgroundColor = UIColor(red:0.36, green:0.45, blue:0.49, alpha:1.0)
        
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
        label.text = labels[section]
        label.textColor = UIColor.white
        label.textAlignment = .center
        headerView.addSubview(label)
        
        
        return headerView
    }
//    func tableView(_ tableView: UITableView, willDisplayHeaderView view:UIView, forSection: Int) {
//        if let headerTitle = view as? UITableViewHeaderFooterView {
//            headerTitle.textLabel?.textColor = UIColor.white
//        }
//    }
//
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = self.tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TownCellTableViewCell

        cell.town.text = self.info?[indexPath.section][indexPath.row] ?? ""

        return cell
    }
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        var returnedView = UIView(frame:  CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30)) //set these values as necessary
//        returnedView.backgroundColor = UIColor(red:0.28, green:0.33, blue:0.36, alpha:1.0)
//
//        var label = UILabel(frame: CGRectMake(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
//        label.text = self.info?[indexPath.section][indexPath.row] ?? ""
//        returnedView.addSubview(label)
//
//        return returnedView
//    }
    
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
