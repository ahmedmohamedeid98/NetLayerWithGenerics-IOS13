//
//  UsersAPI.swift
//  NetworkLayerWithGenerics-IOS13
//
//  Created by Mac OS on 7/2/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import Foundation

protocol UsersAPIProtocol {
    func getUsers(completion: @escaping(Result<UserResponse, NSError>) -> Void)
    func createUser(name: String, job: String, completion:@escaping(Result<createdUserResponse, NSError>) -> ())
}

class UsersAPI: BaseAPI<UsersNetworking>, UsersAPIProtocol {
    
    func getUsers(completion: @escaping(Result<UserResponse, NSError>) -> Void) {
        self.fetchData(target: .getUsers, responseClass: UserResponse.self, completion: completion)
    }
    
    func createUser(name: String, job: String, completion:@escaping(Result<createdUserResponse, NSError>) -> ()) {
        self.postData(target: .createUser(name: name, job: job), responseClass: createdUserResponse.self, completion: completion)
    }
    
}
