//
//  MapsHelper.swift
//  events
//
//  Created by Mina Shehata on 2/13/18.
//  Copyright © 2018 Mina Shehata. All rights reserved.
//

import Foundation
import UIKit
import MapKit

class MapsHelper {
    static var instance = MapsHelper()
    
    func showActionSheet(fromLatitude:Double? , fromLongitude:Double? ,toLatitude:Double , toLongitude:Double) {
        
        let alertController = UIApplication.topViewController()?.alertViewController("", dismissCompletion: nil)
        // Create Google Action
        let googleAction = UIApplication.topViewController()?.defaultAlertAction("Google Map".Localize) { (action) in
            self.onGoogleMap(fromLatitude: fromLatitude , fromLongitude: fromLongitude , toLatitude: toLatitude , toLongitude: toLongitude)
            
        }
        // Create Apple Action
        let appleAction = UIApplication.topViewController()?.defaultAlertAction("Apple Map".Localize) { (action) in
            self.onAppleMap(fromLatitude: fromLatitude , fromLongitude: fromLongitude , toLatitude:toLatitude , toLongitude:toLongitude)
            
        }
        // Create Cancel Action
        let cancelAction = UIApplication.topViewController()?.cancelAlertAction()
        // Add Action Button Into Alert
        alertController?.addAction(googleAction)
        alertController?.addAction(appleAction)
        // Add Action Button Into Alert
        alertController?.addAction(cancelAction)
        // Present Alert View Controller
        UIApplication.topViewController()?.present(alertController!, animated: true, completion: nil)
        
    }
    
    func onGoogleMap(fromLatitude:Double? , fromLongitude:Double? ,toLatitude:Double , toLongitude:Double)  {
        var link = ""
        if fromLatitude != nil {
            link = "comgooglemaps://?saddr=\(fromLatitude!),\(fromLongitude!)&daddr=\(toLatitude),\(toLongitude)&directionsmode=driving"
        }else{
            link = "comgooglemaps://?saddr=&daddr=\(toLatitude),\(toLongitude)&directionsmode=driving"
        }
        //Working in Swift new versions.
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!))
        {
            UIApplication.shared.open(NSURL(string:
                link)! as URL, options: [:], completionHandler: nil)
        } else{
            // open google map on Store
            UIApplication.shared.open(NSURL(string: "itms://itunes.apple.com/us/app/google-maps/id585027354?mt=8&uo=4")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    func onAppleMap(fromLatitude: Double? , fromLongitude: Double? ,toLatitude: Double , toLongitude: Double) {
        
        var link = ""
        
        if fromLatitude != nil {
            link = "http://maps.apple.com/?saddr=\(fromLatitude!),\(fromLongitude!)&daddr=\(toLatitude),\(toLongitude)"
        }else{
            link = "http://maps.apple.com/?saddr=&daddr=\(toLatitude),\(toLongitude)"
        }
        //Working in Swift new versions.
        UIApplication.shared.open(NSURL(string:
            link)! as URL, options: [:], completionHandler: nil)
        
        //NSURL(string:"http://maps.apple.com/?saddr=\(currentLat),\(currentLong)&daddr=\(destinationLat),\(destinationLong)")!
        //
        //        let lat: CLLocationDegrees = CLLocationDegrees(toLatitude)
        //        let long: CLLocationDegrees = CLLocationDegrees(toLongitude)
        //
        //        let regionDistance:CLLocationDistance = 10000
        //        let coordinates = CLLocationCoordinate2DMake(lat, long)
        //        let regionSpan = MKCoordinateRegionMakeWithDistance(coordinates, regionDistance, regionDistance)
        //        let options = [
        //            MKLaunchOptionsMapCenterKey: NSValue(mkCoordinate: regionSpan.center),
        //            MKLaunchOptionsMapSpanKey: NSValue(mkCoordinateSpan: regionSpan.span)
        //        ]
        //        let placemark = MKPlacemark(coordinate: coordinates, addressDictionary: nil)
        //        let mapItem = MKMapItem(placemark: placemark)
        //        mapItem.name = "Place Name"
        //        mapItem.openInMaps(launchOptions: options)
    }
    
    
}
