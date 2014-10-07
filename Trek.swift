//
//  Trek.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/7/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation

class Trek {
    var name:String!
    var isCompleted = false
    var percentComplete = 0
    
    init(name: String, complete: Bool, percentComplete: Int){
        self.name = name
        self.isCompleted = complete
        self.percentComplete = percentComplete
    }
}