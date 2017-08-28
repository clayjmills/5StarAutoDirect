
import Firebase
import FirebaseDatabase
import UIKit

class MessageController {
    
    static var shared = MessageController()
    
    var messages = [Message]() {
        didSet {
            
        }
    }
    
    let ref = Database.database().reference(fromURL: "https://starautodirect-5b1fc.firebaseio.com/")
    
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        ref.child("messages").observe(.value, with: { (snapshot) in
            
            if let dictionaryOfMessages = snapshot.value as? [String:[String:Any]] {
 //               print(dictionaryOfMessages)
                let messages = dictionaryOfMessages.flatMap({Message(jsonDictionary: $0.value) } )
//                print(messages)
                completion(messages)
            }
        })
    }
    
    func observeChildMessagesAdded(atRef ref: DatabaseReference, viewController: UIViewController, completion: ((Result<JSONObject>) -> Void)?) {
        ref.child("messages").observe(.childChanged, with: { (snapshot) in
            //TODO: - Determine if value has changed
            if let snap = snapshot.value as? JSONObject {
                completion?(Result.success(snap))
            } else {
                completion?(Result.failure(JSONError.typeMismatch(snapshot.key) ))
            }
        })
    }
}
