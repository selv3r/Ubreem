 //
//  AuthAPI.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/18/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

final class API {
    
    // singleton instance......
    static let shared = API()
    private init() { }
    
    
    func uploadImageProduct(image: UIImage, completion: @escaping(String) -> Void) {
        Loader.shared.requestMultipart(photo: image, url: URLs.uploadFile, method: .post) { (data, success, error, value) in
            if let error = error {
                print(error)
                return
            }
            if let data = data {
                print("path", data)
                completion(data["path"].stringValue)
            }
        }
    }
    
    func loadCountries(completion: @escaping ([Country], [Bank], String) -> ()) {
        
        Loader.shared.request(with: URLs.getCountries, and: .get) { (data, success, error) in
            print(data)
            if let error = error {
                debugPrint("Error Loading Countries", error)
                //completion([], error)
            }
            if let data = data {
                let allCounties = data["countries"].map{Country($0.1)} ?? []
                let allBanks = data["banks"].map{Bank($0.1)} ?? []
                print(allCounties)
                completion(allCounties, allBanks, "")
            }
        }
    }
    
    func signUpAsUser(with parameters: [String: Any], completion: @escaping userCompletion) {
        print(URLs.signUp)
        print(parameters)
        
        Loader.shared.request(with: URLs.signUp, and: .post, and: parameters) { (dictionary, success, error) in
            if let error = error {
                print(error)
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        print(firstError)
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let dictionary = dictionary {
                print("ssssdfdsfsd" , dictionary["user"])
                let user = User(dictionary["user"])
                //Save Data into Defaults Here
                SavedUser.saveUser(user)
                completion(user, true, nil)
            }
            
        }
    }
    
    func phoneRegister(phone: String, completion: @escaping phoneCompletion) {
        Loader.shared.requestFromLoader(with: URLs.checkPhone, and: .post, and: ["phone": phone], completion: { (error, json) in
            if let error = error {
                completion(nil, false, error)
                return
            }
            if let json = json {
                if let code = json["code"].int {
                    completion(code, true, nil)
                }
            }
        })
    }
    
    func activateUser(apiToken: String, code: Int, completion: @escaping userCompletion) {
        Loader.shared.request(with: URLs.activateUserAccount, and: .patch, and: ["code": code, "api_token": apiToken]) { (dictionary, success, error) in
            if let error = error {
                print(error)
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        print(firstError)
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let dictionary = dictionary {
                print("ssssdfdsfsd" , dictionary["user"])
                let user = User(dictionary["user"])
                //Save Data into Defaults Here
                SavedUser.saveUser(user)
                completion(user, true, nil)
            }
        }
    }
    
    func signUp(with parameters: [String: Any], completion: @escaping userCompletion) {
        Loader.shared.request(with: URLs.signUp, and: .post, and: parameters) { (dictionary, success, error) in
            if let error = error {
                print(error)
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        print(firstError)
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let dictionary = dictionary {
                print("ssssdfdsfsd" , dictionary["user"])
                let user = User(dictionary["user"])
                //Save Data into Defaults Here
                SavedUser.saveUser(user)
                completion(user, true, nil)
            }
        }
    }
    
    
    func resendActivationCode(apiToken: String, completion: @escaping phoneCompletion) {
        Loader.shared.request(with: URLs.sendCodeAgain, and: .post, and: ["api_token": apiToken]) { (data, success, error) in
            if error != nil {
                debugPrint("Error: \(error)")
                completion(nil, false, "")
            }
            if let data = data {
                let code = data["code"].int
                print(code)
                completion(code, true, nil)
            }
        }
    }
    
    func login(phoneNumber: String, password: String, completion: @escaping userCompletion) {
        print("PhoneNumber \(phoneNumber)")
        Loader.shared.request(with: URLs.login, and: .post, and: ["name": phoneNumber, "password": password]) { (data, success, error) in
            
            if let error = error {
                debugPrint("Error \(error)")
                completion(nil, false, "")
            }
            if let data = data {
                print(phoneNumber)
                let user = User(data["user"])
                print(user)
                completion(user, true, nil)
            }
            
        }
    }
    
    
    
    func forgotPassword(phoneNumber: String, resetMethod: String, completion: @escaping phoneCompletion) {
        Loader.shared.request(with: URLs.forgotPassword, and: .post, and: ["name": phoneNumber, "reset_method": resetMethod]) { (data, success, error) in
            if let error = error {
                debugPrint("Error \(error)")
                completion(nil, false, "")
            }
            if let data = data {
                let code = data["code"].int
                print(code)
                completion(code, true, nil)
            }
        }
    }
    
    
    //Update password from Forgot Password Screen!
    func resetPasswordByCode(phoneNumber: String, reset_password_code: String, password: String, reset_method: String, completion: @escaping userCompletion) {
        print("Reset Password Code: \(reset_password_code)")
        Loader.shared.request(with: URLs.resetPassword, and: .patch, and: ["name": phoneNumber, "reset_password_code": reset_password_code, "password": password, "reset_method": reset_method]) { (data, success, error) in
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                print("New Password: \(password)")
                let user = User(data["user"])
                SavedUser.saveUser(user)
                print(user)
                completion(user, true, nil)
            }
        }
    }
    
    
    func completeRegistraion(apiToken: String, firstname: String, lastname: String, countryId: Int, cityId: Int, bankId: Int, bankNumber: String, completion: @escaping userCompletion) {
        Loader.shared.request(with: URLs.updateProfile, and: .patch, and: ["api_token": apiToken, "first_name": firstname, "last_name": lastname, "country_id": countryId, "city_id": cityId, "bank_id": bankId, "bank_number": bankNumber]) { (data, success, error) in
            
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                //print("New Password: \(password)")
                let user = User(data["user"])
                SavedUser.saveUser(user)
                print(user)
                completion(user, true, nil)
            }
            
        }
    }
    
    
    //TEST THIS FUNCTION AGAIN ITS NOT WORKING!!!!
    func completeRegistrationAsDriver(apiToken: String, firstname: String, lastname: String, countryId: Int, cityId: Int, bankId: Int, bankNumber: String, nationalIdImage: String, vechileRegImage: String, drivingLicenseimage: String, criminalRecordImage: String, completion: @escaping userCompletion) {
        Loader.shared.request(with: URLs.updateProfile, and: .patch, and: ["api_token": apiToken, "first_name": firstname, "last_name": lastname, "country_id": countryId, "city_id": cityId, "bank_id": bankId, "bank_number": bankNumber, "national_identity": nationalIdImage, "driving_license": drivingLicenseimage, "vehicle_registration": vechileRegImage, "clearance_criminal": criminalRecordImage]) { (data, success, error) in
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                //print("New Password: \(password)")
                let user = User(data["user"])
                SavedUser.saveUser(user)
                print(user)
                completion(user, true, nil)
            }
            
        }
    }
    
    
//    func getCountryDataForOrder(apiToken: String, completion: @escaping countryCompletion) {
//        Loader.shared.request(with: URLs.getDataForOrder, and: .get, and: ["api_token": apiToken]) { (data, success, error) in
//            if let error = error {
//                if let array = error["errors"].array {
//                    if let firstError = array.first!["message"].string {
//                        //completion(nil, false, firstError)
//                    }
//                }
//                return
//            }
//            if let data = data {
//                let orderData = data
//                let countries = orderData["countries"].map{Country($0.1)} ?? []
//                let insideWeights = orderData["inside_weights"]
//                let outsideWeights = orderData["outside_weights"]
//                let internationalWeights = orderData["international_weights"]
//                completion(countries, true, nil)
//            }
//        }
//    }
    
