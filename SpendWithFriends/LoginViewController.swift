//
//  LoginViewController.swift
//  
//
//  Created by Skiljan, Nicholas on 6/7/17.
//
//

import UIKit

class LoginViewController: UIViewController, loginDelegate {

    
    var data : NSMutableData = NSMutableData()
    
    @IBOutlet weak var username: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        
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
        /*
        let loginURL: String = "http://lukeporupski.com/newPhp/checkPass.php?Name=" + username.text! + "&Password=" + password.text!
        let url: URL = URL(string: loginURL)!
        let urlRequest = URLRequest(url: url as URL)
        let configuration = URLSessionConfiguration.default

        
        let session = Foundation.URLSession(configuration: configuration)
        
        
        //creating a task to send the post request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            print("Im here")
            if error != nil{
                print("error is \(error)")
                return;
            }
            let sizee = data!.count
            if (sizee == 1) {
                print("good shit")
            } else {
                let dialog = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.alert)
                self.present(dialog,animated: false, completion: nil)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic??")}))
            }
        })
        task.resume()*/
        
        let dh = DataHandler(id: "")
        dh.lDelegate = self
        dh.authorizeLogin(username: username.text!, password: password.text!)
        
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
    
    func loginWasDeclined() {
        
        DispatchQueue.main.async() {
        let dialog = UIAlertController(title: "Error", message: "Incorrect username or password", preferredStyle: UIAlertControllerStyle.alert)
        
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: { (action:UIAlertAction!) in print("logic??")}))
        self.present(dialog,animated: false, completion: nil)
            
        }
    }
    func loginWasAuthorized() {
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
