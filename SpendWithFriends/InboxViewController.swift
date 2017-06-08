//
//  InboxViewController.swift
//  SpendWithFriends
//
//  Created by Yiheyis, Leoul on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class InboxViewController: UITableViewController {

    @IBOutlet weak var menuView: UIView!
    var requests: [MeetUp]?
    override func viewDidLoad() {
        
        self.tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.tableView.rowHeight = 90
        // pull meet ups from db and populate view
        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableView.reloadData()
        super.viewDidLoad()
//        
//        menuView.layer.shadowOpacity = 1
    }
 
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Inbox"
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        //Change the selected background view of the cell.
//        tableView.selectRow(at: indexPath, animated: true)
//        
//    }
    
//    override func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        //Change the selected background view of the cell.
//        tableView.deselectRow(at: indexPath, animated: true)
//        
//    }

    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return requests!.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let request = requests![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.configureCell(meetup: request)
        cell.tapAction1 = { [weak self] (cell) in
            request.toggleRead()
            request.setAccepted(accept: true)
            //send it to original sender
            
        }
        cell.tapAction2 = { [weak self] (cell) in
            request.toggleRead()
            request.setAccepted(accept: false)
            //delete it
        }
        return cell
    }
    
}
