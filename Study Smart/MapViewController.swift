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
    var detailView: CustomDetailWindow!

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
        uclaPin.icon = UIImage(named: "redpin")
        
        mapView.cameraTargetBounds = GMSCoordinateBounds(path: GMSPath(fromEncodedPath: Locations.UCLA.geofence)!)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        print("HELLO", UIScreen.main.applicationFrame.size.width)
        let geotestButton = setupGeoTestButton()
        let button1 = setupButton(distFromPrevButton: 75.0/6, orientButton: geotestButton, color: .orange)
         let button2 = setupButton(distFromPrevButton: 75.0/6, orientButton: button1, color: .yellow)
         let button3 = setupButton(distFromPrevButton: 75.0/6, orientButton: button2, color: .green)
        let centerButton = setupButton(distFromPrevButton: 75.0/6, orientButton: button3, color: UIColor(red: 0.2863, green: 0.7882, blue: 0, alpha: 1.0))
        setupCenterButton(centerButton: centerButton)
        setupLibraryPins()
        setupDetailView()
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
    func setupButton(distFromPrevButton: CGFloat, orientButton: FABButton, color: UIColor) -> FABButton{
        let button = FABButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(button)
        
        NSLayoutConstraint(item: button, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: button, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: button, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: button, attribute: .left, relatedBy: .equal, toItem: orientButton, attribute: .rightMargin, multiplier: 1.0, constant: distFromPrevButton).isActive = true
        button.layoutIfNeeded()
        button.backgroundColor = color
        return button
    }
    
    
    func setupCenterButton(centerButton: FABButton)
    {
        centerButton.addTarget(self, action:#selector(centerView), for: .touchUpInside)
    }
    
    func setupGeoTestButton() -> FABButton
    {
        let geoTestButton = FABButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        geoTestButton.addTarget(self, action:#selector(geoTest), for: .touchUpInside)
        view.addSubview(geoTestButton)
        
        NSLayoutConstraint(item: geoTestButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: geoTestButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: geoTestButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: geoTestButton, attribute: .left, relatedBy: .equal, toItem: view, attribute: .leftMargin, multiplier: 1.0, constant: 75.0/6).isActive = true
        geoTestButton.translatesAutoresizingMaskIntoConstraints = false
        
        geoTestButton.layoutIfNeeded()
        geoTestButton.backgroundColor = .red
        return geoTestButton
        
    }
    
    func setupLibraryPins()
    {
        //Setting up Powell's pin
        let powellPin = Pin(position: CLLocationCoordinate2DMake(Locations.POWELL_LIBRARY.latitude, Locations.POWELL_LIBRARY.longitude), title: Locations.POWELL_LIBRARY.name, map: mapView)
        let powellPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.POWELL_LIBRARY.geofence))
        powellPolygon.map = mapView
        
        powellPin.icon = UIImage(named: "powell_6")
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
    
    func setupDetailView()
    {
        detailView = CustomDetailWindow(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        detailView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(detailView)
        
        NSLayoutConstraint(item: detailView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 20).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: -20).isActive = true
        
        detailView.layoutIfNeeded()
        detailView.label.text = "TEST"
        detailView.isHidden = true
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
        // let infoWindow = CustomInfoWindow(frame: CGRect(center: marker.infoWindowAnchor, size: CGSize(width: 100, height: 50)))
        let infoWindow = Bundle.main.loadNibNamed("CustomInfoView", owner: nil, options: nil)?.first as! CustomInfoWindow
        infoWindow.label.text = marker.title
        return infoWindow
    }
    
    func mapView(_ mapView: GMSMapView, didTapInfoWindowOf marker: GMSMarker)
    {
        detailView.label.text = marker.title
        detailView.isHidden = false
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
