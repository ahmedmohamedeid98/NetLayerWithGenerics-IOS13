//
//  ViewController.swift
//  NetworkLayerWithGenerics-IOS13
//
//  Created by Mac OS on 7/2/20.
//  Copyright © 2020 Ahmed Eid. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let api: UsersAPIProtocol = UsersAPI()
        /*
        print("Loading...")
        api.getUsers { (result) in
            switch result {
                case .success(let response):
                    let users = response.data
                    for user in users {
                        print("\(user.firstName), \(user.lastName)")
                }
                case .failure(let err):
                    print("Error: \(err.localizedDescription)")
            }
        }
         
 */
        print("Loading...")
        api.createUser(name: "Ahmed", job: "IOS Developer") { (result) in
            switch result {
                
                case .success(let res):
                    print("Suceess :)")
                    print("name: \(res.name)\njob: \(res.job)\ncreatedAt: \(res.createdAt)\nid: \(res.id)")
                case .failure(let err):
                    print("Failure :(")
                    print("Error: ", err.localizedDescription)
            }
        }
    }


}

