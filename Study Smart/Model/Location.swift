//
//  Location.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 11/3/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation

struct Location: Hashable
{
    var hashValue: Int {
        return ID.hashValue
    }
    
    static func ==(lhs: Location, rhs: Location) -> Bool {
        return lhs.ID == rhs.ID
    }
    
    let name: String
    let ID: Int
    let geofence: String
    let latitude: Double
    let longitude: Double
    
    //powell = 1
    //YRL = 2
    //Law = 3
    //Business = 4
    
    init(name: String, ID: Int, geofence: String, latitude: Double, longitude: Double)
    {
        self.name = name
        self.ID = ID
        self.geofence = geofence
        self.latitude = latitude
        self.longitude = longitude
    }
}
