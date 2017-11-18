//
//  Pin.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 10/30/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation
import GoogleMaps

class Pin: GMSMarker
{
    init(position: CLLocationCoordinate2D, title: String, map: GMSMapView)
    {
        super.init()
        super.position = position
        super.title = title
        super.map = map
    }
}
