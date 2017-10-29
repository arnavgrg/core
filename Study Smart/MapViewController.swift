//
//  MapViewController.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 10/26/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import UIKit
import GoogleMaps

class MapViewController: UIViewController {

    var camera: GMSCameraPosition!
    
    override func loadView()
    {
        // Create a GMSCameraPosition that tells the map to display the
        // coordinate -33.86,151.20 at zoom level 6.
        self.camera = GMSCameraPosition.camera(withLatitude: 34.07, longitude: -118.45, zoom: 15.0)
        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
        view = mapView
        
        // Creates a marker in the center of the map.
        let marker = GMSMarker()
        marker.position = CLLocationCoordinate2D(latitude: 34.07, longitude: -118.45)
        marker.title = "UCLA"
        marker.snippet = "California"
        marker.map = mapView
        
        
        // TODO:
        // 1. Fix the visible area of the map (UCLA).
        // 2.
        
        let backToOrigViewButton = UIButton()
        backToOrigViewButton.frame = CGRect(x: 0, y: 500, width: 40, height: 40)
        backToOrigViewButton.addTarget(self, action:#selector(backToOrigView), for: .touchUpInside)
    }
    
    override func viewDidLoad()
    {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @objc func backToOrigView(){
        // TODO:
        // Bring camera to original view. 
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
