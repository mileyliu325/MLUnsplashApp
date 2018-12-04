//
//  API.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation

struct API {
    static let ACCESS_KEY = "95f7082d453e177f4c98fbd99e7df1b975a3f0a8c3acae58941353fa9cd3ae7c"
    static let publicAuth = "?client_id=\(ACCESS_KEY)"
    
    static let baseURLString = "https://api.unsplash.com/"
    static let photoPath = "photos"
    static let featuredPath = "collections/featured"
    
    static let queryAccess = URLQueryItem(name:"client_id",value:ACCESS_KEY)
    var pageAccess = URLQueryItem(name:"page",value:"1")
}
