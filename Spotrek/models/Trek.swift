//
//  Trek.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/8/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class Trek {
    
    var name:String!
    var isCompleted = false
    var percentComplete = 0
    var isLocked = true
   
    var color:UIColor!
    var highlightColor:UIColor!
    var trekNumber:Int!

    
    init(name: String, percentComplete: Int, isLocked:Bool){
       
        self.name = name
        self.percentComplete = percentComplete
        self.isLocked = isLocked
        
        if(percentComplete == 100){
          
            self.isCompleted = true
        }
    }
    
    init(trekNumber:Int, percentComplete: Int, isLocked:Bool){
        var hexColor:String!
        self.trekNumber = trekNumber
        self.name = SharedEnvironment.Instance().trekNames[trekNumber]
        self.isLocked = isLocked
        self.percentComplete = percentComplete
        
        if(percentComplete == 100){
            
            self.isCompleted = true
        }
        
        switch trekNumber {
        
            case 1...3:
                hexColor = SharedEnvironment.Instance().trekColors[1]
            case 4...6:
                hexColor = SharedEnvironment.Instance().trekColors[2]
            case 7...9:
                hexColor = SharedEnvironment.Instance().trekColors[3]
            case 10...12:
                hexColor = SharedEnvironment.Instance().trekColors[4]
            case 13...15:
                hexColor = SharedEnvironment.Instance().trekColors[5]
            case 16...18:
                hexColor = SharedEnvironment.Instance().trekColors[6]
            case 19...21:
                hexColor = SharedEnvironment.Instance().trekColors[7]
            case 22...24:
                hexColor = SharedEnvironment.Instance().trekColors[8]
            default:
                self.color = UIColor.clearColor()
                self.highlightColor = UIColor.clearColor()
                
        }
        
        
        self.color = UIColor(hex: hexColor)
        self.highlightColor = self.color.colorWithAlphaComponent(0.7)
        
    
    }
    
}

