//
//  Address.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/25/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class Address: NSObject, NSCoding {
    
    
    
    var id: Int?
    var name: String?
    var countryId: Int?
    var cityId: Int?
    var regionId: Int?
    var type: Int?
    var neighborhood: String?
    var latitude: String?
    var longtude: String?
    var userId: Int?
    var createdAt: String?
    var updatedAt: String?
    var country: Country?
    var city: City?
    var region: Region?
    var phone: String?
    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.name = data["name"].string
        self.countryId = data["country_id"].int
        self.cityId = data["city_id"].int
        self.regionId = data["region_id"].int
        self.type = data["type"].int
        self.neighborhood = data["neighborhood"].string
        self.latitude = data["latitude"].string
        self.longtude = data["longitude"].string
        self.userId = data["user_id"].int
        self.createdAt = data["created_at"].string
        self.updatedAt = data["updated_at"].string
        self.country = Country(data["country"])
        self.city = City(data["city"])
        self.region = Region(data["region"])
        self.phone = data["phone"].string
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        name = aDecoder.decodeObject(forKey: "name") as? String
        countryId = aDecoder.decodeObject(forKey: "country_id") as? Int
        cityId = aDecoder.decodeObject(forKey: "city_id") as? Int
        regionId = aDecoder.decodeObject(forKey: "region_id") as? Int
        type = aDecoder.decodeObject(forKey: "type") as? Int
        neighborhood = aDecoder.decodeObject(forKey: "neighborhood") as? String
        latitude = aDecoder.decodeObject(forKey: "latitude") as? String
        longtude = aDecoder.decodeObject(forKey: "longitude") as? String
        userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        country = aDecoder.decodeObject(forKey: "country") as? Country
        city = aDecoder.decodeObject(forKey: "city") as? City
        region = aDecoder.decodeObject(forKey: "region") as? Region
        phone = aDecoder.decodeObject(forKey: "phone") as? String
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(name, forKey: "name")
        aCoder.encode(countryId, forKey: "country_id")
        aCoder.encode(cityId, forKey: "city_id")
        aCoder.encode(regionId, forKey: "region_id")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(neighborhood, forKey: "neighborhood")
        aCoder.encode(latitude, forKey: "latitude")
        aCoder.encode(longtude, forKey: "longitude")
        aCoder.encode(userId, forKey: "user_id")
        aCoder.encode(createdAt, forKey: "created_at")
        aCoder.encode(updatedAt, forKey: "updated_at")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(region, forKey: "region")
        aCoder.encode(phone, forKey: "phone")
    }
    
    
    
    
}
