//
//  Address.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class Address {
    var subThoroughfare: String
    var thoroughfare: String
    var locality: String
    var postalCode: String
    var country: String
    var x: String
    var y: String
    
    init(subThoroughfare: String, thoroughfare: String, locality: String, postalCode: String, country: String, x: String, y: String) {
        self.subThoroughfare = subThoroughfare
        self.thoroughfare = thoroughfare
        self.locality = locality
        self.postalCode = postalCode
        self.country = country
        self.x = x
        self.y = y
    }
}
