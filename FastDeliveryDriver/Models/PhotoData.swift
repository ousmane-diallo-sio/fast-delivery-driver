//
//  PhotoData.swift
//  FastDeliveryDriver
//
//  Created by Ousmane Diallo on 02/03/2024.
//

import Foundation

class PhotoData : Codable {
    var data: String
    var contentType: String
    
    init(data: String, contentType: String) {
        self.data = data
        self.contentType = contentType
    }
}
