//
//  MeetUpTableViewController.swift
//  SpendWithFriends
//
//  Created by Kristian Langholm on 6/8/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class MeetUpTableViewController: UITableViewController {

    var meetups = [MeetUp]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "MessageCell", bundle: nil), forCellReuseIdentifier: "MessageCell")
        self.tableView.rowHeight = 95.0
        meetups = [MeetUp(sender: Profile(name: "Ronald MacDonald", username: "test username", password: "test password"), venue: "The Gym", date: Date(timeIntervalSince1970: TimeInterval()), time: "1:45:22", recipient: Profile(name: "Paul Jones", username: "test username", password: "test password"))]
        meetups.append(MeetUp(sender: Profile(name: "Dennis Reynolds", username: "test username", password: "test password"), venue: "Paddy's Pub", date: Date(timeIntervalSince1970: TimeInterval()), time: "12:20:13", recipient: Profile(name: "Paul Jones", username: "test username", password: "test password")))
        meetups.append(MeetUp(sender: Profile(name: "Dee Reynolds", username: "test username", password: "test password"), venue: "Acting Class", date: Date(timeIntervalSince1970: TimeInterval()), time: "11:23:54", recipient: Profile(name: "Paul Jones", username: "test username", password: "test password")))
        meetups.append(MeetUp(sender: Profile(name: "Charlie Kelly", username: "test username", password: "test password"), venue: "The Alley", date: Date(timeIntervalSince1970: TimeInterval()), time: "5:44:32", recipient: Profile(name: "Paul Jones", username: "test username", password: "test password"))
        )
        //populate meetup list with meetups from the database that have been accepted
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        self.tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Meet Ups"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return meetups.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let meetup = meetups[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageCell", for: indexPath) as! MessageCell
        cell.configureCell(meetup: meetup)
        
        return cell
    }
 

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
