//
//  Validation.swift
//  Events
//
//  Created by abdelrahman on 1/30/18.
//  Copyright © 2018 abdelrahman. All rights reserved.
//

import UIKit

struct ValidationData {
    let field:String
    let name:String
    let type:String
    init(value:String,name:String,type:String) {
        self.field = value
        self.name = name
        self.type = type
    }
}
struct ValidationDataTextField {
    let field:UITextField
    let name:String
    let type:String
    init(field:UITextField,name:String,type:String) {
        self.field = field
        self.name = name
        self.type = type
    }
}

class Validation {
    
    static var instance: Validation {
        return Validation()
    }
    
    static var errorMessage: String?
    
    
    func ValidationWithType(value:String , fieldName:String ,ConfirmText:String = "" , types : String) -> String {
       
        for type in types.components(separatedBy: "|") {
            
            if type == "required" , value.isBlank == true{
                return  self.RequiredMessage(Name:fieldName)
            }
            
            if type == "email" , value.isEmail == false{
                return self.EmailValidMessage(Name:fieldName)
            }
            
            if type == "phone" ,value.isPhoneNumber == false {
                return self.PhoneNumberValidMessage(Name:fieldName)
            }
            
            if type == "notOnlyNumber" ,value.isNumber == true
            {
                return self.NotOnlyNumberValidMessage(Name:fieldName)
            }
            
            if type == "notOnlyNumberOrSpacialChr" ,value.isNotHaveNumbersOrSChr == true {
                return self.notOnlyNumberOrSpacialChr(Name:fieldName)
            }
            
            if type == "password" ,value.isValidPassword == false {
                return self.PasswordValidMessage(Name:fieldName)
            }
            
            if type == ((type.range(of:"min") != nil) ? type : "min") {
                let num = Int(type.replacingOccurrences(of: "min:", with: "", options: NSString.CompareOptions.literal, range:nil))
                if (value.count) < num! {
                    return "\(fieldName) " + "must be at least".Localize + " \(num!) " + "characters".Localize
                }
            }
            
            if type == ((type.range(of:"max") != nil) ? type : "max") {
                let num = Int(type.replacingOccurrences(of: "max:", with: "", options: NSString.CompareOptions.literal, range:nil))
                if (value.count) > num! {
                    return "\(fieldName) " + "may not be greater than".Localize + " \(num!) " + "characters".Localize
                }
            }
        }
        return "1"
        
    }
    
    func ValidationWithTypeTextField(textField: UITextFieldX , TextFieldName:String ,ConfirmText:String = "" , type : String) -> ([String: Any]) {
        var message = "1"
        var NewTextField:UITextFieldX = UITextFieldX()
        switch type {
        case "required":
            message = textField.text?.isBlank == true ?  self.RequiredMessage(Name:TextFieldName) : "1"
            NewTextField = textField
            break
        case "email":
            message = textField.text?.isEmail == false ?  self.EmailValidMessage(Name:TextFieldName) : "1"
            NewTextField = textField
            break
        case "phone":
            message = textField.text?.isPhoneNumber == false ?  self.PhoneNumberValidMessage(Name:TextFieldName) : "1"
            NewTextField = textField
            break
        case "notOnlyNumber":
            message = textField.text?.isNumber == true ?  self.NotOnlyNumberValidMessage(Name:TextFieldName) : "1"
            break
        case "password":
            message = textField.text?.isValidPassword == false ?  self.PasswordValidMessage(Name:TextFieldName) : "1"
            NewTextField = textField
            break
        case (type.range(of:"min") != nil) ? type : "min":
            let num = Int(type.replacingOccurrences(of: "min:", with: "", options: NSString.CompareOptions.literal, range:nil))
            message = (textField.text?.count)! < num! ?  "\(TextFieldName) " + "must be at least".Localize + " \(num!) " + "characters".Localize : "1"
            NewTextField = textField
            break
        case (type.range(of:"max") != nil) ? type : "max":
            let num = Int(type.replacingOccurrences(of: "max:", with: "", options: NSString.CompareOptions.literal, range:nil))
            message = (textField.text?.count)! > num! ?  "\(TextFieldName) " + "may not be greater than".Localize  + " \(num!) " + "characters".Localize : "1"
            NewTextField = textField
            break
        default:
            break
        }
        return ["message":message , "field":NewTextField]
        
    }
    
//
//    func SetValidationTextField(ValidationData:[ValidationDataTextField]) ->Bool {
//        var message = [[String: Any]]()
//
//        for field in ValidationData {
//            field.field.detail = ""
//            field.field.dividerActiveColor = ColorConstant.blue
//            if message.contains(where: {($0["field"] as! UITextField) == field.field}) == false {
//                message.append(
//                    ValidationWithTypeTextField(
//                        textField:field.field ,
//                        TextFieldName:field.name ,
//                        type : field.type))
//                if let index = message.index(where:{($0["message"] as! String) == "1"}) {
//                    message.remove(at:index)
//                }
//            }
//
//        }
//        for item in message {
//            if (item["message"] as! String) != "1" {
//                ShowAlertTextField(TextField:item["field"] as! UITextField , message:item["message"] as! String)
//            }
//        }
//        if message.contains(where: {($0["message"] as! String) != "1"}) {
//            return false
//        }
//        return true
//    }
//
    
    
    
