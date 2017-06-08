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

protocol addUserDelegate {
    func addUserAuthorized()
    func addUserDeclined()
}

protocol MapDataDelegate {
    func didRetrieveUserPurchaseData(purchases: [Purchase])
    func didRetrieveGeoData(m: [Merchant])
}

class DataHandler {
    
    var user_id: String
    
    var lDelegate: loginDelegate?
    
    var auDelegate: addUserDelegate?
    
        var mapDelegate: MapDataDelegate?
    
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
        var purchases = [Purchase]()
        
        let url_string = "http://lukeporupski.com/newPhp/getPurchasesOfUser.php?id=\(user_id)"
        let url = URL(string: url_string)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let temp = json as? [[String: String]]
                for purchase in temp! {
                    let newPurchase = Purchase(merchID: purchase["merchant_id"]!, date: purchase["purchase_date"]!, amt: purchase["amount"]!, desc: purchase["description"]!)
                    purchases.append(newPurchase)
                    if purchases.count == temp?.count {
                        self.mapDelegate?.didRetrieveUserPurchaseData(purchases: purchases)
                        
                    }
                }
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
    }
    
    func getProfilesForLocation() -> [Profile] {
        let temp = [Profile]()
        
        return temp
    }
    
    func getMerchantsFromPurchases(purchases: [Purchase]) {
        var ms = [Merchant]()
        
        for p in purchases {
            
            let url_string = "http://lukeporupski.com/newPhp/getMerchantFromID.php?id=\(p.merchant_id)"
            
            let url = URL(string: url_string)
            var count = 0
            URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
                guard let data = data, error == nil else { return }
                
                do {
                    let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    if let vals = json as? [[String:String]] {
                        let temp = vals[0] as! [String:String]
                        
                        if let lng = temp["lng"] {
                            if let lat = temp["lat"] {
                                let newMerchant = Merchant(name: temp["name"]!, merchantId: temp["MerchantID"]!, category: temp["category"]!, latitude: lat, longitude: lng)
                                ms.append(newMerchant)
                                if ms.count == purchases.count - count{
                                    self.mapDelegate?.didRetrieveGeoData(m: ms)
                                }
                            }
                            else {
                                count = count + 1
                            }
                        }
                        else {
                            count = count + 1
                        }
                        
                        
                        
                    }
                    
                } catch let error as NSError {
                    print(error)
                }
            }).resume()
            
        }
        
        
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
    
    
    func getProfilesForMerchant(id: String) {
        let temp = [Profile]()
            }
    
    
    func authorizeLogin(username: String, password: String) {
        let loginURL: String = "http://lukeporupski.com/newPhp/checkPass.php?username=" + username + "&password=" + password
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
    
    func addUser(name: String, username: String, password: String) {
        let signUpURL: String = "http://lukeporupski.com/newPhp/addUsers.php?username=" + username + "&password=" + password + "&name=" + name
        //if (picLink != "") {
          //  signUpURL += "&PicLink=" + picLink
        //}
        //let signUpURL: String = "http://lukeporupski.com/newPhp/addUsers.php?Username=frog&Password=frogger&Name=devin"
        let url: URL = URL(string: signUpURL)!
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
                self.auDelegate?.addUserAuthorized()
                print("good shit")
            } else {
                self.auDelegate?.addUserDeclined()
            }
        })
        task.resume()
        
        
    }
    
    
    
    
}
