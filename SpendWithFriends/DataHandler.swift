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


protocol addMeetUpDelegate {
    func addMeetUpAuthorized()
    func addMeetUpDeclined()
}

protocol MapDataDelegate {
    func didRetrieveUserPurchaseData(purchases: [Purchase])
    func didRetrieveGeoData(m: [Merchant])
}

protocol MerchantUserDelegate {
    func didRetrieveProfilesForLocation(profiles: [Profile])
}

class DataHandler {
    
    var user_id: String
    
    var lDelegate: loginDelegate?
    
    var auDelegate: addUserDelegate?

    var amDelegate: addMeetUpDelegate?

    var mapDelegate: MapDataDelegate?
    
    var muDelegate: MerchantUserDelegate?
    
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
    
    
    func getAcceptedMeetups(){
        
        var meetups = [MeetUp]()
        let url_string = "http://lukeporupski.com/newPhp/getMeetups.php?id=7&type=2"
        
        let url = URL(string: url_string)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data) as? [Any]
                var count = 0
                for item in json! {
                    if let meet = item as? [String: Any] {
                        var sender = meet["senderID"]
                        var recipient = meet["RecipientID"]
                        let sP = Profile(name: sender as! String, username: "", password: "")
                        let rP = Profile(name: recipient as! String, username: "", password: "")
                        
                        //let newMeetUp = MeetUp(sender: sP, venue: meet["Venue"] as! String, date: meet["Date"] as! String, time: meet["Time"] as! String, recipient: rP)
                        
                        
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
    
    
    func getRequests(){
        
        var meetups = [MeetUp]()
        
    }
    
    
    func getProfilesForLocation(merch: Merchant){
        var profs = [Profile]()
        let url_string = "http://lukeporupski.com/newPhp/getUserIDFromPurchasesBasedOnMerchantID.php?merchant_id=\(merch.merchantId)"
        
        let url = URL(string: url_string)
        URLSession.shared.dataTask(with:url!, completionHandler: {(data, response, error) in
            guard let data = data, error == nil else { return }
            
            do {
                
                let json = try JSONSerialization.jsonObject(with: data) as? [Any]
                var count = 0
                for item in json! {
                    if let prof = item as? [String: Any] {
                        var username = "temp"
                        
                        let newProf = Profile(name: prof["Name"] as! String, username: username, password: prof["Password"] as! String)
                        profs.append(newProf)
                        
                        if profs.count == (json?.count)! - count {
                            self.muDelegate?.didRetrieveProfilesForLocation(profiles: profs)
                        }
                    }
                    else {
                        count = count + 1
                    }
                }
                
                /*
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                let idk = json as? [String:String]
                let t2 = json as? [String:Any]
                let t3 = json as? [Any]
                for prof in temp! {
                    let newProf = Profile(name: prof["Name"]!, custId: prof["ID"]!, username: prof["Username"]!, password: prof["Password"]!)
                    
                    profs.append(newProf)
                    
                    if profs.count == temp?.count {
                        self.muDelegate?.didRetrieveProfilesForLocation(profiles: profs)
                    }
                }*/
                
            } catch let error as NSError {
                print(error)
            }
        }).resume()
        
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
    
    func addMeetUp(sender: Profile, venue: String, date: Date, time: String, recipient: Profile, message:String, phone:String, read:Int, accepted:Int) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/mm/yyyy"
        let newDate = dateFormatter.string(from: date)
        let signUpURL: String = "http://lukeporupski.com/newPhp/addMeetUp.php?senderID=\(sender.getName)&recipientID=\(recipient.getName)&venue=\(venue)&date=\(newDate)&time=\(time)&message=\(message)&phone=\(phone)&read=\(read)&accepted=\(accepted)"
        //if (picLink != "") {
        //  signUpURL += "&PicLink=" + picLink
        //}
        //let signUpURL: String = "http://lukeporupski.com/newPhp/addUsers.php?Username=frog&Password=frogger&Name=devin"
        print(signUpURL)
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
                self.amDelegate?.addMeetUpAuthorized()
                print("good shit")
            } else {
                self.amDelegate?.addMeetUpDeclined()
            }
        })
        task.resume()
        
        
    }
    
    
    
    
}
