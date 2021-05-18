//
//  Messages.swift
//  Snacktacular
// 
//  Created by Lindsay Penkrat on 4/25/21.


import Foundation
import Firebase

class Messages {
    var messageArray: [Message] = []
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("messages").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.messageArray = []
            // there are querySnapshot!.documents.count documents in the messages snapshot
            for document in querySnapshot!.documents {
                let message = Message(dictionary: document.data())
                message.documentID = document.documentID
                self.messageArray.append(message)
            }
            completed()
        }
    }
}
