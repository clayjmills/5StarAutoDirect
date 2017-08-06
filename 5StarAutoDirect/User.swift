//
//  User.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

class User {
    
    let name: String
    let phone: String
    let email: String
    let isBroker: Bool
    var messages: [Message] = []
    var car: Car
    var identifier: String
    
    init(name: String, phone: String, email: String, isBroker: Bool, messages: [Message], car: Car, identifier: String) {
        self.name = name
        self.phone = phone
        self.email = email
        self.isBroker = isBroker
        self.messages = messages
        self.car = car
        self.identifier = identifier
    }
    
    init?(jsonDictionary: [String: Any], identifier: String) {
        guard let name = jsonDictionary[Keys.name] as? String,
            let phone = jsonDictionary[Keys.phone] as? String,
            let email = jsonDictionary[Keys.email] as? String,
            let isBroker = jsonDictionary[Keys.isBroker] as? Bool,
            let carDictionary = jsonDictionary[Keys.car] as? [String:String],
            let car = Car(dictionary: carDictionary)
        else { return nil } // TODO: - add something for [message]
        
        self.name = name
        self.phone = phone
        self.email = email
        self.isBroker = isBroker
        self.car = car
        self.identifier = identifier
    }
    
    var jsonRepresentation: [String: Any] {
        
        return [nameKey: name, phoneKey: phone, emailKey: email, isBrokerKey: isBroker, carKey: car.dictionaryRepresentation]
    }
    
    var jsonData: Data? {
        let data = try? JSONSerialization.data(withJSONObject: jsonRepresentation, options: .prettyPrinted)
        return data
    }
}

extension User: Equatable {
    static func ==(lhs: User, rhs: User) -> Bool {
        return lhs.name == rhs.name && lhs.phone == rhs.phone && lhs.email == rhs.email && lhs.isBroker == rhs.isBroker && lhs.messages == rhs.messages && lhs.car == rhs.car && lhs.identifier == rhs.identifier
    }
} 
