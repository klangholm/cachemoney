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
    fileprivate var id: String
    fileprivate var pic: UIImage?
    
    
    //fileprivate var runningTabs = [Tab]()  //Array<Tab>?
    
    init(name: String, id: String) {
        self.name = name
        self.id = id
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
        return self.pic!
    }
    
    
}
