//
//  DataHandler.swift
//  SpendWithFriends
//
//  Created by Porupski, Luke on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import Foundation

class DataHandler {
    
    var user_id: String
    
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
    
    
    
}
