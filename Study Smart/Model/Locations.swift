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
    static let UCLA = Location(name: "UCLA", ID: 0, geofence: "ukznEhl|qU_oCtwBwHabD~r@cH", latitude: 34.07020, longitude: -118.44270)
    
    //Powell Library
    static let POWELL_LIBRARY = Location(name: "Powell Library", ID: 1, geofence: "qo}nEzc|qU?z@a@@?p@^A@x@eD@?iD", latitude: 34.071796, longitude: -118.442185)
    
    //Charles E. Young Research Library
    static let CEYR_LIBRARY = Location(name: "Young Research Library", ID: 2, geofence: "mi~nEde|qUCcE~BE?hE", latitude: 34.075221, longitude: -118.441514)
    
    //Darling Law Library
    static let LAW_LIBRARY = Location(name: "Darling Law Library", ID: 3, geofence: "q}}nE`n{qU?vAT??i@b@??h@r@??{A", latitude: 34.0729138, longitude: -118.4384435)
    
    //Rosenfeld Business Library
    static let BUSINESS_LIBRARY = Location(name: "Rosenfeld Business Library", ID: 4, geofence: "}d~nE~l|qU@dBv@J?a@H@AuA", latitude: 34.0738081, longitude: -118.4436508)
}
