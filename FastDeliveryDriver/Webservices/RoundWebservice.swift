//
//  RoundWebservice.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class RoundWebService {
    
    class func getAllRounds(completion: @escaping ([Round], Error?) -> Void) {
        let url = URL(string: "http://localhost:3000/round/")!
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard error == nil, let _data = data else  {
                print("RoundWebService::getAllRounds \(error)")
                completion([], error)
                return
            }
                        
            let json = try? JSONSerialization.jsonObject(with: _data)
            guard let jsonUnwrapped = json as? [[String: Any]] else {
                completion([], NSError(domain: "com.example.driver", code: 1))
                return
            }
                                   
            var rounds = RoundFactory.roundsFromJSON(from: jsonUnwrapped)
                        
            print("RoundWebservice::getAllRounds rounds count : \(rounds.count)")
            
            rounds.forEach { round in
                round.deliveries = round.deliveries.filter { delivery in
                    delivery.photo == nil
                }
            }

            rounds = rounds.filter { round in
                round.deliveries.isEmpty == false
            }
            completion(rounds, nil)
        }
        task.resume()
    }
}
