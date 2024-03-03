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
              let dateString = photoData["date"] as? String,
              let photoContentData = photoData["photo"] as? [String: Any],
              let dateString = photoData["date"] as? String,
              let contentType = photoData["contentType"] as? String,
              let trackingId = photoData["trackingId"] as? String else {
            return nil
        }
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: dateString) else {
            return nil
        }
        
        guard let buffer = photoContentData["data"] as? String else {
            return nil
        }
        
        let _photoData = PhotoData(data: buffer, contentType: contentType)
        return Photo(date: date, photo: _photoData, trackingId: trackingId)
    }
}
