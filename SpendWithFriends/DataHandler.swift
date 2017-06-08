//
//  DataHandler.swift
//  SpendWithFriends
//
//  Created by Porupski, Luke on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import Foundation

protocol loginDelegate {
    func loginWasAuthorized()
    
    func loginWasDeclined()
}

class DataHandler {
    
    var user_id: String
    
    var lDelegate: loginDelegate?
    
    init(id: String) {
        self.user_id = id
    }
    
    func getReqests() -> [MeetUp] {
        let temp = [MeetUp]()
        
        return temp
    }
    
    func getPurchases() -> [Purchase]{
        let temp = [Purchase]()
        
        return temp
    }
    
    func getProfilesForLocation() -> [Profile] {
        let temp = [Profile]()
        
        return temp
    }
    
    func authorizeLogin(username: String, password: String) {
        let loginURL: String = "http://lukeporupski.com/newPhp/checkPass.php?Name=" + username + "&Password=" + password
        let url: URL = URL(string: loginURL)!
        let urlRequest = URLRequest(url: url as URL)
        let configuration = URLSessionConfiguration.default
        
        
        let session = Foundation.URLSession(configuration: configuration)
        
        
        //creating a task to send the post request
        let task = session.dataTask(with: urlRequest, completionHandler: { (data: Data?, response: URLResponse?, error: Error?) -> Void in
            //print("Im here")
            if error != nil{
                //print("error is \(error)")
                return;
            }
            let sizee = data!.count
            if (sizee == 1) {
                self.lDelegate?.loginWasAuthorized()
                //print("good shit")
            } else {
                self.lDelegate?.loginWasDeclined()
            }
        })
        task.resume()
    }
    
    
    
}