    func getRequiredDataToMakeOrder(apiToken: String, completion: @escaping orderDataCompletion) {
        Loader.shared.requestFromLoader(with: URLs.getDataForOrder, and: .get, and:  ["api_token": apiToken]) { (error, json) in
            if let error = error {
                print(error)
            }
            if let json = json {
                print(json)
                let orderData = OrderData(with: json)
                completion(orderData, false, nil)
            }
            
        }
    }
        
        
//
//        (with: URLs.getDataForOrder, and: .get, and:) { (data, success, error) in
//            if let error = error {
//                if let array = error["errors"].array {
//                    if let firstError = array.first!["message"].string {
//                        completion(nil, false, firstError)
//                    }
//                }
//                return
//            }
//            if let data = data {
//                print(data)
//                let orderData = OrderData(data)
//                completion(orderData, true, nil)
////                let counties = data["countries"].map{Country($0.1)} ?? []
////                let insideWeight = data["inside_weights"].map{InsideWeight($0.1)} ?? []
////                let outsideWeight = data["outside_weights"].map{OutsideWeight($0.1)} ?? []
////                completion(counties, insideWeight, outsideWeight, true, nil)
//            }
//        }
//
//    }
    
    func getRequiredDataToCreateAddress(apiToken: String, completion: @escaping addressDataCompletion) {
        Loader.shared.request(with: URLs.getDataForAddress, and: .get, and: ["api_token": apiToken]) { (data, success, error) in
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                print(data)
                let addressData = AddressData(data)
                completion(addressData, true, nil)
                //                let counties = data["countries"].map{Country($0.1)} ?? []
                //                let insideWeight = data["inside_weights"].map{InsideWeight($0.1)} ?? []
                //                let outsideWeight = data["outside_weights"].map{OutsideWeight($0.1)} ?? []
                //                completion(counties, insideWeight, outsideWeight, true, nil)
            }
        }
    }
    
    
    func addPickupAddress(apiToken: String, name: String, phone: String, countryId: Int, cityId: Int, regionId: Int, type: Int, latitude: String, longtude: String, saveToUser: Int, completion: @escaping oneAddressCompletion) {
        print("INSIDE ADD AUTH API")
        Loader.shared.request(with: URLs.addAddress, and: .post, and: ["api_token": apiToken, "name": name, "phone": phone, "country_id": countryId, "city_id": cityId, "region_id": regionId, "type": type, "latitude": latitude, "longitude": longtude, "save_to_user": saveToUser]) { (data, success, error) in
            print("REQUEST DATA")
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        print("ERRORRRR" , firstError)
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                let address = Address(data["data"])
                print(address)
                completion(address, true, "")
            }
        }
    }
    
    func addDestinationAddress(apiToken: String, name: String, phoneNumber: String, countryId: Int, cityId: Int, regionId: Int, type: Int, neighborhood: String, saveToUser: Int, completion: @escaping oneAddressCompletion) {
        print("INSIDE ADD AUTH API")
        Loader.shared.request(with: URLs.addAddress, and: .post, and: ["api_token": apiToken, "name": name, "phone": phoneNumber, "country_id": countryId, "city_id": cityId, "region_id": regionId, "type": type, "neighborhood": neighborhood, "save_to_user": saveToUser]) { (data, success, error) in
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        print("ERRORRRR" , firstError)
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                let address = Address(data["data"])
                print(address)
                completion(address, true, "")
            }
        }
    }
    
    func getPickUpAddresses(apiToken: String, completion: @escaping addressCompletion) {
        Loader.shared.request(with: URLs.getAddresses, and: .get, and: ["api_token": apiToken]) { (data, success, error) in
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                let pickupLocations = data["pickup_locations"].map{Address($0.1)} ?? []
                print(pickupLocations.count)
                //print(shipmentLocations[0])
                completion(pickupLocations, true, nil)
            }
        }
    }
    
    func getDestinationAddresses(apiToken: String, completion: @escaping addressCompletion) {
        Loader.shared.request(with: URLs.getAddresses, and: .get, and: ["api_token": apiToken]) { (data, success, error) in
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        completion(nil, false, firstError)
                    }
                }
                return
            }
            if let data = data {
                let shipmentLocations = data["shipment_locations"].map{Address($0.1)} ?? []
                print(shipmentLocations.count)
                //print(shipmentLocations[0])
                completion(shipmentLocations, true, nil)
            }
        }
    }
    
    //Make an Order
    func addNewOrder(apiToken: String, shippingDestination: Int, description: String, image: String, pickupType: Int, pickupDate: String, pickupTime: String, requestOptions: Int, senderPhone: String, paymentMethod: Int, shipmentCollection: Int, shipmentValue: String, packing: Int, destinationAddressId: Int, pickupAddressId: Int, orderWeight: String, WeightPrice: String, actualWeight:String, couponCode: String, recipientName: String, recipientPhone: String, itemPrice: String, totalPrice: String, completion: @escaping orderCompletion) {
        print("INSDIE API")
        let parameters = [
            "api_token": apiToken,
            "shipping_destination": shippingDestination,
            "description": description,
            "image": image,
            "pickup_time": pickupType,
            "date": pickupDate,
            "time": pickupTime,
            "request_option": requestOptions,
            "sender_phone": senderPhone,
            "payment_option": paymentMethod,
            "shipment_collection": shipmentCollection,
            "shipment_value": shipmentValue,
            "packaging": packing,
            "address_id": destinationAddressId,
            "pickup_address_id": pickupAddressId,
            "order_weight": orderWeight,
            "weight_price": WeightPrice,
            "actual_weight": actualWeight,
            "coupon_code": couponCode,
            "recipient_name": recipientName,
            "recipient_phone": recipientPhone,
            "item_price": itemPrice,
            "total_price": totalPrice
            ] as [String : Any]
        Loader.shared.request(with: URLs.addNewOrder, and: .post, and: parameters) { (data, success, error) in
            print("\(URLs.addNewOrder)?\(parameters)")
            print("TESTING")
            print(data)
            if let error = error {
                if let array = error["errors"].array {
                    if let firstError = array.first!["message"].string {
                        print("ERRORRRR" , firstError)
                    }
                }
                return
            }
            if let data = data {
                let order = Order(data["data"])
                print("ORDER", data)
                completion(order, true, "")
            }
            
        }
        
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}

