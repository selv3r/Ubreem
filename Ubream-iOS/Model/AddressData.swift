//
//  AddressData.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class AddressData: NSObject, NSCoding {
    
    var countries: [Country]?
    
    required init(_ data: JSON) {
        self.countries = data["countries"].map({Country($0.1)})
    }
    
    required init(coder aDecoder: NSCoder) {
        countries = aDecoder.decodeObject(forKey: "countries") as? [Country]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(countries, forKey: "countries")
    }
    
    
    
}
