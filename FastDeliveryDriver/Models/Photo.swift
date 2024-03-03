//
//  Photo.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class Photo {
    var date: Date
    var photo: PhotoData
    var trackingId: String
    
    init(date: Date, photo: PhotoData, trackingId: String) {
        self.date = date
        self.photo = photo
        self.trackingId = trackingId
    }
}
