
import Firebase
import FirebaseDatabase
import UIKit
import Whisper

class MessageController {
    
    static var shared = MessageController()
    
    var messages = [Message]() {
        didSet {
            
        }
    }
    
    let ref = Database.database().reference(fromURL: "https://starautodirect-5b1fc.firebaseio.com/")
    let messagesRef = Database.database().reference().child("messages")
    
    func fetchMessages(completion: @escaping ([Message]?) -> Void) {
        ref.child("messages").observe(.value, with: { (snapshot) in
            
            if let dictionaryOfMessages = snapshot.value as? [String: [String: Any]] {
                print(dictionaryOfMessages)
                let messages = dictionaryOfMessages.flatMap({Message(jsonDictionary: $0.value) } )
//                print(messages)
                completion(messages)
            }
        })
    }
    
    func detectOtherMessagesNotFromCurrentUser(user: User?, message: Message){
        messagesRef.observe(.value, with: { (snapshot) in
            if let dictionaryOfMessages = snapshot.value as? [String: JSONObject] {
                let messages = dictionaryOfMessages.flatMap( {Message(jsonDictionary: $0.value) } )
                guard let userMessages = user?.messages else { return }
                if userMessages != messages {}
            }
        })
        
    }
    
    func observeChildMessagesAdded(atRef ref: DatabaseReference, viewController: UIViewController, completion: ((Result<JSONObject>) -> Void)?) {
        ref.child("messages").observe(.childAdded, with: { (snapshot) in
            //TODO: - Determine if value has changed
            if let snap = snapshot.value as? JSONObject {
                completion?(Result.success(snap))
            } else {
                completion?(Result.failure(JSONError.typeMismatch(snapshot.key) ))
            }
        })
    }
}
