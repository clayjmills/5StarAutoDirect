//
//  FirebaseController.swift
//  TheFinalProject
//
//  Created by Michael Castillo on 3/5/17.
//  Copyright © 2017 Michael Castillo. All rights reserved.
//

import UIKit
import Firebase

typealias JSONObject = [String: Any]

enum Result<T> {
    case success(T)
    case failure(Error)
}

protocol JSONInitializable {
    init?(json: JSONObject)
}

enum JSONError: Error {
    case keyMismatch(String)
    case typeMismatch(String)
}

struct FirebaseController {
    
    let rootRef = Database.database().reference()
    let storageRef = Storage.storage().reference()
    var usersRef: DatabaseReference {
        return rootRef.child("users")
    }
    func save(at ref: DatabaseReference, json: JSONObject, completion: ((Error?) -> Void)?) {
        ref.updateChildValues(json) { error, ref in
            completion?(error)
        }
    }
    
    func delete(at ref: DatabaseReference, completion: ((Error?) -> Void)?) {
        ref.removeValue { error, ref in
            completion?(error)
        }
    }
    
    func getData(at ref: DatabaseReference, completion: ((Result<JSONObject>) -> Void)?) {
        ref.observeSingleEvent(of: .value, with: { snapshot in
            if let snap = snapshot.value as? JSONObject, snapshot.exists() {
                completion?(Result.success(snap))
            } else {
                completion?(Result.failure(JSONError.typeMismatch(ref.key) ))
            }
        })
    }
    
    func getData(with query: DatabaseQuery, completion: ((Result<JSONObject>) -> Void)?) {
        query.observeSingleEvent(of: .value, with: { snapshot in
            if let snap = snapshot.value as? JSONObject, snapshot.exists() {
                completion?(Result.success(snap))
            } else {
                completion?(Result.failure(JSONError.typeMismatch(snapshot.key) ))
            }
        })
    }
    
    func subscribe(toRef ref: DatabaseReference, completion: ((Result<JSONObject>) -> Void)?) {
        ref.observe(.value, with: { snapshot in
            if let snap = snapshot.value as? JSONObject {
                completion?(Result.success(snap))
            } else {
                completion?(Result.failure(JSONError.typeMismatch(snapshot.key) ))
            }
        })
    }
    
}
