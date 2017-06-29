//
//  DatabaseManager.swift
//  5StarAutoDirect
//
//  Created by Alex Whitlock on 6/29/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Foundation
import Firebase
import KeychainSwift
import FirebaseDatabase

let DB_BASE = Database.database().reference()

class DatabaseManager {
    private var _keyChain = KeychainSwift()
    private var _refDatabase = DB_BASE
    
    var keyChain: KeychainSwift {
        get {
            return _keyChain
        } set {
            _keyChain = newValue
        }
    }
    
}
