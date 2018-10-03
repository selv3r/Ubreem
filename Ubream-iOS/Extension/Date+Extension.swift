//
//  Date+Extension.swift
//  aman-user-ios
//
//  Created by Mina Shehata Gad on 5/12/18.
//  Copyright © 2018 Mina Shehata Gad. All rights reserved.
//

import Foundation


extension Date {
    
    var toString : String {
        get{
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: self)
            // convert your string to date
            let yourDate = formatter.date(from: myString)
            //then again set the date format whhich type of output you need
            formatter.dateFormat = "yyyy-MM-dd"
            // again convert your date to string
            let myStringafd = formatter.string(from: yourDate!)
            return myStringafd
        }
    }
    
    var toTimestampString : String {
        get {
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            let myString = formatter.string(from: self)
            return myString
        }
    }
    
    var timeString : String {
        get{
            let formatter = DateFormatter()
            // initially set the format based on your datepicker date
            formatter.timeStyle = .short
            let myString = formatter.string(from: self)
            return myString
        }
    }
    
    
}

extension TimeInterval {
    func creatDateFromTimeInterval() -> Date {
        let date = NSDate(timeIntervalSince1970: self)
        return date as Date
    }
}





















