//
//  UserController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct UserController {
    
    static let shared = UserController()
    
    var users: [User] = []
    var brokers: [User] = [] // This will be to see if they're a broker
    var deletableBroker: [User] = []
    
    mutating func createUser(name: String, phone: String, email: String) {
        let user = User(name: name, phone: phone, email: email, messages: [])
        users.insert(user, at: 0)
    }
    
    func deleteUser() {
        
    }
    

}
