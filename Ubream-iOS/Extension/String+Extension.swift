//
//  String+Extension.swift
//  General Project
//
//  Created by Mina Shehata Gad on 5/3/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import Foundation

extension String {
    
  
    
    static func className(_ aClass: AnyClass) -> String {
        return NSStringFromClass(aClass).components(separatedBy: ".").last!
    }
    
    var Localize: String {
        return NSLocalizedString(self, comment: self)
    }
    
    
    var length: Int {
        return self.count
    }
    
    var parseJSONString: AnyObject?
    {
        let data = self.data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        if let jsonData = data
        {
            // Will return an object or nil if JSON decoding fails
            do
            {
                let message = try JSONSerialization.jsonObject(with: jsonData, options:[.mutableContainers , .allowFragments])
                if let jsonResult = message as? NSMutableArray {
                    return jsonResult //Will return the json array output
                } else {
                    if let jsonResult = message as? NSMutableDictionary {
                        return jsonResult //Will return the json dictionary output
                    }
                    return false as AnyObject
                }
                
            }
            catch let error as NSError
            {
                print("An error occurred: \(error)")
                return nil
            }
        }
        else
        {
            // Lossless conversion of the string was not possible
            return nil
        }
    }
    
    //To check text field or String is blank or not
    var isBlank: Bool {
        get {
            let trimmed = trimmingCharacters(in: CharacterSet.whitespaces)
            return trimmed.isEmpty
        }
    }
    //Validate Phone
    
    var isPhoneNumber: Bool {
        do {
            let detector = try NSDataDetector(types: NSTextCheckingResult.CheckingType.phoneNumber.rawValue)
            let matches = detector.matches(in: self, options: [], range: NSMakeRange(0, self.count))
            if let res = matches.first {
                return res.resultType == .phoneNumber && res.range.location == 0 && res.range.length == self.count
            } else {
                return false
            }
        } catch {
            return false
        }
    }
    //Validate Email
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}", options: .caseInsensitive)
            return regex.firstMatch(in: self, options: NSRegularExpression.MatchingOptions(rawValue: 0), range: NSMakeRange(0, self.count)) != nil
        } catch {
            return false
        }
    }
    
    var isAlphanumeric: Bool {
        return !isEmpty && range(of: "[^a-zA-Z0-9]", options: .regularExpression) == nil
    }
    
    //
    var isNotHaveNumbersOrSChr: Bool {
        let characterset = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789 ةؤلاىيوهـشسقفغعضصنملكظطزرذدخحجثتبأإآ")
        return !self.isEmpty && self.rangeOfCharacter(from: characterset.inverted) != nil
    }
    
    
    func isPasswordConfirm(password: String , confirmPassword : String) -> Bool {
        if password == confirmPassword{
            return true
        }else{
            return false
        }
    }
    
    var isNumber : Bool {
        get{
            return !self.isEmpty && self.rangeOfCharacter(from: CharacterSet.decimalDigits.inverted) == nil
        }
    }
    
    //validate URL
    var isURL: Bool {
        get{
            if URL(string: self) != nil {
                return true
            }
            return false
        }
    }
    
    //validate Password
    var isValidPassword: Bool {
        //        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[$@$#!%*?&])[A-Za-z\\d$@$#!%*?&]{8,}")
        let passwordTest = NSPredicate(format: "SELF MATCHES %@", "^(?=.*[a-z])(?=.*[0-9])(?=.*[A-Z])[a-zA-Zء-ي\\d$@$#!%*?&]{6,}")
        return passwordTest.evaluate(with: self)
    }
    
    var localized: String {
        return NSLocalizedString(self, comment: self)
    }
    
    var timestamp: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    var date: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.date(from: self) ?? Date()
    }
    
    func toDate(format : String) -> Date{
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateFormat = format
        return dateFormatter.date(from: self)!
    }
    
    var trimmed: String {
        return self.trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    // parse html text........
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [NSAttributedString.DocumentReadingOptionKey.documentType:  NSAttributedString.DocumentType.html], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    
    func encode() -> String? {
        let data = self.data(using: .nonLossyASCII, allowLossyConversion: true)!
        return String(data: data, encoding: .utf8)
    }
    
    func decode() -> String? {
        let data = self.data(using: .utf8)!
        return String(data: data, encoding: .nonLossyASCII)
    }
 
    var isPlusFirstPhone: Bool {
        let startIndex = self.startIndex
        let endIndex = self.index(startIndex, offsetBy: 0)
        let substr = String(self[startIndex...endIndex])
        print(substr)
        if substr == "+" {
            return true
        }
        return false
    }
  
    
}



