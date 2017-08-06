//
//  Car.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

class Car {
    var make: String
    var model: String
    var budget: String
    var color: String
    var otherAttributes: String
    
    var dictionaryRepresentation: [String:String] {
        return ["make":make, "model":model, "budget":budget, "color": color, "otherAttributes": otherAttributes]
    }
    
    init(make: String, model: String, budget: String, color: String, otherAttributes: String) {
        self.make = make
        self.model = model
        self.budget = budget
        self.color = color
        self.otherAttributes = otherAttributes
    }
    
    init?(dictionary: [String: Any]) {
        guard let make = dictionary[Keys.make] as? String,
            let model = dictionary[Keys.model] as? String,
            let budget = dictionary[Keys.budget] as? String,
            let color = dictionary[Keys.color] as? String,
            let otherAttributes = dictionary[Keys.otherAttributes] as? String
        else { return nil } 
        
        self.make = make
        self.model = model
        self.budget = budget
        self.color = color
        self.otherAttributes = otherAttributes
    }
}

extension Car: Equatable {
    static func ==(lhs: Car, rhs: Car) -> Bool {
        return lhs.make == rhs.make && lhs.model == rhs.model && lhs.budget == rhs.budget && lhs.color == rhs.color && lhs.otherAttributes == rhs.otherAttributes
    }
}
