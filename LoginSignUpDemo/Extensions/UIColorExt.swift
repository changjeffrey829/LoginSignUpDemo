//
//  UIColorExt.swift
//  LoginSignUpDemo
//
//  Created by Jeffrey Chang on 12/25/18.
//  Copyright © 2018 Jeffrey Chang. All rights reserved.
//

import UIKit

extension UIColor {
    static func rgb(red: CGFloat, green: CGFloat, blue: CGFloat) -> UIColor {
        return UIColor(red: red/255, green: green/255, blue: blue/255, alpha: 1)
    }
    static let customDarkBrown = rgb(red: 96, green: 57, blue: 19)
    static let customBrown = rgb(red: 96, green: 57, blue: 19)
    static let customOrange = rgb(red: 251, green: 176, blue: 64)
    static let tabBarBrown = rgb(red: 185, green: 160, blue: 135)
    
}
