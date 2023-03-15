//
//  GeocodingService.swift
//  meteo_app
//
//  Created by mohammed ichou on 11/03/2023.
//

import Foundation
import CoreLocation

class GeocodingService {
    
    static let shared = GeocodingService()
    
    func forwardGeocoding(address: String, _ onSuccess: @escaping(CLLocationCoordinate2D) -> Void, onFailure: @escaping(Error) -> Void) {
            let geocoder = CLGeocoder()
            geocoder.geocodeAddressString(address, completionHandler: { (placemarks, error) in
                if error != nil {
                    print("Failed to retrieve location")
                    return
                }
                
                var location: CLLocation?
                
                if let placemarks = placemarks, placemarks.count > 0 {
                    location = placemarks.first?.location
                }
                
                if let location = location {
                    let coordinate = location.coordinate
                    print("\nlat: \(coordinate.latitude), long: \(coordinate.longitude)")
                    onSuccess(location.coordinate)
                }
                else
                {
                    print("No Matching Location Found")
                }
            })
        }
    
}
