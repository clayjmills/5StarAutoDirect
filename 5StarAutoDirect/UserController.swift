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
    
    var users: [User] = [] {
        didSet {
            delegate?.usersWereUpdatedTo(users: users, on: self)
        }
    }
    
    weak var delegate: UserControllerDelegate?
    
    static func fetchUsers(completion: (([User]) -> Void)? = nil) {
        guard let unwrappedURL = NetworkController.baseURL else { return }
        let url = unwrappedURL.appendingPathExtension("json")
        
        NetworkController.performRequest(for: url, httpMethod: .Get, urlParameters: nil, body: nil) { (data, error) in
            if let error = error {
                print("Error: \(error.localizedDescription) File: \(#file) Line: \(#line)")
                completion?([]); return
            }
            
            guard let data = data else { completion?([]) ; return }
            guard let jsonDictionary = (try? JSONSerialization.jsonObject(with: data, options: .allowFragments)) as? [String: Any] else { completion?([]); print("got to the data, didn't return it"); return }
            
            let users = jsonDictionary.flatMap({ User(jsonDictionary: $0.1 as! [String : Any], identifier: $0.0)})
            
            DispatchQueue.main.async {
                completion?(users)
            }
        }
    }
    
    static func saveUserToFirebase() {
        
    }
}

protocol UserControllerDelegate: class {
    func usersWereUpdatedTo(users: [User], on controller: UserController)
}
