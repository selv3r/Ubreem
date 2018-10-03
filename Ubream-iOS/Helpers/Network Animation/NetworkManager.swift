//
//  NetworkManager.swift
//  Re7la
//
//  Created by Mina Gad on 3/5/18.
//  Copyright © 2018 Mina Gad. All rights reserved.
//

import Foundation
import Alamofire

class NetworkManager {
    
    static let shared = NetworkManager()
    
    var connected = false
    let reachabilityManager = Alamofire.NetworkReachabilityManager()
    
    func startNetworkReachabilityObserver() {
        reachabilityManager?.listener = { status in
            switch status {
            case .notReachable:
                print("The network is not reachable")
                self.connected = false
                NotificationCenter.default.post(name: .StatusChanged, object: self, userInfo: ["status": self.connected])
                
            case .unknown :
                print("It is unknown whether the network is reachable")
                self.connected = false
                NotificationCenter.default.post(name: .StatusChanged, object: self, userInfo: ["status": self.connected])
                
            case .reachable(.ethernetOrWiFi):
                print("The network is reachable over the WiFi connection")
                self.connected = true
                //                NotificationCenter.default.post(name: .StatusChanged, object: self, userInfo: ["status": self.connected])
                
            case .reachable(.wwan):
                print("The network is reachable over the WWAN connection")
                self.connected = true
                //                NotificationCenter.default.post(name: .StatusChanged, object: self, userInfo: ["status": self.connected])
                
            }
        }
        // start listening
        reachabilityManager?.startListening()
    }
    
    func removeNetworkReachability() {
        reachabilityManager?.stopListening()
    }
    
    
    
    
}
