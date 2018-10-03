//
//  NotificationName+Extension.swift
//  Re7la
//
//  Created by Mina Gad on 3/29/18.
//  Copyright © 2018 Mina Gad. All rights reserved.
//

import Foundation

extension Notification.Name {
    static let StatusChanged = Notification.Name(rawValue: "StatusChanged")
    static let filterData = Notification.Name(rawValue: "filterData")
    static let connectSocket = Notification.Name("connectSocket")
    static let carAdded = Notification.Name("carAdded")
    static let OpenNotification = Notification.Name("OpenNotification")

}
