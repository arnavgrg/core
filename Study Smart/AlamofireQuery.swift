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
}
