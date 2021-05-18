//
//  ProfileViewController.swift
//  TuneIN
//
//  Created by Lindsay Penkrat on 5/6/21.
// 

import UIKit

class ProfileViewController: UITableViewController {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var userSinceDateLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var  count = 0
    override func viewDidLoad() {
        self.navigationController?.setNavigationBarHidden(true, animated: true)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //showAlert(title: "What!!!", message: "Fantastic I loaded")
        //count += 1
        updateUserInterface()
    }
    override func viewWillAppear(_ animated: Bool) {
        //showAlert(title: "What!!!", message: "Fantastic I appeared")
        //count += 1
        // Do any additional setup after loading the view.
        updateUserInterface()
    }
    //alert or the image picker
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    func updateUserInterface() {
        nameLabel.text = gblpartyUser.displayName
        emailLabel.text = gblpartyUser.email
        userSinceDateLabel.text = dateFormatter.string(from: gblpartyUser.userSince)
        guard let url = URL(string: gblpartyUser.photoURL) else {
            imageView.image = UIImage(named: "singleUser")
            print("😡 ERROR: Could not convert photoURL named \(gblpartyUser.photoURL) into a valid URL")
            return
        }
        imageView.sd_setImage(with: url, placeholderImage: UIImage(named: "singleUser"))
    }
}
