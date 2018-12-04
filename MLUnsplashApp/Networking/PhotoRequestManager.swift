//
//  PhotoRequestManager.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation
import Alamofire
import ObjectMapper

final class PhotoRequestManager {
    
    internal let fullURL: URL
    
    //featured collection
    internal init(path:String, qureryName: String, queryValue:String) {
        
        let urlString = "\(API.baseURLString)\(path)?\(qureryName)=\(queryValue)&\(API.publicAuth)"
        
        self.fullURL = URL.init(string:urlString)!
    }
    
    typealias CompletionHandler = (Any?, Error?) -> Void
    //photo by id
    internal init(path:String,id:String){
       
        let urlString = "\(API.baseURLString)\(path)//\(id)?\(API.publicAuth)"
        self.fullURL = URL.init(string:urlString)!
        
    }
    
    func requestPhoto (url:URL,completion:@escaping CompletionHandler){
        
        Alamofire.request(url).validate()
            .responseJSON {response in
                
                guard response.error == nil else{
                    return completion(nil,response.error)
                }
                
                if response.result.isSuccess {
                    let result = response.result
                    completion(result.value,nil)
                }
                else {
                    completion(nil,response.result.error)
                }
        }
    }
    
}
