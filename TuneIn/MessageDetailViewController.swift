//
//  MessageDetailViewController.swift
//  TuneIN
//
//  Created by Lindsay Penkrat on 5/7/21.
//

import UIKit
import Firebase

class MessageDetailViewController: UITableViewController {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageTitle: UITextField!
    @IBOutlet weak var messageView: UITextView!
    @IBOutlet weak var segmentMessageType: UISegmentedControl!
    @IBOutlet weak var saveBarButton: UIBarButtonItem!
    @IBOutlet weak var deleteButton: UIBarButtonItem!
    @IBOutlet weak var messageDateLabel: UILabel!
    @IBOutlet weak var messageTypeSegment: UISegmentedControl!
    @IBOutlet weak var cancelBarButton: UIBarButtonItem!
    
    //may use or access the global variable
    var message: Message!

    override func viewDidLoad() {
        super.viewDidLoad()
        // hide keyboard if we tap outside of a field
        let tap = UITapGestureRecognizer(target: self.view, action: #selector(UIView.endEditing(_:)))
        tap.cancelsTouchesInView = false
        self.view.addGestureRecognizer(tap)
        
        guard  gblpartyUser != nil else {
            print("*** ERROR: did not have a valid partyUser in MessageDetailViewController")
            return
        }
        //if message is nil this is a new record.
        if message == nil {
            message = Message()
        }
        
        updateUserInterface()
    }
    
    override func viewWillDisappear(_ animated : Bool) {
        super.viewWillDisappear(animated)

        if (self.isMovingFromParent){
            // Your code...
            print ("hi iam disapearing")
        }
    }
    //alert or the image picker
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    func updateUserInterface() {
        nameLabel.text = message.messageUserName
        emailLabel.text = message.messageUserEmail
        messageTitle.text = message.title
        messageView.text = message.text
        messageDateLabel.text = "posted: \(dateFormatter.string(from: message.date))"
        
        //set segment controller based upon the value coming in. default is message
        switch  message.messageType
        {
        case "party":
            messageTypeSegment.selectedSegmentIndex = 0
        case "message":
                messageTypeSegment.selectedSegmentIndex = 1
        case "jam":
                messageTypeSegment.selectedSegmentIndex = 2
        default:
         return //should never get executed
        }
        //let segment know that you changed its value.
        messageTypeSegment.sendActions(for: UIControl.Event.valueChanged)
       
        //now run logic to check how to set up the UI for editing or viewing.
        // Logic Rule: This is a new message
        //TODO: Remove Cancel button and just use Back
        cancelBarButton.isEnabled = false
        cancelBarButton.title = ""
        
        if message.documentID == "" {
            addBordersToEditableObjects()
            //hide delete button
            deleteButton.isEnabled = false
            deleteButton.title = ""
            deleteButton.image = nil
            cancelBarButton.isEnabled = true
            cancelBarButton.title = "Cancel"
        }
        //This is an existing message and we need to run logic rules to hide and enable fields
        else
        {
            if message.messageUserID == gblpartyUser.documentID //Auth.auth().currentUser?.uid
            { // Message posted by current user
                //self.navigationItem.leftItemsSupplementBackButton = false
                saveBarButton.title = "Update"
                addBordersToEditableObjects()
                cancelBarButton.isEnabled = false
                cancelBarButton.title = ""
                
            }
            else
            {
                //TODO: not my message so can not run logic
                saveBarButton.isEnabled = false
                saveBarButton.title = ""
                deleteButton.isEnabled = false
                deleteButton.image = nil
                //get rid of the cancel button
                cancelBarButton.isEnabled = false
                cancelBarButton.title = ""
                
                emailLabel.text = "Posted by: \(message.messageUserEmail)"
                messageTitle.isEnabled = false
                messageTitle.borderStyle = .none
                messageView.isEditable = false
                messageTitle.backgroundColor = .white
                messageView.backgroundColor = .white
                messageTypeSegment.isEnabled = false
                
            }
        }
    }
    
    //function to update message with values
    func updateFromUserInterface() {
        message.title = messageTitle.text!
        message.text = messageView.text!
            
        switch  messageTypeSegment.selectedSegmentIndex
        {
        case 0:
            message.messageType = "party"
                return
        case 1 :
            message.messageType = "message"
                return
        case 2 :
            message.messageType = "jam"
        default:
            return
        }
    }
    
    func addBordersToEditableObjects() {
        messageTitle.addBorder(width: 0.5, radius: 5.0, color: .blue)
        messageView.addBorder(width: 0.5, radius: 5.0, color: .blue)
    }
    //TODO:WOrk on the return to the tab bar pop is causing some isse  on returening an tab goes back to home vs staying on the message tab.
    func leaveViewController() {
        let isPresentingInAddMode = presentingViewController is UINavigationController
        if isPresentingInAddMode {
            dismiss(animated: true, completion: nil)
            performSegue(withIdentifier: "UnwindMessage", sender: nil)
        } else {
            navigationController?.popViewController(animated: true)
//            self.navigationItem.leftItemsSupplementBackButton.
            
        }
    }
    
    @IBAction func saveButtonPressed(_ sender: UIBarButtonItem) {

        if messageTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines) == ""
        {
           showAlert(title: "Data Entry Error", message: "There must be a title entered")
            return
        }
        if messageView.text!.trimmingCharacters(in: .whitespacesAndNewlines) == "" {
            showAlert(title: "Data Entry Error", message: "There must be a message entered")
             return
        }
        updateFromUserInterface()
        message.saveData(message: message) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("*** ERROR: Could not leave this view controller bc data was not saved.")
            }
        }
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIBarButtonItem) {
        leaveViewController()
    }
    
    @IBAction func deleteButtonPressed(_ sender: UIButton) {
        message.deleteData(message: message) { (success) in
            if success {
                self.leaveViewController()
            } else {
                print("😡 Delete unsuccessful")
            }
        }
    }
    
    //trim the fields to enable changes
    @IBAction func messageTitleChanged(_ sender: UITextField) {
        // prevent a title of blank spaces from being saved, too
        let noSpaces = messageTitle.text!.trimmingCharacters(in: .whitespacesAndNewlines)
        if noSpaces != "" {
            saveBarButton.isEnabled = true
        } else {
            saveBarButton.isEnabled = false
        }
    }
    
    
}
