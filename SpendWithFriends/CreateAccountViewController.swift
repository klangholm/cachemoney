//
//  CreateAccountViewController.swift
//  SpendWithFriends
//
//  Created by Skiljan, Nicholas on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController, addUserDelegate {

    
    var data : NSMutableData = NSMutableData()
    
        
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var profilePicture: UIImageView!
    @IBAction func createAccountButtonPressed(_ sender: Any) {
        if (firstName.text?.isEmpty ?? true || lastName.text?.isEmpty ?? true || username.text?.isEmpty ?? true || password.text?.isEmpty ?? true) {
            let dialog = UIAlertController(title: "Error", message: "Blank text fields are forbidden", preferredStyle: UIAlertControllerStyle.alert)
            present(dialog,animated: false, completion: nil)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic?")}))
        }
        addUser()

    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.profilePicture.layer.cornerRadius = 0.5 * self.profilePicture.bounds.size.width
        self.profilePicture.clipsToBounds = true
        self.profilePicture.layer.borderWidth = 3.0
        self.profilePicture.layer.borderColor = UIColor.lightGray.cgColor

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func addUser() {
        let dh = DataHandler(id: "")
        dh.auDelegate = self
        UserDefaults.standard.set(Profile(name: firstName.text!+"%20"+lastName.text!, username: username.text!, password: password.text!), forKey: "profile")
        dh.addUser(name: firstName.text! + "%20" + lastName.text!, username: username.text!, password: password.text!)
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
    
    func addUserDeclined() {
        
        DispatchQueue.main.async() {
            let dialog = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.alert)
            
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic??")}))
            self.present(dialog,animated: false, completion: nil)
            
        }
    }
    func addUserAuthorized() {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "mainViewController")
        self.navigationController?.show(vc!, sender: nil)
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
