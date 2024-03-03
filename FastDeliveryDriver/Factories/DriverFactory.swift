//
//  DriverFactory.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class DriverFactory {
    
    class func driverFromJSON(data: [String: Any]) -> Driver? {
        guard let firstName = data["firstName"] as? String,
              let lastName = data["lastName"] as? String,
              let email = data["email"] as? String,
              let phoneNumber = data["phoneNumber"] as? String,
              let role = data["role"] as? String else {
            return nil
        }
        
        let password = data["password"] as? String
        
        return Driver(
        firstName: firstName,
          lastName: lastName,
          email: email,
          password: password,
          phoneNumber: phoneNumber,
          role: role
        )
    }
    
}
