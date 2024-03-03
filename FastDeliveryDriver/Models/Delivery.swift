//
//  Delivery.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation
import MapKit

class Delivery {
    var _id: String
    var photo: Photo?
    var customer: Customer
    
    init(_id: String, photo: Photo? = nil, customer: Customer) {
        self._id = _id
        self.photo = photo
        self.customer = customer
    }
}

class DeliveryAnnotation: MKPointAnnotation {
    
    var delivery: Delivery
    
    init(delivery: Delivery) {
        self.delivery = delivery
        super.init()
        self.title = delivery.customer.address.thoroughfare
        self.subtitle = "\(delivery.customer.address.postalCode)"
        let address = delivery.customer.address
        self.coordinate = CLLocationCoordinate2D(latitude: Double(address.x)!, longitude: Double(address.y)!)
    }
}
