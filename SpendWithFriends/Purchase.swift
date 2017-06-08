//
//  Purchased.swift
//  SpendWithFriends
//
//  Created by Yiheyis, Leoul on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class Purchase: NSObject {
    var merchant_id: String
    var purchase_date: String
    var amount: String
    var desc: String
    
    init(merchID: String, date : String, amt: String, desc: String) {
        self.merchant_id = merchID
        self.purchase_date = date
        self.amount = amt
        self.desc = desc
    }
    
    func setMerchID(newMerch: String) {
        self.merchant_id = newMerch
    }
    
    var getMerchID: String {
        return self.merchant_id
    }
    
    func setPurchaseDate(newDate: String) {
        self.purchase_date = newDate
    }
    
    var getPurchaseDate: String {
        return self.purchase_date
    }
    
    func setAmount(newAmount: String) {
        self.amount = newAmount
    }
    
    var getAmount: String {
        return self.amount
    }
    
    func setDesc(newDesc: String) {
        self.desc = newDesc
    }
    
    var getDesc: String {
        return self.desc
    }
    
}
