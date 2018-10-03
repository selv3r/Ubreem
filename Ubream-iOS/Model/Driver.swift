//
//  Driver.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class Driver: NSObject, NSCoding {
    
    var id: Int?
    var nationalIdentity: String?
    var drivingLicense: String?
    var vechileRegistration: String?
    var clearanceCriminal: String?
    var expiredNationalIdentity: String?
    var expiredDrivingLicense: String?
    var expiredVechileRegistration: String?
    var expiredClearanceCriminal: String?
    var userId: Int?
    var createdAt: String?
    var updatedAt: String?
    var expired: Bool?
    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.nationalIdentity = data["national_identity"].string
        self.drivingLicense = data["driving_license"].string
        self.vechileRegistration = data["vehicle_registration"].string
        self.clearanceCriminal = data["clearance_criminal"].string
        self.expiredNationalIdentity = data["expired_national_identity"].string
        self.expiredDrivingLicense = data["expired_driving_license"].string
        self.expiredVechileRegistration = data["expired_vehicle_registration"].string
        self.expiredClearanceCriminal = data["expired_clearance_criminal"].string
        self.userId = data["user_id"].int
        self.createdAt = data["created_at"].string
        self.updatedAt = data["updated_at"].string
        self.expired = data["expired"].bool
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        nationalIdentity = aDecoder.decodeObject(forKey: "national_identity") as? String
        drivingLicense = aDecoder.decodeObject(forKey: "driving_license") as? String
        vechileRegistration = aDecoder.decodeObject(forKey: "driving_license") as? String
        clearanceCriminal = aDecoder.decodeObject(forKey: "clearance_criminal") as? String
        expiredNationalIdentity = aDecoder.decodeObject(forKey: "expired_national_identity") as? String
        expiredDrivingLicense = aDecoder.decodeObject(forKey: "expired_driving_license") as? String
        expiredVechileRegistration = aDecoder.decodeObject(forKey: "expired_vehicle_registration") as? String
        expiredClearanceCriminal = aDecoder.decodeObject(forKey: "expired_clearance_criminal") as? String
        userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        expired = aDecoder.decodeObject(forKey: "expired") as? Bool
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(nationalIdentity, forKey: "national_identity")
        aCoder.encode(drivingLicense, forKey: "driving_license")
        aCoder.encode(vechileRegistration, forKey: "vechile_registration")
        aCoder.encode(clearanceCriminal, forKey: "clearance_criminal")
        aCoder.encode(expiredNationalIdentity, forKey: "expired_national_identity")
        aCoder.encode(expiredDrivingLicense, forKey: "expired_driving_license")
        aCoder.encode(expiredVechileRegistration, forKey: "expired_vehicle_registration")
        aCoder.encode(userId, forKey: "user_id")
        aCoder.encode(createdAt, forKey: "created_at")
        aCoder.encode(updatedAt, forKey: "updated_at")
        aCoder.encode(expired, forKey: "expired")
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
