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
    init() {
        if let id = UserDefaults.standard.string(forKey: "user"){
            self.user_id = id
        }
        else {
            UserDefaults.standard.set("7", forKey: "user")
            self.user_id = "7"
        }
    }
    func getReqests() -> [MeetUp] {
        let temp = [MeetUp]()
        
        return temp
    }
    
    func getPurchases(){
        let temp = [Purchase]()
        
        let url_string = "http://lukeporupski.com/newPhp/getPurchasesOfUser.php?id=\(user_id)"
        let url = URL(string: url_string)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let posts = json["posts"] as? [[String: Any]] ?? []
                print(posts)
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
        
        /*
        let urlString = "https://api.forecast.io/forecast/apiKey/37.5673776,122.048951"
        
        let url = URL(string: urlString)
        URLSession.shared.dataTask(with:url!) { (data, response, error) in
            if error != nil {
                print(error)
            } else {
                do {
                    
                    let parsedData = try JSONSerialization.jsonObject(with: data!) as! [String:Any]
                    let currentConditions = parsedData["currently"] as! [String:Any]
                    
                    print(currentConditions)
                    
                    let currentTemperatureF = currentConditions["temperature"] as! Double
                    print(currentTemperatureF)
                } catch let error as NSError {
                    print(error)
                }
            }
            
            }.resume()*/
        
    }
    
    func getProfilesForLocation() -> [Profile] {
        let temp = [Profile]()
        
        return temp
    }
    
    func getMerchantForID(id: String) {
        
        let url_string = "http://api.reimaginebanking.com/enterprise/merchants/\(id)?key=9cc2fd23d5418761bd3aa07598f89fe1"
        
        
        let url = URL(string: url_string)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as! [String:Any]
                let posts = json["posts"] as? [[String: Any]] ?? []
                print(posts)
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
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
