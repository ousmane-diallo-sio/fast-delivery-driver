//
//  Photo.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class Photo {
    var _id: String
    var date: Date
    var photo: PhotoData
    var trackingId: String
    
    init(_id: String, date: Date, photo: PhotoData, trackingId: String) {
        self._id = _id
        self.date = date
        self.photo = photo
        self.trackingId = trackingId
    }
}
