//
//  Weight.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class Weight: NSObject, NSCoding {
    
    var weights: [String]?
    var price: String?
    var hint: String?
    var pricePerKg: String?
    var limit: String?
    
    required init(_ data: JSON) {
        self.weights = data["weight"].arrayValue.map{$0.string!}
        self.price = data["price"].string
        self.hint = data["hint"].string
        self.pricePerKg = data["price_per_kg"].string
        self.limit = data["limit"].string
    }
    
    required init(coder aDecoder: NSCoder) {
        weights = (aDecoder.decodeObject(forKey: "weight") as? [String]?)!
        price = aDecoder.decodeObject(forKey: "price") as? String
        hint = aDecoder.decodeObject(forKey: "hint") as? String
        pricePerKg = aDecoder.decodeObject(forKey: "price_per_kg") as? String
        limit = aDecoder.decodeObject(forKey: "limit") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(weights, forKey: "weight")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(hint, forKey: "hint")
        aCoder.encode(pricePerKg, forKey: "price_per_kg")
        aCoder.encode(limit, forKey: "limit")
    }
    
    
    
    
}
