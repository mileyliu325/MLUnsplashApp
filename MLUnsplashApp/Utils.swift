//
//  Utils.swift
//  MLUnsplashApp
//
//  Created by Simeng Liu on 4/12/18.
//  Copyright © 2018 Simeng Liu. All rights reserved.
//

import Foundation
import UIKit

func getSimpleAlert (titleString: String, messgae:String) ->UIAlertController{
    
    let alert =  UIAlertController(title: titleString, message: messgae, preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
    return alert
}


func stringToDate(dateString:String)-> Date? {
    
    let dateFormatter = DateFormatter()
    
    dateFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"
    let date = dateFormatter.date(from: dateString)
    return date

}

func simplerDate(longDate:String) ->String {
    
    let longFormatter = DateFormatter()
    longFormatter.dateFormat = "yyyy-MM-dd'T'hh:mm:ss.SSSZ"
    let date = longFormatter.date(from: longDate)
    
    if let dat = date {
        
        let simpleFormat = DateFormatter()
        simpleFormat.dateFormat = "yyyy-MM-dd"
        let dateStr = simpleFormat.string(from: dat)
        return dateStr
    }
    return "transferError"
    

}


func dateToString(date:Date) ->String {
    let format = DateFormatter()
    format.dateFormat = "yyyy-MM-dd"
    let dateStr = format.string(from: date)
    return dateStr
    
}
