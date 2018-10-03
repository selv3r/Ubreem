//
//  Weight.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class InsideWeight: NSObject, NSCoding {
    
    var weights: [String]?
    var price: String?
    var timeForDeliver: String?
    var hint: String?
    
    required init(_ data: JSON) {
        self.weights = data["weight"].arrayValue.map{$0.string!}
        self.price = data["price"].string
        self.timeForDeliver = data["time_for_deliver"].string
        self.hint = data["hint"].string
        
    }
    
    required init(coder aDecoder: NSCoder) {
        weights = (aDecoder.decodeObject(forKey: "weight") as? [String]?)!
        price = aDecoder.decodeObject(forKey: "price") as? String
        timeForDeliver = aDecoder.decodeObject(forKey: "time_for_deliver") as? String
        hint = aDecoder.decodeObject(forKey: "hint") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(weights, forKey: "weight")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(timeForDeliver, forKey: "time_for_deliver")
        aCoder.encode(hint, forKey: "hint")
        
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
