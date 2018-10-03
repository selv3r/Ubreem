//
//  MapVC.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/24/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import MapKit

protocol UserDidSelectCoordinatesProtocol {
    func getUserCoordinates(lat: String, long: String)
}

class MapVC: UIViewController, UIGestureRecognizerDelegate {
    
    
    @IBOutlet weak var map: MKMapView!
    
    var locationManager = CLLocationManager()
    let authorizationStatus = CLLocationManager.authorizationStatus()
    let regionRadius: Double = 1000
    let newPin = MKPointAnnotation()
    
//    let reverseGeoCoder = CLGeocoder()
//    var coordinate = "Converted Address Goes Here"
    
    var delegate: UserDidSelectCoordinatesProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        map.delegate = self
        locationManager.delegate = self
        
        configureLocationServices()
    }
    
    func setupUI() {
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.requestAlwaysAuthorization()
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.startUpdatingLocation()
        }
        
        
    }
    
    @IBAction func centerMapButtonPressed(_ sender: Any) {
        if authorizationStatus == .authorizedAlways || authorizationStatus == .authorizedWhenInUse {
            centerMapOnUserLocation()
        }
    }
    
    func centerMapOnUserLocation() {
        guard let coordinate = locationManager.location?.coordinate else { return }
        let lat = String(format: "%f", coordinate.latitude)
        let long = String(format: "%f", coordinate.longitude)
        delegate?.getUserCoordinates(lat: lat, long: long)
        let coordinateRegion = MKCoordinateRegionMakeWithDistance(coordinate, regionRadius * 2.0, regionRadius * 2.0)
        print("BUTTON PRESSED")
        print(lat, long)
        map.setRegion(coordinateRegion, animated: true)
    }


}



extension MapVC: MKMapViewDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        map.removeAnnotation(newPin)
        
        let location = locations.last! as CLLocation
        
        let center = CLLocationCoordinate2D(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01))
        
        //set region on the map
        map.setRegion(region, animated: true)
        
        newPin.coordinate = location.coordinate
        map.addAnnotation(newPin)
        
    }
    
    
}


extension MapVC: CLLocationManagerDelegate {
    
    //Check to see if app is Authorized to use Location! and ask for authorization
    func configureLocationServices() {
        if authorizationStatus == .notDetermined {
            locationManager.requestAlwaysAuthorization()
        } else {
            return
        }
    }
    
    //center the maps on location when it loads
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        centerMapOnUserLocation()
    }
    
    //Convert Long and Lat into Location
    
    
    
}



















