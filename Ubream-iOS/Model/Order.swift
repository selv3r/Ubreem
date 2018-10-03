//
//  Order.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/26/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation
import SwiftyJSON

class Order: NSObject, NSCoding {
    
    var id: Int?
    var shippingDestination: Int?
    var orderDescription: String?
    var image: String?
    var pickupTime: Int?
    var date: String?
    var time: String?
    var requestOption: Int?
    var paymentOption: Int?
    var shipmentCollection: Int?
    var packaging: Int?
    var userId: Int?
    var addressId: Int?
    var pickupAddressId: Int?
    var weightId: Int?
    var shipmentType: Int?
    var orderWeight: String?
    var actualWeight: String?
    var senderPhone: String?
    var couponCode: String?
    var feesCollection: Int?
    var recipientName: String?
    var recipientPhone: String?
    var itemPrice: String?
    var totalPrice: String?
    var shipmentValue: String?
    var status: Int?
    var driverId: Int?
    var createdAt: String?
    var updatedAt: String?
    var user: User?
    var address: Address?
    var pickupAddress: Address?
    
    required init(_ data: JSON) {
        self.id = data["id"].int
        self.shippingDestination = data["shipping_destination"].int
        self.orderDescription = data["description"].string
        self.image = data["image"].string
        self.pickupTime = data["pickup_time"].int
        self.date = data["date"].string
        self.time = data["time"].string
        self.requestOption = data["request_option"].int
        self.paymentOption = data["payment_option"].int
        self.shipmentCollection = data["shipment_collection"].int
        self.packaging = data["packaging"].int
        self.userId = data["user_id"].int
        self.addressId = data["address_id"].int
        self.pickupAddressId = data["pickup_address_id"].int
        self.weightId = data["weight_id"].int
        self.shipmentType = data["shipment_type"].int
        self.orderWeight = data["order_weight"].string
        self.actualWeight = data["actual_weight"].string
        self.senderPhone = data["sender_phone"].string
        self.couponCode = data["coupon_code"].string
        self.feesCollection = data["fees_collection"].int
        self.recipientName = data["recipient_name"].string
        self.recipientPhone = data["recipient_phone"].string
        self.itemPrice = data["item_price"].string
        self.totalPrice = data["total_price"].string
        self.shipmentValue = data["shipment_value"].string
        self.status = data["status"].int
        self.driverId = data["driver_id"].int
        self.createdAt = data["created_at"].string
        self.updatedAt = data["updated_at"].string
        self.user = User(data["user"])
        self.address = Address(data["address"])
        self.pickupAddress = Address(data["pickup_address"])
    }
    
    required init(coder aDecoder: NSCoder) {
        id = aDecoder.decodeObject(forKey: "id") as? Int
        shippingDestination = aDecoder.decodeObject(forKey: "shipping_destination") as? Int
        orderDescription = aDecoder.decodeObject(forKey: "description") as? String
        image = aDecoder.decodeObject(forKey: "image") as? String
        pickupTime = aDecoder.decodeObject(forKey: "pickup_time") as? Int
        date = aDecoder.decodeObject(forKey: "date") as? String
        time = aDecoder.decodeObject(forKey: "time") as? String
        requestOption = aDecoder.decodeObject(forKey: "request_option") as? Int
        paymentOption = aDecoder.decodeObject(forKey: "payment_option") as? Int
        shipmentCollection = aDecoder.decodeObject(forKey: "shipment_collection") as? Int
        packaging = aDecoder.decodeObject(forKey: "packaging") as? Int
        userId = aDecoder.decodeObject(forKey: "user_id") as? Int
        addressId = aDecoder.decodeObject(forKey: "address_id") as? Int
        pickupAddressId = aDecoder.decodeObject(forKey: "pickup_address_id") as? Int
        weightId = aDecoder.decodeObject(forKey: "weight_id") as? Int
        shipmentType = aDecoder.decodeObject(forKey: "shipment_type") as? Int
        orderWeight = aDecoder.decodeObject(forKey: "order_weight") as? String
        actualWeight = aDecoder.decodeObject(forKey: "actual_weight") as? String
        senderPhone = aDecoder.decodeObject(forKey: "sender_phone") as? String
        couponCode = aDecoder.decodeObject(forKey: "coupon_code") as? String
        feesCollection = aDecoder.decodeObject(forKey: "fees_collection") as? Int
        recipientName = aDecoder.decodeObject(forKey: "recipient_name") as? String
        recipientPhone = aDecoder.decodeObject(forKey: "recipient_phone") as? String
        itemPrice = aDecoder.decodeObject(forKey: "item_price") as? String
        totalPrice = aDecoder.decodeObject(forKey: "total_price") as? String
        shipmentValue = aDecoder.decodeObject(forKey: "shipment_value") as? String
        status = aDecoder.decodeObject(forKey: "status") as? Int
        driverId = aDecoder.decodeObject(forKey: "driver_id") as? Int
        createdAt = aDecoder.decodeObject(forKey: "created_at") as? String
        updatedAt = aDecoder.decodeObject(forKey: "updated_at") as? String
        user = aDecoder.decodeObject(forKey: "user") as? User
        address = aDecoder.decodeObject(forKey: "address") as? Address
        pickupAddress = aDecoder.decodeObject(forKey: "pickup_address") as? Address
    }
    
    public func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: "id")
        aCoder.encode(shippingDestination, forKey: "shipping_destination")
        aCoder.encode(orderDescription, forKey: "description")
        aCoder.encode(image, forKey: "image")
        aCoder.encode(pickupTime, forKey: "pickup_time")
        aCoder.encode(date, forKey: "date")
        aCoder.encode(time, forKey: "time")
        aCoder.encode(requestOption, forKey: "request_option")
        aCoder.encode(paymentOption, forKey: "payment_option")
        aCoder.encode(shipmentCollection, forKey: "shipment_collection")
        aCoder.encode(packaging, forKey: "packaging")
        aCoder.encode(userId, forKey: "user_id")
        aCoder.encode(addressId, forKey: "address_id")
        aCoder.encode(pickupAddressId, forKey: "pickup_address_id")
        aCoder.encode(weightId, forKey: "weight_id")
        aCoder.encode(shipmentType, forKey: "shipment_type")
        aCoder.encode(orderWeight, forKey: "order_weight")
        aCoder.encode(actualWeight, forKey: "actual_weight")
        aCoder.encode(senderPhone, forKey: "sender_phone")
        aCoder.encode(couponCode, forKey: "coupon_code")
        aCoder.encode(feesCollection, forKey: "fees_collection")
        aCoder.encode(recipientName, forKey: "recipient_name")
        aCoder.encode(recipientPhone, forKey: "recipient_phone")
        aCoder.encode(itemPrice, forKey: "item_price")
        aCoder.encode(totalPrice, forKey: "total_price")
        aCoder.encode(shipmentValue, forKey: "shipment_value")
        aCoder.encode(status, forKey: "status")
        aCoder.encode(driverId, forKey: "driver_id")
        aCoder.encode(createdAt, forKey: "created_at")
        aCoder.encode(updatedAt, forKey: "updated_at")
        aCoder.encode(user, forKey: "user")
        aCoder.encode(address, forKey: "address")
        aCoder.encode(pickupAddress, forKey: "pickup_address")
    }
    
}