    func checkConnection() -> Bool {
        
        if NetworkManager.shared.connected == false {
            ShowAlert(message: "Network is offline".locale)
        }
        
        return NetworkManager.shared.connected
    }
    
    func SetValidation(ValidationData:[ValidationData], isAlert: Bool = true) ->Bool {
        var message = [String]()
        for field in ValidationData {
            message.append(
                ValidationWithType(
                    value:field.field ,
                    fieldName:field.name ,
                    types : field.type))
        }
        for item in message {
            if item != "1" {
                //colorAlert(textfield: item)
                return false
            }
        }
        return true
    }
    
    func colorAlert(textfield: UITextField) {
        textfield.layer.borderColor = #colorLiteral(red: 0.8196078431, green: 0.2980392157, blue: 0.2980392157, alpha: 1)
    }
    
//    func ShowAlertTextField(TextField: UITextFieldX, message: String) {
//        TextField.detail = message
//        TextField.dividerColor = .red
////        TextField.detailLabel.textAlignment = Config.locale == .en ? .right : .left
//        TextField.detailColor = .red
//        //        if let topController = UIApplication.topViewController() {
//        //            if message != "1" {
//        //                topController.DangerAlert(message:message, AutoHide: true)
//        //            }
//        //        }
//    }
    
    func ShowAlert(message:String, isAlert: Bool = false) {
        if let topController = UIApplication.topViewController() {
            if message != "1" {
                Validation.errorMessage = message
                if isAlert {
                    topController.DangerAlert(message: message)
                }
            }
        }
    }
    
    func PasswordValidMessage(Name:String) -> String {
        return "\(Name) " + "Password".locale + "Is Invalid".locale
    }
    
    func ConfirmValidMessage(Name:String) -> String {
        return "تأكيد \(Name) " + "Is Invalid".locale
    }
    func PhoneNumberValidMessage(Name:String) -> String {
        return "\(Name) " + "Is Invalid".locale
    }
    
    func notOnlyNumberOrSpacialChr(Name:String) -> String {
        return "\(Name) " + "should not be numbers only or spcial characters".locale
    }
    
    func NotOnlyNumberValidMessage(Name:String) -> String {
        return "\(Name) " + "should not be numbers only".locale
    }
    func EmailValidMessage(Name:String) -> String {
        return "\(Name) " + "Is Invalid".locale
    }
    
    func RequiredMessage(Name:String) -> String {
        return "\(Name) " + "Is Required".locale
    }
}
