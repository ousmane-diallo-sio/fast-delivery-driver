//
//  Customer.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class Customer {
    var firstName: String
    var lastName: String
    var email: String
    var password: String?
    var phoneNumber: String
    var address: Address
    var role: String
    
    init(firstName: String, lastName: String, email: String, password: String? = nil, phoneNumber: String, address: Address, role: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
        self.password = password
        self.phoneNumber = phoneNumber
        self.address = address
        self.role = role
    }
}
