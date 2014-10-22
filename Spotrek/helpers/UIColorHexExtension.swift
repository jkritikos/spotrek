//
//  UIColorHexExtension.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 280/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
   
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
//    convenience init(hex:String) {
//        
//        var hexNumber: UInt32 = 0
//        
//        let scanner = NSScanner(string: hex)
//        scanner.scanLocation = 1
//        scanner.scanHexInt(&hexNumber)
//        
//        let hexNumberInt = Int(hexNumber)
//        
//        self.init(red:(hexNumberInt >> 16) & 0xff, green:(hexNumberInt >> 8) & 0xff, blue:hexNumberInt & 0xff)
//    }
    
    convenience init(hex: String) {
        var red: CGFloat = 0.0
        var green: CGFloat = 0.0
        var blue: CGFloat = 0.0
        var alpha: CGFloat = 1.0
        if hex.hasPrefix("#") {
            let index = advance(hex.startIndex, 1)
            let hex = hex.substringFromIndex(index)
            let scanner = NSScanner(string: hex)
            var hexValue: CUnsignedLongLong = 0
            if scanner.scanHexLongLong(&hexValue) {
                if countElements(hex) == 6 {
                    red = CGFloat((hexValue & 0xFF0000) >> 16) / 255.0
                    green = CGFloat((hexValue & 0x00FF00) >> 8) / 255.0
                    blue = CGFloat(hexValue & 0x0000FF) / 255.0
                } else if countElements(hex) == 8 {
                    red = CGFloat((hexValue & 0xFF000000) >> 24) / 255.0
                    green = CGFloat((hexValue & 0x00FF0000) >> 16) / 255.0
                    blue = CGFloat((hexValue & 0x0000FF00) >> 8) / 255.0
                    alpha = CGFloat(hexValue & 0x000000FF) / 255.0
                } else {
                    print("invalid rgb string, length should be 7 or 9")
                }
            } else {
                println("scan hex error")
            }
        } else {
            print("invalid rgb string, missing '#' as prefix")
        }
        self.init(red:red, green:green, blue:blue, alpha:alpha)
    }
}