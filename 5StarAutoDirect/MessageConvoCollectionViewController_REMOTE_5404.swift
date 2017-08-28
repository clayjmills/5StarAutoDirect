import Firebase
import FirebaseDatabase
import UIKit

// I may need two different properties, one for the user(broker), and one for the person the user is interacting with, i.e. customer property

class MessageConvoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate, UITextViewDelegate {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var sendButton: UIButton!
    
    let firebaseController = FirebaseController()
    let messageController = MessageController()
    

    var message: Message?
    var customer: User?
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.reloadData()
        tableView.dataSource = self
        tableView.delegate = self
        navigationItem.title = user?.name
        self.messageTextView.layer.cornerRadius = 8
        self.messageTextView.layer.borderWidth = 1
        observeMessages()
        
        //FIXME: - unwrap optional value here to prevent crash
        //TODO: - add in car sound everytime msg received
        //TODO: - suscribe to changes at value and ref of "messages"
        //This runs everytime view is called obviously
     
       

        guard let user = user else { return }
        if user.isBroker {
            navigationItem.title = self.user?.name
        } else {
            navigationItem.title = "Broker"
        }
        
        DispatchQueue.main.async {
            MessageController.shared.fetchMessages(completion: { (messages) in
                guard let messages = messages else { return }
                self.messages = messages
            })
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
        
//        guard let toID = user?.name else { return }
//        MessageController.shared.createMessage(text: messageTextView.text, toID: toID)
//        messageTextView.text = "button was clicked"
    }
    // Mark: - TableView Data Source Functions
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "receivedMessageCell", for: indexPath) as? MessageTableViewCell else { return UITableViewCell() }
        cell.message = messages[indexPath.row]
        return cell
    }
    
    
    func observeMessages() {
        let ref = Database.database().reference().child("messages")
        ref.observe(.childAdded, with: { (snapshot) in
            
            if let dictionary = snapshot.value as? [String: AnyObject] {
                //Alex code for messages
                guard let message = Message(jsonDictionary: dictionary) else { return }
                
 //               message.setValuesForKeys(dictionary)
                self.messages.append(message)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
        }, withCancel: nil)
    }
    
    func handleSend() {
        // FIXME: !!!! PLEASE THIS IS AWFUL
        if messageTextView.text != "" {
            let ref = Database.database().reference().child("messages")
            
            let childRef = ref.childByAutoId()
            guard let input = messageTextView.text, let name = user?.name else { return }
            let values: [String: Any] = ["text":input, "name": name]
            childRef.updateChildValues(values)
            messageTextView.text = ""
            tableView.reloadData()
            // or call observe func again
        }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        messageTextView.resignFirstResponder()
    }

    // keyboard under text View
    func textViewDidBeginEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x:0, y:190), animated: true)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        scrollView.setContentOffset(CGPoint(x:0, y:0), animated: true)
    }
    
}