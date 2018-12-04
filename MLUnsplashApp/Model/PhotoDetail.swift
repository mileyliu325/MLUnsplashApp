//
//  PhotoDetail.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation
import ObjectMapper

class PhotoDetail:Mappable {
    
    var id : String?
    var views: Int?
    var downloads : Int?
    var description :String?
    var created: String?
    var full: String?
    var likes:Int?
    var width:Int?
    var height:Int?
    
    
    required init?(map: Map) {
        
    }
    func mapping(map: Map){
        
        id <- map["id"]
        views <- map["views"]
        downloads <- map["downlaods"]
        description<-map["description"]
        created<-map["created_at"]
        full<-map["urls.full"]
        width<-map["width"]
        height<-map["height"]
        likes<-map["likes"]
        
    }
    
}
