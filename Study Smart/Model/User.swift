//
//  User.swift
//  Study Smart
//
//  Created by Anton Lykov on 10/28/17.
//  Copyright © 2017 UCLA DevX. All rights reserved.
//

import Foundation

struct User {
    let ID: String
    let name: String
    let email: String
    
    init(id: String, name: String, email: String) {
        self.ID = id
        self.name = name
        self.email = email
    }
}
