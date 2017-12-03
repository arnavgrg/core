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
    var libraries: [Location: [String:Int]] = [Locations.POWELL_LIBRARY:[:],Locations.CEYR_LIBRARY:[:]]
    
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(populateHours), name: Notification.Name.UIApplicationDidBecomeActive, object: nil)
    }
    
    override func loadView()
    {
        populateHours()
        
        // Create a GMSCameraPosition that tells the map to display UCLA
        self.camera = GMSCameraPosition.camera(withLatitude: CENTER_LATITUDE, longitude: CENTER_LONGITUDE, zoom: Float(DEFAULT_ZOOM))
        self.mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        mapView.isMyLocationEnabled = true
        // Change properties of the map
        
        do {
            // Set the map style by passing the URL of the local file.
            if let styleURL = Bundle.main.url(forResource: "Style", withExtension: "json") {
                mapView.mapStyle = try GMSMapStyle(contentsOfFileURL: styleURL)
            } else {
                NSLog("Unable to find style.json")
            }
        } catch {
            NSLog("One or more of the map styles failed to load. \(error)")
        }
        
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
        
       
        setupCenterButton()
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
    @objc func populateHours()
    {
        let populateGroup = DispatchGroup()
        
        let currentDate = Date()
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: currentDate)
        
        for library in libraries.keys
        {
            populateGroup.enter()
            AlamofireQuery.getLibraryHoursDuringDay(date: currentDate, ofLibrary: library.ID, withCompletion: { (result, open, close) in
                self.libraries[library]!["open"] = open
                self.libraries[library]!["close"] = close
                print("\(result) for populating hours for \(library.name)")
                defer { populateGroup.leave() } //ensures leave()'s are balanced with enter()'s
            })
            
            populateGroup.enter()
            AlamofireQuery.getLibraryBusinessDuringHour(hour: hour, ofLibrary: library.ID, onDate: currentDate, withCompletion: { result, business in
                self.libraries[library]!["business"] = business
                print("\(result) for populating hour \(hour) business for \(library.name)")
                defer { populateGroup.leave() }
            })
        }
        
        populateGroup.notify(queue: DispatchQueue.main)
        {
            print(self.libraries.debugDescription)
        }
    }
   
    func setupCenterButton()
    {
        let centerButton = FABButton(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        centerButton.addTarget(self, action:#selector(centerView), for: .touchUpInside)
        view.addSubview(centerButton)
        
        NSLayoutConstraint(item: centerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 60).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottomMargin, multiplier: 1.0, constant: -20).isActive = true
        NSLayoutConstraint(item: centerButton, attribute: .centerX, relatedBy: .equal, toItem: view, attribute: .centerX, multiplier: 1.0, constant: 0.0).isActive = true
        centerButton.translatesAutoresizingMaskIntoConstraints = false
        
        centerButton.layoutIfNeeded()
        centerButton.backgroundColor = .red
        centerButton.addTarget(self, action:#selector(centerView), for: .touchUpInside)
    }

    
    func setupLibraryPins()
    {
  
        //Setting up Powell's pin
        let powellPin = Pin(position: CLLocationCoordinate2DMake(Locations.POWELL_LIBRARY.latitude, Locations.POWELL_LIBRARY.longitude), title: Locations.POWELL_LIBRARY.name, map: mapView)
        let powellPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.POWELL_LIBRARY.geofence))
        powellPolygon.map = mapView
        
        powellPin.icon = UIImage(named: "POWELL")
        powellPin.infoWindowAnchor = CGPoint(x: 0, y: 0)
        
        //Setting up YRL's pin
        let yrlPin = Pin(position: CLLocationCoordinate2DMake(Locations.CEYR_LIBRARY.latitude, Locations.CEYR_LIBRARY.longitude), title: Locations.CEYR_LIBRARY.name, map: mapView)
        let yrlPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.CEYR_LIBRARY.geofence))
        yrlPolygon.fillColor = nil
        yrlPolygon.map = mapView
        yrlPin.icon = UIImage(named: "YRL")
        yrlPin.infoWindowAnchor = CGPoint(x: 0, y: 0)
        
        //Setting up Business's pin
        let businessPin = Pin(position: CLLocationCoordinate2DMake(Locations.BUSINESS_LIBRARY.latitude, Locations.BUSINESS_LIBRARY.longitude), title: Locations.BUSINESS_LIBRARY.name, map: mapView)
        let businessPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.BUSINESS_LIBRARY.geofence))
        businessPolygon.map = mapView
        businessPin.icon = UIImage(named: "BUSINESS_LIBRARY")
        businessPin.infoWindowAnchor = CGPoint(x: 0, y: 0)
        
        //Setting up Darling's pin
        let lawPin = Pin(position: CLLocationCoordinate2DMake(Locations.LAW_LIBRARY.latitude, Locations.LAW_LIBRARY.longitude), title: Locations.LAW_LIBRARY.name, map: mapView)
        let lawPolygon = GMSPolygon(path: GMSPath(fromEncodedPath: Locations.LAW_LIBRARY.geofence))
        lawPolygon.map = mapView
        lawPin.icon = UIImage(named: "LAW_LIBRARY")
        lawPin.infoWindowAnchor = CGPoint(x: 0, y: 0)
        
        pins.append(lawPin)
        pins.append(businessPin)
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
        
        NSLayoutConstraint(item: detailView, attribute: .top, relatedBy: .equal, toItem: view, attribute: .top, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .left, relatedBy: .equal, toItem: view, attribute: .left, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .right, relatedBy: .equal, toItem: view, attribute: .right, multiplier: 1.0, constant: 0).isActive = true
        NSLayoutConstraint(item: detailView, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1.0, constant: 0).isActive = true
        
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
        
        
//        AlamofireQuery.createUser(withEmail: "test3@gmail.com", andID: 321, andLocationPermissions: 1, andAccuracy: 1.0) { result in
//            print(result)
//            AlamofireQuery.getUser(withID: 321, withCompletion: { result in
//                print(result)
//
//                let formatter = DateFormatter()
//                formatter.dateFormat = "yyyy/MM/dd"
//                let testDate = formatter.date(from: "2017/11/18")
//
//                AlamofireQuery.getLibraryBusinessDuringHour(hour: 15, ofLibrary: 2, onDate: testDate!, withCompletion: { result in
//                    print(result)
//                })
//            })
//        }
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let testDate = formatter.date(from: "2017/12/02")
//        AlamofireQuery.getLibraryBusinessDuringDay(date: testDate!, ofLibrary: Locations.POWELL_LIBRARY.ID) { result, open, close  in
//            print(open)
//            print(close)
//            print(result)
//        }
//
//        AlamofireQuery.getLibraryBusinessDuringHour(hour: 15, ofLibrary: Locations.POWELL_LIBRARY.ID, onDate: testDate!) { result, overall in
//            print(overall)
//            print(result)
//        }
        
        print(libraries.debugDescription)
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
        let infoWindow = CustomInfoWindow(frame: CGRect(center: marker.infoWindowAnchor, size: CGSize(width: 225, height: 145)))
        let labelAttributes: [NSAttributedStringKey : Any] = [
            NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue,
            NSAttributedStringKey.font: UIFont(name: "Avenir-Heavy", size: 14.0)!]
        
        infoWindow.label.attributedText = NSAttributedString(string: marker.title!, attributes: labelAttributes)
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

extension MapViewController
{
    func getPinColor(busyness: Int) -> UIColor
    {
        let empty = 0x64B0CC
        let not_busy = 0x5DB58F
        let busy = 0xF7D64A
        let very_busy = 0xF49B78
        let packed = 0xF1562D
        
        var libColor: Int
        switch busyness {
        case 0..<25:
            libColor = empty
        case 25..<50:
            libColor = not_busy
        case 50..<70:
            libColor = busy
        case 70..<90:
            libColor = very_busy
        case 90..<101:
            libColor = packed
        default:
            libColor = 0x000000
        }
        
        return UIColor(rgb: libColor)
    }
}

extension UIColor {
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}
