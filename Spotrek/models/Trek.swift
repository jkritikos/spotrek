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
    
    init(trekNumber:Int){
    
        var hexColor:String!
        self.trekNumber = trekNumber
        self.name = SharedEnvironment.Instance().trekNames[trekNumber]

        
        switch trekNumber {
        
            case 0...2:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Walker"]
                
            case 3...5:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Sailor"]

                
            case 6...8:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Pilot"]

                
            case 9...11:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Traveler"]

                
            case 12...14:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Voyager"]

                
            case 15...17:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Explorer"]

                
            case 18...20:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Captain"]

                
            case 21...23:
                
                    hexColor = SharedEnvironment.Instance().trekColors["Spotreker"]

            default:
                    
                    self.color = UIColor.clearColor()
                    self.highlightColor = UIColor.clearColor()
                
            
        }
        
        
        self.color = UIColor(hex: hexColor)
        self.highlightColor = self.color.colorWithAlphaComponent(0.7)
        
    
    }
    
}

