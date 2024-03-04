//
//  Round.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class Round {
    var date: Date
    var deliveries: [Delivery]
    var driver: Driver
    
    init(date: Date, deliveries: [Delivery], driver: Driver) {
        self.date = date
        self.deliveries = deliveries
        self.driver = driver
    }
}
