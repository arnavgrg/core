//
//  AlamofireQuery.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 11/27/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation
import Alamofire

class AlamofireQuery
{
    static func createUser(withEmail email: String, andID authID: Int, andLocationPermissions permissions: Int, andAccuracy accuracy: Double, withCompletionHandler completion: @escaping (String) -> ())
    {
        let url = "http://demo-studysmart.herokuapp.com/user/register/"
        let parameters: Parameters = ["email":email, "authID":authID, "location":permissions, "accuracy":accuracy]
        
        Alamofire.request(url, method: .post, parameters: parameters).response { response in
            
            completion("Response of POST: \(response.response.debugDescription)")
        }
    }
    
    static func getUser(withID authID: Int, withCompletion completion: @escaping (String) -> ())
    {
        var url = "https://demo-studysmart.herokuapp.com/user/"
        url += String(authID)
        url += "/"
        
        Alamofire.request(url).response { response in
            
            if let statusCode = response.response?.statusCode
            {
                print("Data: \(statusCode)") // original server data as UTF8 string
                completion("Success!")
            }
            else
            {
                completion("Error!")
            }
        }
    }
    
    static func getLibraryBusinessDuringHour(hour: Int, ofLibrary library: Int, onDate date: Date, withCompletion completion: @escaping (String) -> ())
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let url = "https://demo-studysmart.herokuapp.com/library/activity/"
        let parameters: Parameters = ["library":library, "year":year, "month":month, "date":day, "hours":hour];
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                completion("Success!")
            }
            else
            {
                completion("Error!")
            }
        }
    }
    
    static func getLibraryBusinessDuringDay(date: Date, ofLibrary library: Int, withCompletion completion: @escaping (String) -> ())
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let url = "https://demo-studysmart.herokuapp.com/library/hours/"
        let parameters: Parameters = ["library":library, "year":year, "month":month, "date":day];
        
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let json = response.result.value {
                print("JSON: \(json)") // serialized json response
                completion("Success!")
            }
            else
            {
                completion("Error!")
            }
        }
    }
}
