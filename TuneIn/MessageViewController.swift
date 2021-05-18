//
//  MessageViewController.swift
//  Created by Lindsay Penkrat on 4/25/21.
// 

import UIKit
import Firebase
import DropDown

class MessageViewController: UIViewController {
    @IBOutlet weak var newMessage: UITabBarItem!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    @IBOutlet weak var nameFilterField: UITextField!
    @IBOutlet weak var messageTypeField: UITextField!
    
    var messages: Messages!
    var like = 0
    let dropDown = DropDown()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if messages == nil {
            messages = Messages()
        }
        //prep for data in table
        initTableView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //        showAlert(title: "What!!!", message: "Fantastic messages appeared")
        if messages == nil {
            messages = Messages()
        }
        //Initialize table. since view will appear each time in a tab.
        initTableView()
        // Do any additional setup after loading the view. pass in the global party user object that we set. this will be used over and over
        messages.loadData () {
        self.tableView.reloadData()
        }
    }
    
//funciton to sort table.
    @IBAction func sortButtonPressed(_ sender: UIButton) {
        dropDown.dataSource = ["Name", "Date", "Type"]
        dropDown.anchorView = sender //5
//        dropDown.bottomOffset = CGPoint(x: 0, y: sender.frame.size.height)
        dropDown.bottomOffset = CGPoint(x: 0, y: 8)
        dropDown.show()
        dropDown.selectionAction = { [weak self] (index: Int, item: String) in
            guard let _ = self else { return }
//            sender.setTitle(item, for: .normal)
            switch item {
            case "Name":
                self?.messages.messageArray.sort(by: {$0.messageUserName < $1.messageUserName})
//                shows.showArray.sort(by: {$0.show.name < $1.show.name})
              
            case "Date":
                self?.messages.messageArray.sort(by: {$0.date > $1.date})
           
            case "Type":
                self?.messages.messageArray.sort(by: {$0.messageType < $1.messageType})
                
            default:
                return
            }
            self!.tableView.reloadData()
        }
    }
    //TOD:add code to filter table
    @IBAction func filterName(_ sender: Any) {
        let size = nameFilterField.text?.count
        
    // messageTitleLabel
    //personNameLabel
    
    // self?.messages.messageArray
        
    //let temp = nameFilterField.text
    // if temp.
    
        
    }
    
    @IBAction func filterType(_ sender: Any) {
    
    }
    
    
    
    func initTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        tableView.estimatedRowHeight = UITableView.automaticDimension
    }
   
    //alert
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alertController.addAction(alertAction)
        present(alertController, animated: true, completion: nil)
    }
    
    //creating detailview controller to show the details about the message.
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowMessage" {
            let destination = segue.destination as! MessageDetailViewController
            let selectedIndexPath = tableView.indexPathForSelectedRow!
            //pass data in about this message to retrieve the details
            destination.message = messages.messageArray[selectedIndexPath.row]
        } else {
            if let selectedIndexPath = tableView.indexPathForSelectedRow {
                tableView.deselectRow(at: selectedIndexPath, animated: true)
            }
        }
    }
}

extension MessageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.messageArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MessagesTableViewCell
        cell.message = messages.messageArray[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       // return a large row height for the message view
        return 180
    }
}
