//
//  Message.swift
//  Snacktacular
//
//  Created by Lindsay Penkrat on 4/25/21.
//

import Foundation
import Firebase

class Message {
    var title: String
    var text: String
    var messageType: String
    var messageUserID: String
    var messageUserEmail: String
    var messageUserName: String
    var date: Date
    var documentID: String
    
    var dictionary: [String: Any] {
        let timeIntervalDate = date.timeIntervalSince1970
        return ["title": title, "text": text, "messageType": messageType, "messageUserID": messageUserID, "messageUserEmail": messageUserEmail, "messageUserName": messageUserName, "date": timeIntervalDate]
    }
    
    init(title: String, text: String, messageType: String, messageUserID: String, messageUserEmail: String, messageUserName: String, date: Date, documentID: String) {
        self.title = title
        self.text = text
        self.messageType = messageType
        self.messageUserID = messageUserID
        self.messageUserEmail = messageUserEmail
        self.messageUserName = messageUserName
        self.date = date
        self.documentID = documentID
    }
    
    convenience init() {
        let messageUserID = Auth.auth().currentUser?.uid ?? ""
        let messageUserEmail = Auth.auth().currentUser?.email ?? "unknown email"
        let messageUserName = Auth.auth().currentUser?.displayName ?? "unknown name"
        self.init(title: "", text: "", messageType: "message", messageUserID: messageUserID,  messageUserEmail: messageUserEmail, messageUserName: messageUserName, date: Date(), documentID: "")
    }
    
    //convenience init for the dictionary.
    convenience init(dictionary: [String: Any]) {
        let title = dictionary["title"] as! String? ?? ""
        let text = dictionary["text"] as! String? ?? ""
        let messageType = dictionary["messageType"] as! String? ?? ""
        let messageUserID = dictionary["messageUserID"] as! String? ?? ""
        let messageUserEmail = dictionary["messageUserEmail"] as! String? ?? ""
        let messageUserName = dictionary["messageUserName"] as! String? ?? ""
        let timeIntervalDate = dictionary["date"] as! TimeInterval? ?? TimeInterval()
        let date = Date(timeIntervalSince1970: timeIntervalDate)
        let documentID = dictionary["documentID"] as! String? ?? ""
        
        self.init(title: title, text: text, messageType: messageType, messageUserID: messageUserID, messageUserEmail: messageUserEmail, messageUserName: messageUserName, date: date, documentID: documentID)
    }
    
    func saveData(message: Message, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        
        
        // Create the dictionary representing the data we want to save
        let dataToSave = self.dictionary
        // if we HAVE saved a record, we'll have a documentID. so we will update.
        if self.documentID != "" {
            let ref = db.collection("messages").document(self.documentID)
            ref.setData(dataToSave) { (error) in
                if let error = error {
                    print("*** ERROR: updating document \(self.documentID) in partyUser \(gblpartyUser.documentID) \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ Document updated with ref ID \(ref.documentID)")
                    completed(true)
                }
            }
        } else
        {
            var ref: DocumentReference? = nil // Let firestore create the new documentID
            //TODO:FIX HOW COLLECTIONS ARE STRUCTURED in the MODEL
            ref = db.collection("messages").addDocument(data: dataToSave) { error in
                if let error = error {
                    print("*** ERROR: creating new document in User \(gblpartyUser.documentID) for new message documentID \(error.localizedDescription)")
                    completed(false)
                } else {
                    print("^^^ new document created with ref ID \(ref?.documentID ?? "unknown")")
                    completed(true)
                }
            }
        }
    }
    func deleteData(message: Message, completed: @escaping (Bool) -> ()) {
        let db = Firestore.firestore()
        db.collection("messages").document(documentID).delete() { error in
            if let error = error
            {
                print("😡 ERROR: deleting message documentID \(self.documentID) \(error.localizedDescription)")
                completed(false)
            }
            else
            {
                completed(true)}
            
        }
    }
}

