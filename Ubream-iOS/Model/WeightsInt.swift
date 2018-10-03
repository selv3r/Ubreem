//
//  WeightsInt.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 10/2/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class WeightsInt: NSObject, NSCoding {
    var id: Int?
    var weight: String?
    var price: String?
    var activation: Int?
    var countryId: Int?
    var createdAt: String?
    var updatedAt: String?
    
    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.weight = data["weight"].string
        self.price = data["price"].string
        self.activation = data["activation"].int
        self.countryId = data["country_id"].int
        self.createdAt = data["created_at"].string
        self.updatedAt = data["updated_at"].string
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        weight = aDecoder.decodeObject(forKey: "weight") as? String
        price = aDecoder.decodeObject(forKey: "price") as? String
        activation = aDecoder.decodeObject(forKey: "activation") as? Int
        countryId = aDecoder.decodeObject(forKey: "country_id") as? Int
        
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(price, forKey: "price")
        aCoder.encode(weight, forKey: "weight")
        aCoder.encode(activation, forKey: "activation")
        aCoder.encode(countryId, forKey: "country_id")
    }
}
