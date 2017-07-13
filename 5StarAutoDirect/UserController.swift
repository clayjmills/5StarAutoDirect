//
//  UserController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct UserController {
    
    static var shared = UserController()
    
    var users: [User] = []
    var brokers: [User] = [] // if they're a broker, append here
    
    mutating func createUser(name: String, phone: String, email: String, isBroker: Bool) {
        // check to see if email contains 5starAuto, if so, isBroker is true
        
        let user = User(name: name, phone: phone, email: email, isBroker: isBroker, messages: [])
        users.insert(user, at: 0)
    }
    
    func deleteUser() {
        // TODO: - allow brokers to delete users
    }
    
    static func fetchUsers(completion: @escaping ([User]) -> Void) {
        guard let unwrappedURL = NetworkController.baseURL else { return }
        let url = unwrappedURL.appendingPathExtension("json")
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription) File: \(#file) Line: \(#line)")
                completion([]); return
            }
            
            guard let data = data,
                let jsondictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: [String: String]] else { completion([]); return }
            
            let users = jsondictionary.flatMap({ User(jsonDictionary: $0.value)})
            completion(users)
        }
    }
}
