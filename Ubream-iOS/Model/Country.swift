//
//  Country.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class Country: NSObject, NSCoding {
    
    var id: Int?
    var arabicName: String?
    var englishName: String?
    var cities: [City]?

    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.arabicName = data["name_ar"].string
        self.englishName = data["name_en"].string
        self.cities = data["cities"].map({City($0.1)})

    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        arabicName = aDecoder.decodeObject(forKey: "name_ar") as? String
        englishName = aDecoder.decodeObject(forKey: "name_en") as? String
        cities = aDecoder.decodeObject(forKey: "cities") as? [City]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(arabicName, forKey: "name_ar")
        aCoder.encode(englishName, forKey: "name_en")
        aCoder.encode(cities, forKey: "cities")
    }
    
    
    
    
    
    
    
    
    
}
