//
//  Trek.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/8/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation

class Trek {
    
    var name:String!
    var isCompleted = false
    var percentComplete = 0
    var isLocked = true
    
    init(name: String, percentComplete: Int){
        self.name = name
        self.percentComplete = percentComplete
        
        if(percentComplete == 100){
            self.isCompleted = true
        }
    }
}