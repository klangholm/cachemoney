//
//  LoginViewController.swift
//  
//
//  Created by Skiljan, Nicholas on 6/7/17.
//
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    
    @IBAction func loginButton(_ sender: Any) {
        
        if (username.text?.isEmpty ?? true || password.text?.isEmpty ?? true) {
            let dialog = UIAlertController(title: "Error", message: "Blank text fields are forbidden", preferredStyle: UIAlertControllerStyle.alert)
            present(dialog,animated: false, completion: nil)
            dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic?")}))
        }
        authorizeUser()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func authorizeUser() {
        
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
