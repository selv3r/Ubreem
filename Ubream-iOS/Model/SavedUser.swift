//
//  SavedUser.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/19/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import Foundation

class SavedUser {
    
    private static let UserKey = "User"
    private static let DriverKey = "Driver"
    
    private static func archiveUser(_ user :User) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: user as User) as NSData
    }
    
    private static func archiveDriver(_ driver: Driver) -> NSData {
        return NSKeyedArchiver.archivedData(withRootObject: driver as Driver) as NSData
    }
    
    static func loadUser() -> User? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: UserKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? User
        }
        return nil
    }
    
    static func loadDriver() -> Driver? {
        if let unarchivedObject = UserDefaults.standard.object(forKey: DriverKey) as? Data {
            return NSKeyedUnarchiver.unarchiveObject(with: unarchivedObject as Data) as? Driver
        }
        return nil
    }
    
    static func saveUser(_ user : User?) {
        let archivedObject = archiveUser(user!)
        UserDefaults.standard.set(archivedObject, forKey: UserKey)
        UserDefaults.standard.synchronize()
    }
    
    static func saveDriver(_ driver: Driver?) {
        let archivedObject = archiveDriver(driver!)
        UserDefaults.standard.set(archivedObject, forKey: DriverKey)
        UserDefaults.standard.synchronize()
    }
    
    static func removeUser() {
        UserDefaults.standard.removeObject(forKey: UserKey)
        UserDefaults.standard.synchronize()
    }
    
    static func removeDriver() {
        UserDefaults.standard.removeObject(forKey: DriverKey)
        UserDefaults.standard.synchronize()
    }
    
    
    
}
