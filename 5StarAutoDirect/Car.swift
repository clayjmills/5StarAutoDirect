//
//  Car.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct Car {
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
    
    init?(dictionary: [String:String]) {
        guard let make = dictionary["make"],
            let model = dictionary["model"],
            let budget = dictionary["budget"],
            let color = dictionary["color"],
            let otherAttributes = dictionary["otherAttributes"]
        else { return nil }
        
        self.make = make
        self.model = model
        self.budget = budget
        self.color = color
        self.otherAttributes = otherAttributes
    }
}
