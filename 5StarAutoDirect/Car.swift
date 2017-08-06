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
    var otherAttributes: String?
    
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

//FIXME: - potential
extension Car: Equatable { }

func ==(lhs: Car, rhs: Car) -> Bool {
    return lhs.make == rhs.make && lhs.model == rhs.model && lhs.budget == rhs.budget && lhs.color == rhs.color && lhs.otherAttributes == rhs.otherAttributes
}


// MARK: - Helper functions. Turns our model object into dictionary form for later use.

extension Car {
    
    func dictionaryRepresentation() -> [String: Any] {
        
        var dictionary = [String: Any]()
        dictionary[Keys.make] = make
        dictionary[Keys.model] = model
        dictionary[Keys.budget] = budget
        dictionary[Keys.color] = color
        dictionary[Keys.otherAttributes] = otherAttributes
        
        return dictionary
    }
    
}
