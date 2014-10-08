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
    
    var trekAlpha = Trek(name: "ALPHA", percentComplete:0, isLocked:false)
    var trekBeta = Trek(name: "BETA", percentComplete:0, isLocked:true)
    var trekGamma = Trek(name: "GAMMA", percentComplete:0, isLocked:true)
    var trekDelta = Trek(name: "DELTA", percentComplete:0, isLocked:true)
    var trekEpsilon = Trek(name: "EPSILON", percentComplete:0, isLocked:true)
    var trekZeta = Trek(name: "ZETA", percentComplete:0, isLocked:true)
    var trekEta = Trek(name: "ETA", percentComplete:0, isLocked:true)
    var trekTheta = Trek(name: "THETA", percentComplete:0, isLocked:true)
    var trekIota = Trek(name: "IOTA", percentComplete:0, isLocked:true)
    var trekKappa = Trek(name: "KAPPA", percentComplete:0, isLocked:true)
    var trekLamda = Trek(name: "LAMBDA", percentComplete:0, isLocked:true)
    var trekMu = Trek(name: "MU", percentComplete:0, isLocked:true)
    var trekNu = Trek(name: "NU", percentComplete:0, isLocked:true)
    var trekXi = Trek(name: "XI", percentComplete:0, isLocked:true)
    var trekOmicron = Trek(name: "OMICRON", percentComplete:0, isLocked:true)
    var trekPi = Trek(name: "PI", percentComplete:0, isLocked:true)
    var trekRho = Trek(name: "RHO", percentComplete:0, isLocked:true)
    var trekSigma = Trek(name: "SIGMA", percentComplete:0, isLocked:true)
    var trekTau = Trek(name: "TAU", percentComplete:0, isLocked:true)
    var trekUpsilon = Trek(name: "UPSILON", percentComplete:0, isLocked:true)
    var trekPhi = Trek(name: "PHI", percentComplete:0, isLocked:true)
    var trekChi = Trek(name: "CHI", percentComplete:0, isLocked:true)
    var trekPsi = Trek(name: "PSI", percentComplete:0, isLocked:true)
    var trekOmega = Trek(name: "OMEGA", percentComplete:0, isLocked:true)
    
    var trekList: [Trek] = []
    
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
        self.trekList += [trekAlpha,trekBeta,trekGamma,trekDelta,trekEpsilon,trekZeta,trekEta,trekTheta,trekIota,trekKappa,trekLamda,trekMu,trekNu,trekXi,trekOmicron,trekPi,trekRho,trekSigma,trekTau,trekUpsilon,trekPhi,trekXi,trekPsi,trekOmega]
        
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
        var suffix="images/iphone"
        
        if isPad() {
            
            suffix="images/ipad"
            
        }
        
        pathToReturn = pathToReturn?.stringByAppendingPathComponent(suffix)
        
        return pathToReturn
        
    }
}

