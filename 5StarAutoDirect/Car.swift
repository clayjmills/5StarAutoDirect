//
//  Car.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation

struct Car: JSONInitializable {
    
    var make: String
    var model: String
    var budget: String
    var color: String
    var otherAttributes: String?
    
    init(make: String = "", model: String = "", budget: String = "", color: String = "", otherAttributes: String? = nil) {
        self.make = make
        self.model = model
        self.budget = budget
        self.color = color
        self.otherAttributes = otherAttributes
    }
    
    init?(json: JSONObject) {
        guard let make = json[Keys.make] as? String,
            let model = json[Keys.model] as? String,
            let budget = json[Keys.budget] as? String,
            let color = json[Keys.color] as? String
        else { return nil } 
        
        let otherAttributes = json[Keys.otherAttributes] as? String
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


// MARK: - Helper functions. Turns our model object into json form for later use.

extension Car: JSONExportable {
    
    func jsonObject() -> [String: Any] {
        var json = [String: Any]()
        json[Keys.make] = make
        json[Keys.model] = model
        json[Keys.budget] = budget
        json[Keys.color] = color
        json[Keys.otherAttributes] = otherAttributes
        
        return json
    }
    
}
