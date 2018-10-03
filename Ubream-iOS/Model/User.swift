//
//  User.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class User: NSObject, NSCoding {
    
    var id:Int?
    var firstname:String?
    var lastname: String?
    var phone:String?
    var password: String?
    var type:Int?
    var countryId:Int?
    var cityId: Int?
    
    var activation: Int?
    var bankId: Int?
    var bankNumber: Int?
    var nameOfOtherAccounts: String?
    var apiToken: String?
    var language: String?
    var image: String?
    var isVerified: Int?
    var createdAt: String?
    var updatedAt: String?
    var mobileToken: String?
    var email: String?
    var resetPasswordCode: Int?
    var tempPhoneCode: Int?
    var terms: String?
    var country: Country?
    var city: City?
    
    var driver: Driver?

    
    required  init(_ data:JSON) {
        self.id = data["id"].int
        self.firstname = data["first_name"].string
        self.lastname = data["last_name"].string
        self.phone = data["phone"].string
        self.type = data["type"].int
        self.password = data["password"].string
        self.countryId = data["country_id"].int
        self.cityId = data["city_id"].int
        
        self.activation = data["activation"].int
        self.bankId = data["bank_id"].int
        self.bankNumber = data["bank_number"].int
        self.nameOfOtherAccounts = data["name_of_account_other"].string
        self.apiToken = data["api_token"].string
        self.language = data["language"].string
        self.image = data["image"].string
        self.isVerified = data["is_verified"].int
        self.createdAt = data["created_at"].string
        self.updatedAt = data["updated_at"].string
        self.mobileToken = data["mobile_token"].string
        self.email = data["email"].string
        self.resetPasswordCode = data["reset_password_code"].int
        self.tempPhoneCode = data["temp_phone_code"].int
        self.terms = data["terms"].string
        self.country = Country(data["country"])
        self.city = City(data["city"])
        self.driver = Driver(data["driver_info"])
        
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        firstname = aDecoder.decodeObject(forKey: "first_name") as? String
        lastname = aDecoder.decodeObject(forKey: "last_name") as? String
        phone = aDecoder.decodeObject(forKey: "phone") as? String
        type = aDecoder.decodeObject(forKey: "type") as? Int
        password = aDecoder.decodeObject(forKey: "password") as? String
        countryId = aDecoder.decodeObject(forKey: "country_id") as? Int
        cityId = aDecoder.decodeObject(forKey: "city_id") as? Int
        
        activation = aDecoder.decodeObject(forKey: "activation") as? Int
        bankId = aDecoder.decodeObject(forKey: "bank_id") as? Int
        bankNumber = aDecoder.decodeObject(forKey: "bank_number") as? Int
        nameOfOtherAccounts = aDecoder.decodeObject(forKey: "name_of_account_other") as? String
        apiToken = aDecoder.decodeObject(forKey: "api_token") as? String
        language = aDecoder.decodeObject(forKey: "language") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        isVerified = aDecoder.decodeObject(forKey: "is_verified") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        mobileToken = aDecoder.decodeObject(forKey: "mobile_token") as? String
        email = aDecoder.decodeObject(forKey: "email") as? String
        resetPasswordCode = aDecoder.decodeObject(forKey: "reset_phone_code") as? Int
        tempPhoneCode = aDecoder.decodeObject(forKey: "temp_phone_code") as? Int
        terms = aDecoder.decodeObject(forKey: "terms") as? String
        country = aDecoder.decodeObject(forKey: "country") as? Country
        city = aDecoder.decodeObject(forKey: "city") as? City
        driver = aDecoder.decodeObject(forKey: "driver_info") as? Driver
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(firstname, forKey: "first_name")
        aCoder.encode(lastname, forKey: "last_name")
        aCoder.encode(phone, forKey: "phone")
        aCoder.encode(type, forKey: "type")
        aCoder.encode(password, forKey: "password")
        aCoder.encode(countryId, forKey: "country_id")
        aCoder.encode(cityId, forKey: "city_id")
        
        aCoder.encode(activation, forKey: "activation")
        aCoder.encode(bankId, forKey: "bank_id")
        aCoder.encode(bankNumber, forKey: "bank_number")
        aCoder.encode(nameOfOtherAccounts, forKey: "name_of_account_other")
        aCoder.encode(apiToken, forKey: "api_token")
        aCoder.encode(language, forKey: "language")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(isVerified, forKey: "is_verified")
        aCoder.encode(createdAt, forKey: "created_at")
        aCoder.encode(updatedAt, forKey: "updated_at")
        aCoder.encode(mobileToken, forKey: "mobile_token")
        aCoder.encode(email, forKey: "email")
        aCoder.encode(resetPasswordCode, forKey: "reset_phone_code")
        aCoder.encode(tempPhoneCode, forKey: "temp_phone_code")
        aCoder.encode(terms, forKey: "terms")
        aCoder.encode(country, forKey: "country")
        aCoder.encode(city, forKey: "city")
        aCoder.encode(driver, forKey: "driver_info")
    }
}
