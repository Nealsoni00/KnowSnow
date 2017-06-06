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

class RetrieveMapInfo {
    
    
    var ref: FIRDatabaseReference!


    func initFunc() {
        
        ref = FIRDatabase.database().reference()
        
        for town in towns {
        ref.child("towns").child(town).observeSingleEvent(of: .value, with: { (snapshot)  in
            // Get all percentages
            let totalData = snapshot.value as? NSDictionary
            //iterate through array and set each one
            
            allTownObjects.append(TownObject(name: town, delay: totalData?["delay"] as? String ?? "", closing: totalData?["closing"] as? String ?? "", early: totalData?["early"] as? String ?? ""))
            
            
        })

        }
    }



}
