//
//  LocationDecoder.swift
//  OnWheels
//
//  Created by Veronika on 09.04.2023.
//

import Foundation
import CoreLocation
import MapKit

class LocationDecoder {
    func getLocation(from address: String, completion: @escaping (Location?, Error?) -> Void) {
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(address) { placemarks, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let placemark = placemarks?.first else {
                completion(nil, nil)
                return
            }
            
            guard let latitude = placemark.location?.coordinate.latitude,
                  let longitude = placemark.location?.coordinate.longitude else {
                      return
                  }
            
            let location = Location(latitude: latitude,
                                    longitude: longitude)
            completion(location, nil)
        }
    }
}
