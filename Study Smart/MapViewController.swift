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
import CoreLocation

class MapViewController: UIViewController
{
    //Global constants
    let CENTER_LATITUDE = Locations.UCLA.latitude
    let CENTER_LONGITUDE = Locations.UCLA.longitude
    let DEFAULT_ZOOM = 15.0
    
    var camera: GMSCameraPosition!
    var mapView: GMSMapView!
    var locationManager: CLLocationManager!

    var pins:[Pin] = []
    
    override func loadView()
    {
        // Create a GMSCameraPosition that tells the map to display UCLA
        self.camera = GMSCameraPosition.camera(withLatitude: CENTER_LATITUDE, longitude: CENTER_LONGITUDE, zoom: Float(DEFAULT_ZOOM))
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        view = self.mapView
        self.mapView.delegate = self
        
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        
        
        // Creates a marker in the center of the map.
        let uclaPin = Pin(position: CLLocationCoordinate2DMake(CENTER_LATITUDE, CENTER_LONGITUDE), title: Locations.UCLA.name, map: self.mapView)
        
        mapView.cameraTargetBounds = GMSCoordinateBounds(path: GMSPath(fromEncodedPath: Locations.UCLA.geofence)!)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupCenterButton()
        setupGeoTestButton()
        setupLibraryPins()
    }
    
    func updateOccupancy()
    {
        //TODO: Discuss how are we getting info.
    }
    
    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension MapViewController
{
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
    
    func setupGeoTestButton()
    {
        let geoTestButton = FABButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        geoTestButton.addTarget(self, action:#selector(geoTest), for: .touchUpInside)
        view.addSubview(geoTestButton)
        
        NSLayoutConstraint(item: geoTestButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: geoTestButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: geoTestButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: geoTestButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1.0, constant: 20).isActive = true
        geoTestButton.translatesAutoresizingMaskIntoConstraints = false
        
        geoTestButton.layoutIfNeeded()
        
    }
    
    func setupLibraryPins()
    {
        //Setting up Powell's pin
        let powellPin = Pin(position: CLLocationCoordinate2DMake(Locations.POWELL_LIBRARY.latitude, Locations.POWELL_LIBRARY.longitude), title: Locations.POWELL_LIBRARY.name, map: mapView)
        let powellPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.POWELL_LIBRARY.geofence))
        powellPolygon.map = mapView
        
        powellPin.icon = UIImage(named: "bluepowell")
        powellPin.infoWindowAnchor = CGPoint(x: 0, y: 0)
        //Setting up YRL's pin
        let yrlPin = Pin(position: CLLocationCoordinate2DMake(Locations.CEYR_LIBRARY.latitude, Locations.CEYR_LIBRARY.longitude), title: Locations.CEYR_LIBRARY.name, map: mapView)
        let yrlPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.CEYR_LIBRARY.geofence))
        yrlPolygon.fillColor = nil
        yrlPolygon.map = mapView
        yrlPin.icon = UIImage(named: "blueyrl")
        yrlPin.infoWindowAnchor = CGPoint(x: 0, y: 0)
        
        pins.append(yrlPin)
        pins.append(powellPin)
        
        yrlPolygon.fillColor = nil
        powellPolygon.fillColor = nil
    }
}

@objc
extension MapViewController
{
    func centerView()
    {
        print("centerView() called")
        mapView.animate(toLocation: CLLocationCoordinate2D(latitude: CENTER_LATITUDE, longitude: CENTER_LONGITUDE))
        mapView.animate(toZoom: Float(DEFAULT_ZOOM))
        //mapView.updateFocusIfNeeded()
        
        updateOccupancy()
    }
    
    func geoTest()
    {
        let YRLpath = GMSPath(fromEncodedPath: Locations.CEYR_LIBRARY.geofence)
        let result = GMSGeometryContainsLocation((mapView.myLocation?.coordinate)!, YRLpath!, false)
        print("Result of geofencing \(result)")
    }
}

extension MapViewController: GMSMapViewDelegate
{
    func mapView(_ mapView: GMSMapView, markerInfoWindow marker: GMSMarker) -> UIView?
    {
        let infoWindow: CustomInfoView = Bundle.main.loadNibNamed("infoView", owner: nil, options: nil)?.first as! CustomInfoView
        infoWindow.locationName.text = marker.title
        print(infoWindow.locationName.text ?? "nil")
        return infoWindow
    }
    
    // MARK: Needed to create the custom info window
    /*
     func mapView(_ mapView: GMSMapView, didChange position: GMSCameraPosition) {
     if (locationMarker != nil){
     guard let location = locationMarker?.position else {
     print("locationMarker is nil")
     return
     }
     infoWindow.center = mapView.projection.point(for: location)
     infoWindow.center.y = infoWindow.center.y - sizeForOffset(view: infoWindow)
     }
     }
     */
    
    // MARK: Needed to create the custom info window
    /*
     func mapView(_ mapView: GMSMapView, didTapAt coordinate: CLLocationCoordinate2D) {
     infoWindow.removeFromSuperview()
     }
     */
}

extension MapViewController: CLLocationManagerDelegate
{
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
    {
        if status == .authorizedWhenInUse
        {
            // authorized location status when app is in use; update current location
            locationManager.startUpdatingLocation()
            // implement additional logic if needed...
        }
        // implement logic for other status values if needed...
    }
}
