//
//  MeetUpViewController.swift
//  SpendWithFriends
//
//  Created by Kristian Langholm on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class MeetUpViewController: UIViewController, addMeetUpDelegate {

    @IBOutlet weak var datePicker: UIDatePicker!
    
    @IBOutlet weak var message: UITextView!
    
    @IBOutlet weak var phone: UITextField!
    
    var data: NSMutableData = NSMutableData()
    
    var selectedMerchant: Merchant!
    
    var selectedRecipient: Profile!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
    
    func getTimeFromDatePicker(datePicker:UIDatePicker) -> String{
        let date = datePicker.date
        let calendar = Calendar.current
        let hour = calendar.component(.hour, from: date)
        let minutes = calendar.component(.minute, from: date)
        return String(hour)+":"+String(minutes)
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
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        //unfinished - test data
        if let sender = UserDefaults.standard.object(forKey: "profile") as? Profile{
            let date = datePicker.date
            let time = getTimeFromDatePicker(datePicker: datePicker)
            let recipient = selectedRecipient
            let meetup = MeetUp(sender: sender, venue: selectedMerchant, date: date, time: time, recipient: recipient!)
            var messagetext = ""
            if message.text != nil {
                meetup.addMessage(message: message.text!)
                messagetext = message.text!
            }
            var phonenumber = ""
            if phone.text != nil {
                meetup.addPhone(phone: phone.text!)
                phonenumber = phone.text!
            }
            addMeetUp(sender: sender, venue: selectedMerchant, date: date, time: time, recipient: recipient!, message: messagetext, phone: phonenumber)
            //print(meetup.getMessage)
            //print(meetup.getPhone)
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
