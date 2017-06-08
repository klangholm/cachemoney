//
//  Profile.swift
//  HackathonApp
//
//  Created by Yiheyis, Leoul on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit


class Profile : NSObject {
    
    fileprivate var name: String
    fileprivate var custId: String
    fileprivate var pic: UIImage = UIImage(named: "Unknown.png")!
    fileprivate var username: String
    fileprivate var password: String
    
    init(name: String, custId: String, username: String, password: String) {
        self.name = name
        self.custId = custId
        self.username = username
        self.password = password
    }
    
    
    func setName(newName: String) {
        self.name = newName
    }
    
    var getName: String {
        return self.name
    }
    
    func setProfilePic(pic: UIImage) {
        self.pic = pic
    }
    
    var getPic: UIImage {
        return self.pic
    }
    
    var getUsername: String {
        return self.username
    }
    
    func setUsername(username: String) {
        self.username = username
    }
    
    var getPassword: String {
        return self.password
    }
    
    func setPassword(password: String) {
        self.password = password
    }
    
}
