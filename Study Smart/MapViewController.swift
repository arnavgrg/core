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
    
    let CENTER_LATITUDE = Locations.UCLA.latitude
    let CENTER_LONGITUDE = Locations.UCLA.longitude
    let DEFAULT_ZOOM = 15.0
    let upleft = CLLocationCoordinate2D(latitude: 34.072449, longitude: -118.450121)
    let downright = CLLocationCoordinate2D(latitude: 34.063272, longitude: -118.440492)

    var pins:[Pin] = []
    
    override func loadView()
    {
        // Create a GMSCameraPosition that tells the map to display UCLA
        self.camera = GMSCameraPosition.camera(withLatitude: CENTER_LATITUDE, longitude: CENTER_LONGITUDE, zoom: Float(DEFAULT_ZOOM))
        mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = mapView
        
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        let uclaPin = Pin(position: CLLocationCoordinate2DMake(CENTER_LATITUDE, CENTER_LONGITUDE), title: Locations.UCLA.name, map: mapView)
        
        
        mapView.cameraTargetBounds = GMSCoordinateBounds(coordinate: upleft, coordinate: downright)
        
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
    
    
    func setupLibraryPins()
    {
        //Setting up Powell's pin
        let powellPin = Pin(position: CLLocationCoordinate2DMake(Locations.POWELL_LIBRARY.latitude, Locations.POWELL_LIBRARY.longitude), title: Locations.POWELL_LIBRARY.name, map: mapView)
        let powellPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.POWELL_LIBRARY.geofence))
        powellPolygon.map = mapView
        
        powellPin.icon = UIImage(named: "test")
        
        //Setting up YRL's pin
        let yrlPin = Pin(position: CLLocationCoordinate2DMake(Locations.CEYR_LIBRARY.latitude, Locations.CEYR_LIBRARY.longitude), title: Locations.CEYR_LIBRARY.name, map: mapView)
        let yrlPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.CEYR_LIBRARY.geofence))
        yrlPolygon.map = mapView
        
        pins.append(yrlPin)
        pins.append(powellPin)
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
        
        updateOccupancy()
    }

    func updateOccupancy(){
        //
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
}
