//
//  PhotoData.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoData:Mappable {
    
    var id : String?
    var thumb: String?
    var full : String?
    var coverID: String?
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map){
        
        id <- map["id"]
        thumb <- map["cover_photo.urls.thumb"]
        full <- map["cover_photo.urls.full"]
        coverID<-map ["cover_photo.id"]
    }
}
