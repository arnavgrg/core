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
    /*
    static func createUser(completion: @escaping (String) -> ())
    {
        
        let parameters: Parameters = ["email":"test@gmailcom", "authID":125, "location":1,"accuracy":1.0]
        Alamofire.request("http://demo-studysmart.herokuapp.com/user/register/", method: .post, parameters: parameters).response { response in
            
            completion("Response of POST: \(response.error.debugDescription)")
        }
    }
 */
    
    static func getUser(completion: @escaping (String) -> ())
    {
        Alamofire.request("https://demo-studysmart.herokuapp.com/user/124/").response { response in
            
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
    
    static func getLibraryBusiness(completion: @escaping (String) -> ())
    {
        Alamofire.request("https://demo-studysmart.herokuapp.com/library/activity/?library=2&year=2017&month=11&date=18&hours=15").responseJSON { response in
            
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
