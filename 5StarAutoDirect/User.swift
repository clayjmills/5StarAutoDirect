//
//  User.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct User {
    
    private let nameKey = "name"
    private let phoneKey = "phone"
    private let emailKey = "email"
    private let isBrokerKey = "isBroker"
    
    let name: String
    let phone: String?
    let email: String?
    let isBroker: Bool
    var messages: [Message] = []
    //    var currentStep: CurrentStep
    
    init(name: String, phone: String, email: String, isBroker: Bool, messages: [Message]) {
        self.name = name
        self.phone = phone
        self.email = email
        self.isBroker = isBroker
        self.messages = messages
    }
    
    init?(jsonDictionary: [String: Any]) {
        guard let name = jsonDictionary[nameKey] as? String,
        let phone = jsonDictionary[phoneKey] as? String,
        let email = jsonDictionary[emailKey] as? String,
        let isBroker = jsonDictionary[isBrokerKey] as? Bool else { return nil } // TODO: - add something for [message] and isBroker
        
        self.name = name
        self.phone = phone
        self.email = email
        self.isBroker = isBroker
    }
    
    var jsonRepresentation: [String: Any] {
        return [nameKey: self.name, phoneKey: self.phone, emailKey: self.email, isBrokerKey: self.isBroker]
    }
    
    var jsonData: Data? {
        let data = try? JSONSerialization.data(withJSONObject: jsonRepresentation, options: .prettyPrinted)
        return data
    }
}

public enum CurrentStep {
    case One
    case Two
    case Three
    case Four
    case Five
    
    init() {
        self = .One
    }
}
