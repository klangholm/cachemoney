//
//  Merchant.swift
//  SpendWithFriends
//
//  Created by Skiljan, Nicholas on 6/7/17.
//  Copyright © 2017 klangholm. All rights reserved.
//

import UIKit

class Merchant: NSObject {

    var name: String
    var merchantId: String
    var category: String
    var streetNumber: Int
    var streetName: String
    var city: String
    var state: String
    var zip: Int
    var latitude: Double
    var longitude: Double
    
    init(name: String, merchantId: String, category: String, streetNumber: Int,streetName: String, city: String, state: String, zip: Int, latitude: Double, longitude: Double) {
        self.name = name
        self.merchantId = merchantId
        self.category = category
        self.streetNumber = streetNumber
        self.streetName = streetName
        self.city = city
        self.state = state
        self.zip = zip
        self.latitude = latitude
        self.longitude = longitude
    }
    
    

}
