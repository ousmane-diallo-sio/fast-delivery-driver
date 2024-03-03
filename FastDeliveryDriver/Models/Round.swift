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
    
    init(date: Date, deliveries: [Delivery]) {
        self.date = date
        self.deliveries = deliveries
    }
}
