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
        let prof = Profile(name: "Leoul", id: "30")
        let prof2 = Profile(name: "reciever", id: "50")
        let meet = MeetUp(sender: prof, venue: "Hilton", date: Date(), address: "whatever", time: "3:40", recipient: prof2)
        requests?.append(meet)
        requests = [MeetUp(sender: prof, venue: "Hilton", date: Date(), address: "whatever", time: "3:40", recipient: prof2)]
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
