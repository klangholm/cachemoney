//
//  ProfileTableViewController.swift
//  SpendWithFriends
//
//  Created by Kristian Langholm on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController {
    
    var profiles: [Profile]?
    
    var selectedMerchant: Merchant!
    
    override func viewDidLoad(){
        super.viewDidLoad()
        self.tableView.register(UINib(nibName: "ProfileCell", bundle: nil), forCellReuseIdentifier: "ProfileCell")
        self.tableView.rowHeight = 95.0
        profiles = [Profile(name: "paul", custId: "test", username: "test username", password: "test password")]
        profiles?.append(Profile(name: "paul", custId: "test", username: "test username", password: "test password"))
        self.tableView.reloadData()
        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationItem.title = "Most Frequent Users at "//+selectedMerchant.name
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return profiles!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let profile = profiles![indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileCell", for: indexPath) as! ProfileCell
        cell.configureCell(profile: profile)
        cell.tapAction = { [weak self] (cell) in
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MeetUpViewController")
            self?.present(controller, animated: true, completion: nil)
        }
        //cell.meetUpButton.isUserInteractionEnabled = true
        //cell.meetUpButton.tag = indexPath.row
        //cell.meetUpButton.addTarget(self, action: #selector(ProfileTableViewController.meetUpButtonTapped(_:)), for: .touchUpInside)

        return cell
    }
 
    //func meetUpButtonTapped(_ button: UIButton){
    //    let meetupVC = MeetUpViewController(nibName: "SigninVC", bundle: nil)
     //   self.present(meetupVC, animated: true, completion: nil)
    //}

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
