//
//  Validation.swift
//  Re7la
//
//  Created by Mina Gad on 2/27/18.
//  Copyright © 2018 Mina Gad. All rights reserved.
//

import Foundation

class ValidationX: NSObject {
    
    var validName: Bool {
        return isValidUserName(userNameString: userName!)
    }
    var validEmail: Bool {
        return isValidEmailAddress(emailAddressString: email!)
    }
    var validPhone: Bool {
        return isValidPhoneNumber(phoneString: phone!, numbers: Int(self.numberOfAllowedDigit ?? 10))
    }
    
    var validOptionalPhone: Bool {
        return isValidOptionalPhoneNumber(OptiphoneString: OptionalPhone!, min: 9, max: 9)
    }
    
    var validPassword: Bool {
        return isValidPassword(passwordString: password!)
    }
    var validArea: Bool {
        return isValidArea(area: area!)
    }
    
//    var validEmailOrPhone: Bool {
//        get {
//            if let phone = phone , let email = email {
//                let valid = isValidPhoneNumber(phoneString: phone)  ?  isValidPhoneNumber(phoneString: phone) : isValidEmailAddress(emailAddressString: email)
//                return valid
//            }
//            return false
//        }
//    }
    
    
//    var validNameEngOrArabic: Bool {
//        get {
//            if let name = userName {
//                if isValidArabicUserName(arabicUserNameString: name) {
//                    return true
//                }
//                if name.isNotHaveNumbersOrSChr {
//                    return true
//                }
//            }
//            return false
//        }
//    }
//
    var userName: String?
    var email: String?
    var phone: String?
    var password: String?
    var area: String?
    var numberOfAllowedDigit: Int32?
    var OptionalPhone: String?
    
    init(userName: String? = nil, email: String? = nil, phone: String? = nil, password: String? = nil, area: String? = nil, numberOfAllowedDigit: Int32? = nil, OptionalPhone: String? = nil) {
        super.init()
        self.userName = userName
        self.password = password
        self.phone = phone
        self.email = email
        self.area = area
        self.numberOfAllowedDigit = numberOfAllowedDigit
        self.OptionalPhone = OptionalPhone
    }
    
//    func isValidArabicUserName(arabicUserNameString: String) -> Bool {
//        var returnValue = true
//        let userNameRegEx = "^[\\u0621-\\u064A\\u0660-\\u0669 ]+$"
//        do {
//            let regex = try NSRegularExpression(pattern: userNameRegEx)
//            let nsString = arabicUserNameString as NSString
//            let results = regex.matches(in: arabicUserNameString, range: NSRange(location: 0, length: nsString.length))
//
//            if results.count == 0
//            {
//                returnValue = false
//            }
//
//        }
//        catch let error as NSError {
//            print("invalid regex: \(error.localizedDescription)")
//            returnValue = false
//        }
//        return  returnValue
//    }

    func isValidUserName(userNameString: String) -> Bool {
        var returnValue = true
        let userNameRegEx = "^[a-zA-Z\\s]+$"

        do {
            let regex = try NSRegularExpression(pattern: userNameRegEx)
            let nsString = userNameString as NSString
            let results = regex.matches(in: userNameString, range: NSRange(location: 0, length: nsString.length))
            if results.count == 0
            {
                returnValue = false
            }

        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }

    func isValidEmailAddress(emailAddressString: String) -> Bool {
        
        var returnValue = true
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}$"
        do {
            let regex = try NSRegularExpression(pattern: emailRegEx)
            let nsString = emailAddressString as NSString
            let results = regex.matches(in: emailAddressString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func isValidPhoneNumber(phoneString: String, numbers: Int) -> Bool {
        var returnValue = true
        let phoneRegEx = "^[+]?[0-9]{\(numbers),\(numbers)}$"
        do {
            let regex = try NSRegularExpression(pattern: phoneRegEx)
            let nsString = phoneString as NSString
            let results = regex.matches(in: phoneString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func isValidOptionalPhoneNumber(OptiphoneString: String, min: Int, max: Int) -> Bool {
        var returnValue = true
        let phoneRegEx = "^[+]?[0-9]{\(min),\(max)}$"
        do {
            let regex = try NSRegularExpression(pattern: phoneRegEx)
            let nsString = OptiphoneString as NSString
            let results = regex.matches(in: OptiphoneString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
            
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func isValidPassword(passwordString: String) -> Bool {
        var returnValue = true
        let passwordRegEx = "^(?=.*[0-9])(?=.*[A-Z]).{6,}$"

        do {
            let regex = try NSRegularExpression(pattern: passwordRegEx)
            let nsString = passwordString as NSString
            let results = regex.matches(in: passwordString, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
    func isValidArea(area: String) -> Bool {
        var returnValue = true
        let areaRegEx = ".*[\\u0600-\\u065F\\u066A-\\u06EF\\u06FA-\\u06FFa-zA-Z]+.*"
        
        do {
            let regex = try NSRegularExpression(pattern: areaRegEx)
            let nsString = areaRegEx as NSString
            let results = regex.matches(in: areaRegEx, range: NSRange(location: 0, length: nsString.length))
            
            if results.count == 0
            {
                returnValue = false
            }
        } catch let error as NSError {
            print("invalid regex: \(error.localizedDescription)")
            returnValue = false
        }
        return  returnValue
    }
    
}
