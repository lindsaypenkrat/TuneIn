//
//  PartyUsers.swift
//  TuneIN
//
//  Created by Lindsay Penkrat on 5/4/21.
//
import Foundation
import Firebase

class PartyUsers {
    var partyUserArray = [PartyUser]()
    var db: Firestore!
    
    init() {
        db = Firestore.firestore()
    }
    
    func loadData(completed: @escaping () -> ())  {
        db.collection("users").addSnapshotListener { (querySnapshot, error) in
            guard error == nil else {
                print("*** ERROR: adding the snapshot listener \(error!.localizedDescription)")
                return completed()
            }
            self.partyUserArray = []
            // there are querySnapshot!.documents.count documents in teh spots snapshot
            for document in querySnapshot!.documents {
                let User = PartyUser(dictionary: document.data())
                User.documentID = document.documentID
                self.partyUserArray.append(User)
            }
            completed()
        }
    }
}
