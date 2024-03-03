//
//  DeliveryFactory.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 03/03/2024.
//

import Foundation

class DeliveryFactory {
    
    class func deliveryFromJSON(from data: [String: Any]) -> Delivery? {
        guard let id = data["_id"] as? String,
              let customerData = data["customer"] as? [String: Any],
              let customer = CustomerFactory.customerFromJSON(from: customerData) else {
            print("DeliveryFactory::deliveryFromJSON Failed to parse data")
            return nil
        }
        
        let photoData = data["photo"] as? [String: Any]
        print("photoData == nil \(photoData == nil)")
        let photo = photoData != nil ? PhotoFactory.photoFromJSON(from: photoData!) : nil
        
        print("DeliveryFactory::deliveryFromJSON customer : ", customer)
        print("DeliveryFactory::deliveryFromJSON photo : ", photo)
        
        return Delivery(_id: id, photo: photo, customer: customer)
    }
    
    class func deliveriesFromJSON(from arr: [[String: Any]]) -> [Delivery] {
        return arr.compactMap { dict in
            return deliveryFromJSON(from: dict)
        }
    }
}
