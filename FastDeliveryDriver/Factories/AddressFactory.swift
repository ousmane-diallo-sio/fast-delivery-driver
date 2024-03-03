//
//  AddressFactory.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 03/03/2024.
//

import Foundation

import Foundation

class AddressFactory {
    
    class func addressFromJSON(from data: [String: Any]) -> Address? {
        guard let subThoroughfare = data["subThoroughfare"] as? String,
              let thoroughfare = data["thoroughfare"] as? String,
              let locality = data["locality"] as? String,
              let postalCode = data["postalCode"] as? String,
              let x = data["x"] as? String,
              let y = data["y"] as? String,
              let country = data["country"] as? String else {
            print("AddressFactory::addressFromJSON Failed to parse data")
            return nil
        }
        
        return Address(
            subThoroughfare: subThoroughfare,
            thoroughfare: thoroughfare,
            locality: locality,
            postalCode: postalCode,
            country: country,
            x: x,
            y: y
        )
    }
}
