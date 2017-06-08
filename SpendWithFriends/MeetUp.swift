//
//  MeetUp.swift
//  SpendWithFriends
//
//  Created by Kristian Langholm on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import Foundation

class MeetUp: NSObject {
    
    fileprivate var sender: Profile
    fileprivate var venue: String!
    fileprivate var date: Date!
    fileprivate var address: String!
    fileprivate var time: String!
    fileprivate var message: String?
    fileprivate var phone: String?
    fileprivate var recipient: Profile!
    fileprivate var read = false
    fileprivate var accepted: Bool?
    
    var getSender: Profile!{
        return sender
    }
    var getVenue: String!{
        return venue
    }
    
    var getDate: Date!{
        return date
    }

    var getAddress: String!{
        return address
    }
    
    var getTime: String!{
        return time
    }
    
    var getMessage: String!{
        return message
    }
    
    var getPhone: String!{
        return phone
    }
    
    var getRecipient: Profile!{
        return recipient
    }
    
    var getRead: Bool!{
        return read
    }
    
    var getAccepted: Bool!{
        return accepted
    }
    
    init(sender: Profile, venue: String, date: Date, address: String, time: String, recipient: Profile){
        self.sender = sender
        self.venue = venue
        self.date = date
        self.address = address
        self.time = time
        self.recipient = recipient
    }
    
    func toggleRead(){
        self.read = !self.read
    }
    
    func setAccepted(accept: Bool){
        self.accepted = accept
    }
    
    func addMessage(message: String){
        self.message = message
    }
    
    func addPhone(phone: String){
        self.phone = phone
    }
}
