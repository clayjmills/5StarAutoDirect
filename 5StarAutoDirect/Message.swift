//
//  Message.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Foundation

class Message: NSObject {
    
    private let textKey = "text"
    private let toIDKey = "name"
    
    var text: String
    var toID: String
    //TODO: - creat user id 
    
    init(text: String, toID: String) {
        self.text = text
        self.toID = toID
    }
    
    init?(jsonDictionary: [String: Any]) {
        guard let text = jsonDictionary[textKey] as? String,
            let toID = jsonDictionary[toIDKey] as? String else { return nil }
        self.text = text
        self.toID = toID
    }
}
