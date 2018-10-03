//
//  PhoneNumber.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/19/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class PhoneNumber: NSObject, NSCoding {
    
    var phoneNumber: Int?
    
    required  init(_ data: JSON) {
        self.phoneNumber = data["phone"].int
    }
    
    required init(coder aDecoder: NSCoder) {
        phoneNumber = aDecoder.decodeObject(forKey: "phone") as? Int
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(phoneNumber, forKey: "phone")
    }
    
}
