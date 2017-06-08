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
        let prof = Profile(name: "Bob", custId: "30", username: "whocares", password: "123")
        let prof2 = Profile(name: "Joe", custId: "50", username: "whatevs", password: "456")
        let meet = MeetUp(sender: prof, venue: "Hilton", date: Date(), address: "whatever", time: "3:40", recipient: prof2)
        
        let meet2 = MeetUp(sender: prof2, venue: "Marriott", date: Date(), address: "wherever", time: "5:45", recipient: prof)
        //requests?.append(meet)
        requests = [MeetUp(sender: prof, venue: "Hilton", date: Date(), address: "whatever", time: "3:40", recipient: prof2), MeetUp(sender: prof2, venue: "Marriott", date: Date(), address: "wherever", time: "3:40", recipient: prof)]
        // pull meet ups from db and populate view
        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
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
        return cell
    }
    
}
