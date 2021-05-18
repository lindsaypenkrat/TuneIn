//
//  PartyUserTableViewCell.swift
//  Snacktacular
//
//  Created by Lindsay Penkrat on 4/25/21.
//  TODO: Will be used for multiple user finding collaboraitons. 

import UIKit
import SDWebImage
    
class PartyUserTableViewCell: UITableViewCell {

    @IBOutlet weak var photoImage: UIImageView!
    @IBOutlet weak var displayNameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userSinceLabel: UILabel!
    
    var partyUser: PartyUser! {
        didSet {
            
            photoImage.layer.cornerRadius = photoImage.frame.size.width / 2
            photoImage.clipsToBounds = true
            
            displayNameLabel.text = partyUser.displayName
            emailLabel.text = partyUser.email
            let formattedDate = dateFormatter.string(from: partyUser.userSince)
            userSinceLabel.text = "\(formattedDate)"
            
            guard let url = URL(string: partyUser.photoURL) else {
                photoImage.image = UIImage(named: "singleUser")
                print("😡 ERROR: Could not convert photoURL named \(partyUser.photoURL) into a valid URL")
                return
            }
            photoImage.sd_setImage(with: url, placeholderImage: UIImage(named: "singleUser"))
        }
    }
}
