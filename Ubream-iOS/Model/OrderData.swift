//
//  OrderData.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class OrderData: NSObject, NSCoding {
    
    var countries: [Country]?
    var insideWeight: InsideWeight?
    var outsideWeight: OutsideWeight?
    var internationalWeights: [InternationalWeight]?
    
    required init(with data:  JSON) {
        self.countries = data["countries"].map({Country($0.1)})
        self.insideWeight = InsideWeight(data["inside_weights"])
        self.outsideWeight = OutsideWeight(data["outside_weights"])
        
        self.internationalWeights = data["international_weights"].map {return InternationalWeight($0.1)}
    }
    
    required init(coder aDecoder: NSCoder) {
        countries = aDecoder.decodeObject(forKey: "countries") as? [Country]
        insideWeight = aDecoder.decodeObject(forKey: "inside_weights") as? InsideWeight
        outsideWeight = aDecoder.decodeObject(forKey: "outside_weights") as? OutsideWeight
        internationalWeights = aDecoder.decodeObject(forKey: "international_weights") as? [InternationalWeight]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(countries, forKey: "countries")
        aCoder.encode(insideWeight, forKey: "inside_weights")
        aCoder.encode(outsideWeight, forKey: "outside_weights")
        aCoder.encode(internationalWeights, forKey: "international_weights")
    }
    
}
