//
//  DatabasePull.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 3/6/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation
import FirebaseDatabase
import Firebase


var towns = ["weston", "norwalk", "redding", "westport", "shelton", "danbury", "sherman", "newCanaan", "ridgefield", "newFairfield", "bridgeport", "trumbull", "newtown", "darien", "bethel", "fairfield", "stamford", "brookfield", "easton", "monroe", "greenwich", "wilton", "stratford"]


var allTownObjects = [TownObject]()

protocol DataReturnedDelegate: class {
    func newDataReceieved()

}

var message = ""


class RetrieveMapInfo {
    
    let f = DateFormatter()
    var ref: DatabaseReference!
    
    
    weak var delegate: DataReturnedDelegate?
    
    
    func userDidEnterData(data: Date) {
        ref = Database.database().reference()
        
        f.dateFormat = "yyyyMMdd"
        
        //Date -> selectedDate?
        let formattedDate = f.string(from:data)
        allTownObjects = [TownObject]()
        
       
        
        
        for town in towns {
            ref.child("dates").child(formattedDate).child(town).observeSingleEvent(of: .value, with: { (snapshot)  in
                // Get all percentages
                let totalData = snapshot.value as? NSDictionary
                //iterate through array and set each one
                
                if (totalData == nil) {
                    // Get all percentages
                    //iterate through array and set each one
                    allTownObjects.append(TownObject(name: town, delay: "-", closing: "-", early: "-"))
                    if (allTownObjects.count == 23) {
                        self.delegate?.newDataReceieved()
                        //show loading screen, call db
                        
                    }

                } else {
                    allTownObjects.append(TownObject(name: town, delay: totalData?["delay"] as? String ?? "", closing: totalData?["closing"] as? String ?? "", early: totalData?["early"] as? String ?? ""))
                    if (allTownObjects.count == 23) {
                        self.ref.child("dates").child(formattedDate).observeSingleEvent(of: .value, with: { (snapshot)  in
                            // Get all percentages
                            let totalData = snapshot.value as? NSDictionary
                            message = totalData?["message"] as! String
                            self.delegate?.newDataReceieved()
                        })
                        
                        
                    }
                  
                }
                
                
            })
            
        }
      
        
        
    }
    
    func initialInstall(date: Date) {
        
        ref = Database.database().reference()
        
        f.dateFormat = "yyyyMMdd"
        let formattedDate = f.string(from: date)
        for town in towns {
            ref.child("dates").child(formattedDate).child(town).observeSingleEvent(of: .value, with: { (snapshot)  in
                // Get all percentages
                let totalData = snapshot.value as? NSDictionary
                //iterate through array and set each one
                
                
                if (totalData == nil) {
                    // Get all percentages
                    //iterate through array and set each one
                    allTownObjects.append(TownObject(name: town, delay: "-", closing: "-", early: "-"))
                    
                    if (allTownObjects.count == 23) {
                        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SetSchoolViewController
                      
                        //running code but NOT showing the vc
                        //            present(settingsVC, animated: true, completion: nil)
                        
                        UIApplication.topViewController()?.present(settingsVC, animated: true, completion: nil)
                    }
                    
                } else {
                    allTownObjects.append(TownObject(name: town, delay: totalData?["delay"] as? String ?? "", closing: totalData?["closing"] as? String ?? "", early: totalData?["early"] as? String ?? ""))
                    
                    if (allTownObjects.count == 23) {
                        let settingsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController") as! SetSchoolViewController
                        
                        self.ref.child("dates").child(formattedDate).observeSingleEvent(of: .value, with: { (snapshot)  in
                            // Get all percentages
                            let totalData = snapshot.value as? NSDictionary
                            message = totalData?["message"] as! String
                        })
                        //running code but NOT showing the vc
                        //            present(settingsVC, animated: true, completion: nil)
                        
                        UIApplication.topViewController()?.present(settingsVC, animated: true, completion: nil)
                    }
                    
                    
                }
                
              
            })
            
        }
    }

    

    func initFunc(date: Date) {

        ref = Database.database().reference()

        f.dateFormat = "yyyyMMdd"
        let formattedDate = f.string(from: date)
        for town in towns {
            ref.child("dates").child(formattedDate).child(town).observeSingleEvent(of: .value, with: { (snapshot)  in
                // Get all percentages
                let totalData = snapshot.value as? NSDictionary
                //iterate through array and set each one


                if (totalData == nil) {
                    // Get all percentages
                    //iterate through array and set each one
                    allTownObjects.append(TownObject(name: town, delay: "-", closing: "-", early: "-"))
                    if (allTownObjects.count == 23 ) {
                      
                        GetWeather().getWeatherInitial()
                        
                    }

                } else {
                    allTownObjects.append(TownObject(name: town, delay: totalData?["delay"] as? String ?? "", closing: totalData?["closing"] as? String ?? "", early: totalData?["early"] as? String ?? ""))
                    print("i am here")
                    if (allTownObjects.count == 23 ) {
                        self.ref.child("dates").child(formattedDate).observeSingleEvent(of: .value, with: { (snapshot)  in
                            // Get all percentages
                            let totalData = snapshot.value as? NSDictionary
                            print(totalData?["message"] as! String)
                            message = totalData?["message"] as! String
                            GetWeather().getWeatherInitial()

                        })
                        
                    }


                }

            
            })

        }
    }

}

