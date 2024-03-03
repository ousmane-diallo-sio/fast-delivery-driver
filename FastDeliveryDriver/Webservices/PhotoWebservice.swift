//
//  PhotoWebservice.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 03/03/2024.
//

import Foundation

class PhotoWebService {
    
    class func uploadPhoto(trackingId: String, date: Date, photo: String, completion: @escaping (Photo?, Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/photo/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = [.withInternetDateTime]
        let isoDateString = dateFormatter.string(from: date)
        
        let requestBody: [String: Any] = [
            "trackingId": trackingId,
            "date": isoDateString,
            "photo": photo
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("PhotoWebService::uploadPhoto \(error)")
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let _data = data else  {
                print("PhotoWebService::uploadPhoto \(error)")
                completion(nil, error)
                return
            }
                        
            let json = try? JSONSerialization.jsonObject(with: _data)
            guard let jsonUnwrapped = json as? [String: Any] else {
                completion(nil, NSError(domain: "com.example.photo", code: 1))
                return
            }
            
            guard let photoData = jsonUnwrapped["data"] as? [String: Any] else {
                completion(nil, NSError(domain: "com.example.photo", code: 2))
                return
            }
                        
            let photo = PhotoFactory.photoFromJSON(from: photoData)
            completion(photo, nil)
        }
        task.resume()
    }
}

