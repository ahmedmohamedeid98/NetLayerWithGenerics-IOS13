//
//  User.swift
//  NetworkLayerWithGenerics-IOS13
//
//  Created by Mac OS on 7/2/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

struct User: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys : String, CodingKey {
        case firstName = "first_name"
        case lastName  = "last_name"
    }
}
