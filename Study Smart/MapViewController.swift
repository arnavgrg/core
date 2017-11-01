//
//  MapViewController.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 10/26/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import UIKit
import GoogleMaps
import Material

class MapViewController: UIViewController, GMSMapViewDelegate {

    var camera: GMSCameraPosition!
    var mapView: GMSMapView!
    
    let CENTER_LATITUDE = 34.0705
    let CENTER_LONGITUDE = -118.4468
    let DEFAULT_ZOOM = 15.0
    
    override func loadView()
    {
        // Create a GMSCameraPosition that tells the map to display UCLA
        self.camera = GMSCameraPosition.camera(withLatitude: CENTER_LATITUDE, longitude: CENTER_LONGITUDE, zoom: Float(DEFAULT_ZOOM))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.07, longitude: -118.45)
        marker.title = "UCLA"
        marker.snippet = "California"
        marker.map = mapView
        
        
        // TODO: Fix the visible area of the map (UCLA).
        setupCenterButton()
        
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupLibraryPins()
    }
    
    func setupCenterButton()
    {
        let centerButton = FABButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        centerButton.addTarget(self, action:#selector(centerView), for: .touchUpInside)
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(centerButton)
        
        NSLayoutConstraint(item: centerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .right, relatedBy: .equal, toItem: view, attribute: .rightMargin, multiplier: 1.0, constant: -20).isActive = true
        
        centerButton.layoutIfNeeded()
    }
    
    //Useful links:
    //https://developers.google.com/maps/documentation/utilities/polylineutility
    //https://www.latlong.net
    func setupLibraryPins()
    {
        //TODO: Clean this up massively, just for testing purposes
        let YRL = CLLocationCoordinate2D(latitude: 34.075221, longitude: -118.441514)
        let pin = Pin(position: YRL, title: "YRL", map: mapView)
        
        //This works! YRL library geofence.
        let YRLpath = GMSPath(fromEncodedPath: "mi~nEde|qUCcE~BE?hE")
        let polygon = GMSPolygon(path: YRLpath)
        polygon.map = mapView
 
        let Powell = CLLocationCoordinate2D(latitude: 34.071796, longitude: -118.442185)
        let pin2 = Pin(position: Powell, title: "Powell", map: mapView)
        
        //This works! YRL library geofence.
        let Powellpath = GMSPath(fromEncodedPath: "qo}nEzc|qU?z@a@@?p@^A@x@eD@?iD")
        let polygon2 = GMSPolygon(path: Powellpath)
        polygon2.map = mapView
        
        /*
        let path = GMSMutablePath()
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.0))
        path.add(CLLocationCoordinate2D(latitude: 37.45, longitude: -122.2))
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.2))
        path.add(CLLocationCoordinate2D(latitude: 37.36, longitude: -122.0))
        
        let rectangle = GMSPolyline(path: path)
        rectangle.map = mapView
         */
    }
    
    @objc func centerView()
    {
        print("centerView() called")
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: CENTER_LATITUDE, longitude: CENTER_LONGITUDE))
        mapView.animate(toZoom: Float(DEFAULT_ZOOM))
        //mapView.updateFocusIfNeeded()
        
        //TODO: Move this test to another button, checking if geofence works
        let YRLpath = GMSPath(fromEncodedPath: "mi~nEde|qUCcE~BE?hE")
        print("Result of geofencing \(GMSGeometryContainsLocation((mapView.myLocation?.coordinate)!, YRLpath!, false))")
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func mapView(_ mapView: GMSMapView, didTap marker: GMSMarker) -> Bool
    {
        print("\(marker.title ?? "nil marker title") clicked!")
        return true;
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
