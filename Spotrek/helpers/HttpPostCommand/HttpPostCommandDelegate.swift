//
//  HttpPostCommandDelegate.swift
//  myFirstSwiftApp
//
//  Created by Yannis Belessiotis on 10/22/14.
//  Copyright (c) 2014 Boomar.gr. All rights reserved.
//

import Foundation

protocol HttpPostCommandDelegate{

    func commandFailedWithError(error:SimpleError? , commandUrlKey:CommandUrlKey!)
    func commandCompletedSuccessfully (response:NSDictionary?, commandUrlKey:CommandUrlKey!)

}