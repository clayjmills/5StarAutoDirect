//
//  Message.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import UIKit
import Foundation

// Alex added identifier property
class Message: NSObject {
    
    private let textKey = "text"
    private let toIDKey = "toID"
    
    var text: String
    var toID: String
    var identifier: String
    
    init(text: String, toID: String, identifier: String) {
        self.text = text
        self.toID = toID
        self.identifier = identifier
    }
    
    init?(jsonDictionary: [String: Any], identifier: String) {
        guard let text = jsonDictionary[textKey] as? String,
            let toID = jsonDictionary[toIDKey] as? String else { return nil }
        self.text = text
        self.toID = toID
        self.identifier = identifier
    }
}
