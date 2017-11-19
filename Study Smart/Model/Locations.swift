//
//  File.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 11/3/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation

//Useful links for generating geofences and such:
//https://developers.google.com/maps/documentation/utilities/polylineutility
//https://www.latlong.net
struct Locations
{
    //UCLA
    static let UCLA = Location(name: "UCLA", geofence: "ukznEhl|qU_oCtwBwHabD~r@cH", latitude: 34.07020, longitude: -118.44670)
    
    //Powell Library
    static let POWELL_LIBRARY = Location(name: "Powell Library", geofence: "qo}nEzc|qU?z@a@@?p@^A@x@eD@?iD", latitude: 34.071796, longitude: -118.442185)
    
    //Charles E. Young Research Library
    static let CEYR_LIBRARY = Location(name: "YRL", geofence: "mi~nEde|qUCcE~BE?hE", latitude: 34.075221, longitude: -118.441514)
    
    static let LAW_LIBRARY = Location(name: "Darling Law Library", geofence: "", latitude: 34.0729138, longitude: -118.4384435)
    
    static let BUSINESS_LIBRARY = Location(name: "Rosenfeld Business Library", geofence: "", latitude: 34.0738081, longitude: -118.4436508)
}
