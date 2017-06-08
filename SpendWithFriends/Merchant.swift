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
    var latitude: Double
    var longitude: Double
    
    init(name: String, merchantId: String, category: String, latitude: String, longitude: String) {
        self.name = name
        self.merchantId = merchantId
        self.category = category
        let latArr = latitude.components(separatedBy: [" ", "\n", "$"])
        self.latitude = Double(latArr[0])!
        let lngArr = longitude.components(separatedBy: [" ", "\n", "$"])
        self.longitude = Double(lngArr[0])!
    }
    
    

}
