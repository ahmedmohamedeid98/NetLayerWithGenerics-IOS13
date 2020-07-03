//
//  UsersNetworking.swift
//  NetworkLayerWithGenerics-IOS13
//
//  Created by Mac OS on 7/2/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation
import Alamofire

enum UsersNetworking {
    case getUsers
    case createUser(name: String, job: String)
}

extension UsersNetworking: TargetType {
    var baseURL: String {
        switch self {
            default: return "https://reqres.in/api"
        }
    }
    
    var path: String {
        switch self {
            case .getUsers: return "/users"
            case .createUser: return "/users"
        }
    }
    
    var method: HTTPMethod {
        switch self {
            case .getUsers: return .get
            case .createUser: return .post
        }
    }
    
    var task: Task {
        switch self {
            case .getUsers: return .requestPlain
            case .createUser(let name, let job): return .requestParameters(["name": name, "job": job], URLEncoding.default)
        }
    }
    
    var header: [String : String]? {
        switch self {
            default: return [:]
        }
    }
    
    
}
