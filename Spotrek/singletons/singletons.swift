//
//  singletons.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/7/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class SharedEnvironment {
    
    var trekColors =    ["Walker":"39bbea",
                        "Sailor": "fe9364",
                        "Pilot":"9cc863",
                        "Traveler":"e188bb",
                        "Voyager":"23c0a4",
                        "Explorer":"a792e3",
                        "Captain":"e55c66",
                        "Spotreker":"5793d2"]
    

    var trekNames = ["ALPHA","BETA","GAMMA","DELTA","EPSILON","ZETA","ETA","THETA","IOTA","KAPPA","LAMBDA","MU","NU","XI","OMICRON","PI","RHO","SIGMA",
        "TAU","UPSILON","PHI","CHI","PSI","OMEGA"]
    
    
    
    class func Instance() -> SharedEnvironment! {
        
        struct Static {
            
            static var instance: SharedEnvironment? = nil
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken) {
            
            Static.instance = self()
        }
        
        return Static.instance!
    }
    
    required init() {
        
        
    }
    
    

    func isPad()->Bool{
        
        
        if UIDevice.currentDevice().model.hasPrefix("iPad") {
            
            return true
            
        } else {
            
            return false
        }
        
    }
    
    

    func resourcePath()->String!{
        
        var pathToReturn = NSBundle.mainBundle().resourcePath
        var suffix="iPhone"
        
        if isPad() {
            
            suffix="iPad"
            
        }
        
        pathToReturn = pathToReturn?.stringByAppendingPathComponent(suffix)
        
        return pathToReturn
        
    }
}

