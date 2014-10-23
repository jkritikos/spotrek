//
//  SimpleError.swift
//  myFirstSwiftApp
//
//  Created by Yannis Belessiotis on 10/22/14.
//  Copyright (c) 2014 Boomar.gr. All rights reserved.
//

import Foundation
class SimpleError {
    
    var code:String!
    var message:String!
    
    init (code:String?, message:String?) {
        
        self.code = code
        self.message = message
    
    }
    
}
