//
//  CreateAccountViewController.swift
//  SpendWithFriends
//
//  Created by Skiljan, Nicholas on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class CreateAccountViewController: UIViewController {

    
    @IBOutlet weak var profilePicture: UIImageView!
    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var lastName: UITextField!
    
    @IBAction func continueButtonPressed(_ sender: Any) {
        if (firstName.text?.isEmpty ?? true || lastName.text?.isEmpty ?? true) {
            let dialog = UIAlertController(title: "Error", message: "Blank text fields are forbidden", preferredStyle: UIAlertControllerStyle.alert)
            present(dialog,animated: false, completion: nil)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic?")}))
        }

    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
