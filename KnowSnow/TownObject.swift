//
//  TownObject.swift
//  KnowSnow
//
//  Created by Jack Sharkey on 5/24/17.
//  Copyright © 2017 Jack Sharkey. All rights reserved.
//

import Foundation

struct TownObject {
    var name = String()
    var delay = String()
    var closing = String()
    var early = String()
    var lat = Double()
    var long = Double()
    var fullName = String();
    
    init(name: String, delay: String, closing: String, early: String) {
        self.name = name;
        self.delay = delay
        self.closing = closing;
        self.early = early;
        self.fullName = name.capitalized + " Public Schools";
        
        switch name {
        case "sherman":
            self.lat = 41.578642;
            self.long = -73.497418;
        case "newFairfield":
            self.lat = 41.466099;
            self.long = -73.485646;
            self.fullName = "New Fairfield Public Schools";
        case "brookfield":
            self.lat = 41.482595;
            self.long = -73.409565;
        case "danbury":
            self.lat = 41.394817;
            self.long = -73.454011;
        case "bethel":
            self.lat = 41.371228;
            self.long = -73.413962;
        case "newtown":
            self.lat = 41.414117;
            self.long = -73.303565;
        case "ridgefield":
            self.lat = 41.284063;
            self.long = -73.497541;
        case "redding":
            self.lat = 41.30454;
            self.long = -73.392898;
        case "monroe":
            self.lat = 41.332596;
            self.long = -73.207336;
        case "shelton":
            self.lat = 41.316486;
            self.long = -73.093164;
        case "trumbull":
            self.lat = 41.242856;
            self.long = -73.200664;
        case "easton":
            self.lat = 41.271206;
            self.long = -73.29664;
        case "weston":
            self.lat = 41.200929;
            self.long = -73.380675;
        case "wilton":
            self.lat = 41.195374;
            self.long = -73.437899;
        case "newCanaan":
            self.lat = 41.146763;
            self.long = -73.494844;
            self.fullName = "New Canaan Public Schools";
        case "stamford":
            self.lat = 41.05343;
            self.long = -73.538734;
        case "greenwich":
            self.lat = 41.026242;
            self.long = -73.628196;
        case "darien":
            self.lat = 41.077191;
            self.long = -73.468686;
        case "norwalk":
            self.lat = 41.117744;
            self.long = -73.408158;
        case "westport":
            self.lat = 41.141472;
            self.long = -73.357905;
        case "fairfield":
            self.lat = 41.140836;
            self.long = -73.261261;
        case "bridgeport":
            self.lat = 41.186548;
            self.long = -73.195177;
        case "stratford":
            self.lat = 41.184541;
            self.long = -73.133165;
        default:
            print("error")
        }
        
        
    
    }
    
    
}
