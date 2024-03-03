//
//  CustomerFactory.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 03/03/2024.
//

import Foundation

class CustomerFactory {
    
    class func customerFromJSON(from data: [String: Any]) -> Customer? {
        guard let firstName = data["firstName"] as? String,
              let lastName = data["lastName"] as? String,
              let email = data["email"] as? String,
              let phoneNumber = data["phoneNumber"] as? String,
              let role = data["role"] as? String,
              let addressData = data["address"] as? [String: Any],
              let address = AddressFactory.addressFromJSON(from: addressData) else {
            print("CustomerFactory::customerFromJSON Failed to parse data")
            return nil
        }
        
        let password = data["password"] as? String
        return Customer(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            phoneNumber: phoneNumber,
            address: address,
            role: role
        )
    }
}
