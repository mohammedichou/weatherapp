//
//  LocationService.swift
//  meteo_app
//
//  Created by mohammed ichou on 09/03/2023.
//

import Foundation
import CoreLocation

class LocationService: NSObject, CLLocationManagerDelegate{
    
    static let shared = LocationService()
    let locationManager = CLLocationManager()
    var currentlocation : CLLocation?
    
    func initlocation(){
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        
    }
    
    func getcurrentlocation()->CLLocation?{
        return currentlocation
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first{
            currentlocation = location
        }
        
    }
    
}
