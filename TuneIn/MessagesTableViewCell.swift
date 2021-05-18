//
//  MessagesTableViewCell.swift
//
//
//  Created by Lindsay Penkrat on 4/25/21.
//

import UIKit
import Firebase

class MessagesTableViewCell: UITableViewCell {
    
    @IBOutlet weak var messageTypeLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var messageTitleLabel: UILabel!
    @IBOutlet weak var messageField: UILabel!
    @IBOutlet weak var personNameLabel: UILabel!
    @IBOutlet weak var postedDateLabel: UILabel!
    //TODO: add way to like and count the likes
    @IBOutlet weak var likeButton: UIButton!
    @IBOutlet weak var likeLabel: UILabel!
    var message: Message! {
        didSet {
            messageTitleLabel.text = message.title
            messageTypeLabel.text = message.messageType
            emailLabel.text = message.messageUserEmail
            postedDateLabel.text = "posted on: \(dateFormatter.string(from: message.date))"
            messageField.text = message.text
            personNameLabel.text = message.messageUserName
            //TODO:            namelabel = need to look it up
            print(message.messageUserName)
        }
    }
}
