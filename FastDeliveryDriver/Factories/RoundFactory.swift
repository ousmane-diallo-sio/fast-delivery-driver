//
//  RoundFactory.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class RoundFactory {
    
    class func roundFromJSON(from data: [String: Any]) -> Round? {
        guard let dateString = data["date"] as? String,
              let deliveriesData = data["deliveries"] as? [[String: Any]] else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        let deliveries = deliveriesData.compactMap { deliveryData in
            return DeliveryFactory.deliveryFromJSON(from: deliveryData)
        }
        
        //print("RoundFactory::roundFromJSON deliveriesData : \(deliveriesData)")
        //print("RoundFactory::roundFromJSON deliveries : \(deliveries)")
        
        return Round(date: date, deliveries: deliveries)
    }
    
    class func roundsFromJSON(from arr: [ [String: Any] ]) -> [Round] {
        return arr.compactMap{ dict in
            return roundFromJSON(from: dict)
        }
    }
}
