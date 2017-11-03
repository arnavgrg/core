//
//  Location.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 11/3/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation

struct Location
{
    let name: String
    let geofence: String
    let latitude: Double
    let longitude: Double
    
    init(name: String, geofence: String, latitude: Double, longitude: Double)
    {
        self.name = name
        self.geofence = geofence
        self.latitude = latitude
        self.longitude = longitude
    }
}
