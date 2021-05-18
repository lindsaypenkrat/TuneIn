//
//  PartyUserViewController.swift
//  TuneIN
//
//  Created by Lindsay Penkrat on 5/5/21.
//// TODO: Will be used for multiple user finding collaboraitons. 

import UIKit

class PartyUserViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    var partyUsers: PartyUsers!
    
    override func viewDidLoad() {
        super.viewDidLoad()
   
        tableView.delegate = self
        tableView.dataSource = self
        
        partyUsers = PartyUsers()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        partyUsers.loadData {
            self.tableView.reloadData()
        }
    }
}

 
extension PartyUserViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return partyUsers.partyUserArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! PartyUserTableViewCell
        cell.partyUser = partyUsers.partyUserArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
