//
//  LocationExtension.swift
//  OnWheels
//
//  Created by Veronika on 27.12.2022.
//

import Foundation
import MapKit
//import PlaygroundSupport
//PlaygroundPage.current.needsIndefiniteExecution = true

extension CLLocation {
    func fetchCityAndCountry(completion: @escaping (_ city: String?, _ country:  String?, _ error: Error?) -> ()) {
        CLGeocoder().reverseGeocodeLocation(self) { completion($0?.first?.locality, $0?.first?.country, $1) }
    }
}
