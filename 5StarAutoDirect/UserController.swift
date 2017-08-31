//
//  UserController.swift
//  5StarAutoDirect
//
//  Created by Clay Mills on 6/14/17.
//  Copyright © 2017 PineAPPle LLC. All rights reserved.
//

import Firebase
import Foundation

class UserController {
    
    static let shared = UserController()
    
    let firebaseController = FirebaseController()
    var currentUser: User?
    var rootRef = Database.database().reference()
    var users = [User]() {
        didSet {
        }
    }
    
    weak var delegate: UserControllerDelegate?
    
    // TODO: - verify function is working correctly. check about optional completion block
    func saveCarToUser(car: Car, completion: ((User?) -> Void)?) {
        guard let currentUser = currentUser else { return }
        currentUser.car = car
        updateUser(user: currentUser)
        print(currentUser.identifier)
        firebaseController.save(at: rootRef.child("users").child(currentUser.identifier).child("car"), json: currentUser.jsonObject()) { error in
            completion?(currentUser)
        
            if let error = error {
                print(error.localizedDescription, "\(#line)")
            } else {
                self.currentUser = currentUser
                completion?(currentUser)
                print(currentUser.car)
            }
        }
    }
    
    func updateUser(user: User) {
        let ref = firebaseController.usersRef.child(user.identifier)
        firebaseController.save(at: ref, json: user.jsonObject()) { (error) in
            if let error = error {
                print(error.localizedDescription, "\(#line) in \(#file)")
            } else {
                print("success updating User \(#line)")
            }
        }
    }
    
    enum UserControllerError: Error {
        case uidNil // FIXME:
    }
    
    //Model objects into jsonExportable
    func saveUserToFirebase(name: String, phone: String, email: String, password: String, completion: @escaping(_ isBroker: Bool?, Error?) -> Void) {
        
        let isBroker = email.uppercased().contains("FIVESTARAUTODIRECT")
        let refString = isBroker ? "brokers" : "users"
        
        Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in
            
            if let error = error {
                print(error)
                completion(nil, error)
                return
            }
            
            guard let uidString = user?.uid
                else { completion(nil, UserControllerError.uidNil); return }
            
            let user = User(name: name, phone: phone, email: email, isBroker: isBroker, identifier: uidString)
            
            // Put authenticated user in firebase database under appropriate node.
            
            let referenceForCurrentUser = self.rootRef.child(refString).child(uidString)
            //            referenceForCurrentUser.setValue(user.jsonRepresentation)
            referenceForCurrentUser.setValue(user.jsonObject(), withCompletionBlock: { (error, ref) in
                UserController.completeSignIn(id: user.name)
                completion(isBroker, nil)
            })
            
            
            
            //// DO NOT DELETE might need this for the login screen, only Clay can delete this
            //            if !(email.contains(".")) {
            //                self.badEmail()
            //            } else if !(user.email?.contains("@"))! {
            //                self.badEmail()
            //            }
            //            if (user.phone?.characters.count)! < 10 {
            //                self.badPhoneNumberAC()
            //            }
            //            if password == "" {
            //                self.badPasswordAC()
            //            }
            //            if name == "" {
            //                self.badNameAC()
            //            }
            
        })
    }
    
    // getting users from firebase
    func fetchUsers(completion: @escaping ([User]?) -> Void) {
        rootRef.child("users").observe(.value, with: { (snapshot) in
            
            if let dictionaryOfUsers = snapshot.value as? [String:[String:Any]] {
                let users = dictionaryOfUsers.flatMap( { User(jsonDictionary: $0.value, identifier: $0.key) } )
                completion(users)
            }
        })
    }
    
    static func completeSignIn(id: String) {
        let keyChain = DatabaseManager().keyChain
        keyChain.set(id , forKey: "uid")
    }
}

protocol UserControllerDelegate: class {
    func usersWereUpdatedTo(users: [User])
}
