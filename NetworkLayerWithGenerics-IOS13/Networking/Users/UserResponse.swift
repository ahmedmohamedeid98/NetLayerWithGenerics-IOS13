//
//  UserResponse.swift
//  NetworkLayerWithGenerics-IOS13
//
//  Created by Mac OS on 7/2/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

class UserResponse: Codable {
    var data: [User]
}

class createdUserResponse: Codable {
    var name: String
    var job: String
    var id: String
    var createdAt: String
}
