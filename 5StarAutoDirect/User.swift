//
//  User.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct User {
    let name: String
    let phone: String?
    let email: String?
    
    let isBroker: Bool /* {
        if email?.contains("5StarAutoDirect")
    }*/
    
    var messages: [Message] = []
    
    var currentStep: CurrentStep
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
