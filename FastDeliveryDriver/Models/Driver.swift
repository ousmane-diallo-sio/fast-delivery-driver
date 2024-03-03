//
//  Driver.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class Driver {
    var firstName: String
    var lastName: String
    var email: String
    var password: String?
    var phoneNumber: String
    var role: String
    
    init(firstName: String, lastName: String, email: String, password: String? = nil, phoneNumber: String, role: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.role = role
    }
}
