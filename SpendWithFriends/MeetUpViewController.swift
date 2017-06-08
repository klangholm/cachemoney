//
//  MeetUpViewController.swift
//  SpendWithFriends
//
//  Created by Kristian Langholm on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class MeetUpViewController: UIViewController {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var message: UITextField!
    
    @IBOutlet weak var phone: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func getTimeFromDatePicker(datePicker:UIDatePicker) -> String{
        let date = datePicker.date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return String(hour)+":"+String(minutes)
    }
    
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        //unfinished - test data
        if let sender = UserDefaults.standard.object(forKey: "profile") as? Profile{
            let date = datePicker.date
            let time = getTimeFromDatePicker(datePicker: datePicker)
            let testProfile = Profile(name: "Test", id: "TestID")
            let meetup = MeetUp(sender: sender, venue: "Test Venue", date: date, address: "Test Address", time: time, recipient: testProfile)
            if message.text != nil {
                meetup.addMessage(message: message.text!)
            }
            if phone.text != nil {
                meetup.addPhone(phone: phone.text!)
            }
            print(meetup.getMessage)
            print(meetup.getPhone)
            //send to the database
        }
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
