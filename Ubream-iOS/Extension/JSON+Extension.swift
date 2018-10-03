//
//  JSON+Extension.swift
//  Re7la
//
//  Created by Mina Gad on 3/8/18.
//  Copyright © 2018 Mina Gad. All rights reserved.
//

import Foundation
import SwiftyJSON

extension JSON {
    
    var toBool: Bool? {
        if let bool = self.bool { return bool }
        if let int = self.toInt {
            if int == 0 {
                return false
            }
            else if int == 1 {
                return true
            }
        }
        return nil
    }
    
    var toInt: Int?{
        if let int = self.int { return int }
        if let string = self.string , let int = Int(string) { return int }
        return nil
    }
    
    
//    var toImagePath: String? {
//        guard let string = self.string , !string.isEmpty else { return nil }
//        return URLs.imageUrl + string
//    }
    
}
