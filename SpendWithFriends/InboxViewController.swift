//
//  InboxViewController.swift
//  SpendWithFriends
//
//  Created by Yiheyis, Leoul on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class InboxViewController: UITableViewController, addMeetUpDelegate {

    @IBOutlet weak var menuView: UIView!
    var requests: [MeetUp]?
    var data: NSMutableData = NSMutableData()
    override func viewDidLoad() {
        
        self.tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.tableView.rowHeight = 90
        requests = [MeetUp(sender: Profile(name: "paul", username: "test username", password: "test password"), venue: Merchant(name: "bitch", merchantId: "12345", category: "sup", streetNumber: 5, streetName: "ayy", city: "yo", state: "boi", zip: 54432, latitude: 54.43, longitude: 66.66), date: Date(timeIntervalSince1970: TimeInterval()), time: "Hello", recipient: Profile(name: "paul", username: "test username", password: "test password"))]
        // pull meet ups from db and populate view
        
//        self.navigationController?.setNavigationBarHidden(true, animated: true)
        self.tableView.reloadData()
        super.viewDidLoad()
//      
//        menuView.layer.shadowOpacity = 1
    }
 
    func addMeetUp(sender: Profile, venue: Merchant, date: Date, time: String, recipient: Profile, message:String, phone:String, read:Int = 0, accepted:Int = 0){
        let dh = DataHandler(id: "")
        dh.amDelegate = self
        dh.addMeetUp(sender: sender, venue: venue, date: date, time: time, recipient: recipient, message: message, phone: phone, read: read, accepted: accepted)
    }
    
    func URLSession(session: URLSession, dataTask: URLSessionDataTask, didReceiveData data: NSData) {
        self.data.append(data as Data)
    }
    
    func URLSession(session: URLSession, task: URLSessionDataTask, didCompleteWithError error: NSError?) {
        if error != nil {
            print("Failed to download data")
        } else {
            print("Data downloaded")
            
        }
    }
    
    func addMeetUpDeclined() {
        DispatchQueue.main.async() {
            let dialog = UIAlertController(title: "Error", message: "Failed", preferredStyle: UIAlertControllerStyle.alert)
            
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic??")}))
            self.present(dialog,animated: false, completion: nil)
            
        }
    }
    
    func addMeetUpAuthorized() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController")
        self.navigationController?.show(vc!, sender: nil)
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
            self?.addMeetUp(sender: request.getRecipient, venue: request.getVenue, date: request.getDate, time: request.getTime, recipient: request.getSender, message: request.getMessage, phone: request.getPhone)
            
        }
        cell.tapAction2 = { [weak self] (cell) in
            request.toggleRead()
            request.setAccepted(accept: false)
        }
        return cell
    }
    
}
