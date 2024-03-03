//
//  DeliveryWebservice.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 03/03/2024.
//

import Foundation

class DeliveryWebService {
    
    class func updateDelivery(withID id: String, photoId: String, completion: @escaping (Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/delivery/\(id)")!
        
        print("url", url)
        
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let payload: [String: Any] = ["photo": photoId]
        
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: payload)
            print("jsonData \(jsonData)")
            request.httpBody = jsonData
        } catch {
            print("DeliveryWebService::updateDelivery error with JSON serialization")
            completion(error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            print("urlsession response")
            guard error == nil else  {
                print("DeliveryWebService::updateDeliveryPhoto error: \(error)")
                completion(error)
                return
            }
                        
            completion(nil)
        }
        task.resume()
    }
}

