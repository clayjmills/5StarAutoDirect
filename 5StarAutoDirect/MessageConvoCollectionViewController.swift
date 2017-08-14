import UIKit
import Firebase
import FirebaseDatabase

// I may need two different properties, one for the user(broker), and one for the person the user is interacting with, i.e. customer property

class MessageConvoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
   
    
    static let shared = MessageConvoViewController()
    
    var message: Message?
    var messages: [Message] = [] {
        didSet {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    var user: User? {
        didSet {
            observeMessages()

        }
    }
    
    var customer: User?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = user?.name
        self.messageTextView.layer.cornerRadius = 8
        self.messageTextView.layer.borderWidth = 1
        observeMessages()
        
        guard let user = user else { return }
        if user.isBroker {
            navigationItem.title = "Broker"
        } else {
            navigationItem.title = "Customer" // change this to customer nam
        }
    }
    
    @IBAction func sendButtonAnimationTapped(_ sender: UIButton) {
        if sender.currentImage == #imageLiteral(resourceName: "Send Message Tapped Image") {
            sender.setImage(#imageLiteral(resourceName: "Send Message Label"), for: .normal)
        } else {
            sender.setImage(#imageLiteral(resourceName: "Send Message Tapped Image"), for: .normal)
        }
    }
    @IBAction func sendButtonTapped(_ sender: Any) {
        handleSend()
        observeMessages()
        tableView.reloadData()
        
        guard let toID = user?.name else { return }
//        MessageController.shared.createMessage(text: messageTextView.text, toID: toID)
//        messageTextView.text = "button was clicked"
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    
    // Mark: - TableView Data Source Functions
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        let message = messages[indexPath.row]
        cell.message = message
        return cell
    }
    
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //Alex code for messages
                guard let message = Message(jsonDictionary: dictionary, identifier: snapshot.key as! String) else { return }
                
//                guard let message = Message(jsonDictionary: dictionary, identifier) else { return }
                message.setValuesForKeys(dictionary)
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    func handleSend() {
        if messageTextView.text != "" {
            let ref = Database.database().reference().child("messages")
            
            let childRef = ref.childByAutoId()
            guard let input = messageTextView.text else {return}
            let name = user?.name
            let values = ["text":input, "name": name]
            childRef.updateChildValues(values)
            messageTextView.text = ""
        }
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageTextView.resignFirstResponder()
    }

    // keyboard under text View
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    func textViewDidBeginEditing(_ textView: UITextView) {
        
        scrollView.setContentOffset(CGPoint(x:0, y:190), animated: true)
    }
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
}
