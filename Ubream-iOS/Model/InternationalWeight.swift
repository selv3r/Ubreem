//
//  Weight.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/23/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class InternationalWeight: NSObject, NSCoding {
    
    var id: Int?
    var arabicName: String?
    var englishName: String?
    var image: String?
    var activation: Int?
    var timeForDeliver: String?
    var weights: [WeightsInt]?
    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.arabicName = data["name_ar"].string
        self.arabicName = data["name_en"].string
        self.activation = data["activation"].int
        self.image = data["image"].string
        self.timeForDeliver = data["time_for_deliver"].string
        self.weights = data["weights"].map({WeightsInt($0.1)})
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        arabicName = aDecoder.decodeObject(forKey: "name_ar") as? String
        englishName = aDecoder.decodeObject(forKey: "name_en") as? String
        activation = aDecoder.decodeObject(forKey: "activation") as? Int
        image = aDecoder.decodeObject(forKey: "image") as? String
        timeForDeliver = aDecoder.decodeObject(forKey: "time_for_deliver") as? String
        weights = aDecoder.decodeObject(forKey: "weights") as? [WeightsInt]
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(arabicName, forKey: "name_ar")
        aCoder.encode(englishName, forKey: "name_en")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(activation, forKey: "activation")
        aCoder.encode(timeForDeliver, forKey: "time_for_deliver")
        aCoder.encode(weights, forKey: "weights")
    }
    
}
