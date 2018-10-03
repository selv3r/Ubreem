//
//  City.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class City: NSObject, NSCoding {
    
    var id: Int?
    var arabicName: String?
    var englishName: String?
    var activation: Int?
    var countryId: Int?
    var createdAt: String?
    var updatedAt: String?
    var regions: [Region]?
    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.arabicName = data["name_ar"].string
        self.englishName = data["name_en"].string
        self.activation = data["activation"].int
        self.countryId = data["country_id"].int
        self.createdAt = data["created_at"].string
        self.updatedAt = data["updated_at"].string
        self.regions = data["regions"].map({Region($0.1)})
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        arabicName = aDecoder.decodeObject(forKey: "name_ar") as? String
        englishName = aDecoder.decodeObject(forKey: "name_en") as? String
        activation = aDecoder.decodeObject(forKey: "activation") as? Int
        countryId = aDecoder.decodeObject(forKey: "country_id") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        regions = aDecoder.decodeObject(forKey: "regions") as? [Region]

    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(arabicName, forKey: "name_ar")
        aCoder.encode(englishName, forKey: "name_en")
        aCoder.encode(activation, forKey: "activation")
        aCoder.encode(countryId, forKey: "country_id")
        aCoder.encode(createdAt, forKey: "created_at")
        aCoder.encode(updatedAt, forKey: "updated_at")
        aCoder.encode(regions, forKey: "regions")

    }
    
    
}

















