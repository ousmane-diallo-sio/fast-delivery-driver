//
//  PhotoFactory.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 03/03/2024.
//

import Foundation

class PhotoFactory {
    
    class func photoFromJSON(from data: [String: Any]?) -> Photo? {
            
        guard let photoData = data,
              let id = photoData["_id"] as? String,
              let dateString = photoData["date"] as? String,
              let photoContentData = photoData["photo"] as? [String: Any],
              let trackingId = photoData["trackingId"] as? String else {
            print("PhotoFactory::photoFromJSON Failed to parse data")
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateString) else {
            print("PhotoFactory::photoFromJSON Failed to parse date")
            return nil
        }
        
        guard let buffer = photoContentData["data"] as? String,
              let contentType = photoContentData["contentType"] as? String else {
            print("PhotoFactory::photoFromJSON Failed to parse buffer")
            return nil
        }
        
        let _photoData = PhotoData(data: buffer, contentType: contentType)
        print("photoData parsed id : \(id)")
        return Photo(_id: id, date: date, photo: _photoData, trackingId: trackingId)
    }
}
