//
//  User.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/13/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation

class User {
    
    //remote id
    var id:Int!
    //security token
    var spotrekToken:String!
    var name:String!
    var facebookId:String?
    
    
    var totalMiles:Int!
    var totalHints:Int!
    
    //current location from physical location
    var currentLocation:String?
    
    //spotrek level (walker, sailor etc)
    var currentLevel:String?
    
    init(userId:Int, token:String, userName:String, miles:Int){
        self.id = userId
        self.spotrekToken = token
        self.name = userName
        self.totalMiles = miles
    }
    
}