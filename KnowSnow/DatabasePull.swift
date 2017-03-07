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

class RetrieveMapInfo {
    
    init () {
    var ref: FIRDatabaseReference!
    
    ref = FIRDatabase.database().reference()
        
        let userID = FIRAuth.auth()?.currentUser?.uid
        ref.child("towns").child("westport").observeSingleEvent(of: .value, with: { (snapshot) in
            // Get user value
            let value = snapshot.value as? NSDictionary
            let username = value?["closing"] as? String ?? ""
            print(value);
            print(username)
            // ...
        }) { (error) in
            print(error.localizedDescription)
        }
    }

}
