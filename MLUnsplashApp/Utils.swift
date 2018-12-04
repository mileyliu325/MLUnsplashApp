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
