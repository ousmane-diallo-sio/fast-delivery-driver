//
//  DriverWebservices.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class DriverWebService {
    
    class func login(email: String, password: String, completion: @escaping (Driver?, Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/auth/driver/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let requestBody: [String: String] = [
            "email": email,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
        } catch {
            print("DriverWebservice::login \(error)")
            completion(nil, error)
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let _data = data else  {
                print("DriverWebservice::login \(error)")
                completion(nil, error)
                return
            }
                        
            let json = try? JSONSerialization.jsonObject(with: _data)
            guard let jsonUnwrapped = json as? [String: Any] else {
                completion(nil, NSError(domain: "com.example.driver", code: 1))
                return
            }
            
            guard let driverData = jsonUnwrapped["data"] as? [String: Any] else {
                completion(nil, NSError(domain: "com.example.driver", code: 2))
                return
            }
            
            print("DriverWebservice::login data : \(driverData)")
            
            let driver = DriverFactory.driverFromJSON(data: driverData)
            completion(driver, nil)
        }
        task.resume()
    }
}
