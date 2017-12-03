//
//  AlamofireQuery.swift
//  Study Smart
//
//  Created by Parth Pendurkar on 11/27/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class AlamofireQuery
{
    //TODO: Clean up
    static func createUser(withEmail email: String, andID authID: Int, andLocationPermissions permissions: Int, andAccuracy accuracy: Double, withCompletionHandler completion: @escaping (String) -> ())
    {
        let url = "http://demo-studysmart.herokuapp.com/user/register/"
        let parameters: Parameters = ["email":email, "authID":authID, "location":permissions, "accuracy":accuracy]
        
        Alamofire.request(url, method: .post, parameters: parameters).response { response in
            
            completion("Response of POST: \(response.response.debugDescription)")
        }
    }
    
    //TODO: Clean up
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
    
    static func getLibraryBusinessDuringHour(hour: Int, ofLibrary library: Int, onDate date: Date, withCompletion completion: @escaping (String, Int) -> ())
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let url = "https://demo-studysmart.herokuapp.com/library/activity/"
        let parameters: Parameters = ["library":library, "year":year, "month":month, "date":day, "hours":hour];
        
        var overall = -1
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let statusCode = response.response?.statusCode
            {
                if (statusCode == 200)
                {
                    switch response.result
                    {
                    case .success(let data):
                        let json = JSON(data).dictionaryObject!
                        //print("JSON: \(json)") // serialized json response
                        overall = json["overall"] as! Int
                        completion("Success", overall)
                    case .failure(let error):
                        completion("Error! \(error.localizedDescription)", overall)
                    }
                }
                else
                {
                    completion("Error! Status code is \(statusCode), not 200", overall)
                }
            }
            else
            {
                completion("Error! \(response.debugDescription)", overall)
            }
        }
    }
    
    static func getLibraryBusinessDuringDay(date: Date, ofLibrary library: Int, withCompletion completion: @escaping (String, Int, Int) -> ())
    {
        let calendar = Calendar.current
        let components = calendar.dateComponents([.year, .month, .day], from: date)
        let year = components.year!
        let month = components.month!
        let day = components.day!
        
        let url = "https://demo-studysmart.herokuapp.com/library/hours/"
        let parameters: Parameters = ["library":library, "year":year, "month":month, "date":day];
        
        var open = -1;
        var close = -1;
        Alamofire.request(url, method: .get, parameters: parameters).responseJSON { response in
            if let statusCode = response.response?.statusCode
            {
                if (statusCode == 200)
                {
                    switch response.result
                    {
                    case .success(let data):
                        let json = JSON(data).dictionaryObject!
                        //print("JSON: \(json)") // serialized json response
                        open = json["open"] as! Int
                        close = json["close"] as! Int
                        completion("Success", open, close)
                    case .failure(let error):
                        completion("Error! \(error.localizedDescription)", open, close)
                    }
                }
                else
                {
                    completion("Error! Status code is \(statusCode), not 200", open, close)
                }
            }
            else
            {
                completion("Error! \(response.debugDescription)", open, close)
            }
        }
    }
}
