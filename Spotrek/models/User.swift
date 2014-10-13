//
//  User.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/13/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation

class User {
    
    var id:Int!
    var name:String!
    var facebookId:String?
    
    init(userId:Int, userName:String){
        self.id = userId
        self.name = userName
    }
    
}