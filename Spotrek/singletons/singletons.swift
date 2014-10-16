//
//  singletons.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/7/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit
import AVFoundation


class SharedEnvironment {
    //the currently selected trek
    var currentTrek:Trek!
    //our user
    var currentUser:User!
    
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
    
    var trekList: [Trek] = []
    
    var imageCoordinatesDictionary: [String: [String: AnyObject]] {
        
        var pathOfPlist: String!
            
        if self.isPad() {
            pathOfPlist = "SizePositionCoordinatesiPad"
        } else {
                
        }
            
        if let path = NSBundle.mainBundle().pathForResource(pathOfPlist, ofType: "plist") {
                
            if let plistDictionary = NSDictionary(contentsOfFile: path) as? [String: [String: AnyObject]] {
                return plistDictionary
            }
        }
            
        return Dictionary(minimumCapacity: 0)
    }
    
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
    
    func updateState(){
      
        var trekAlpha = Trek(trekNumber:0, percentComplete:0, isLocked:false)
        var trekBeta = Trek(trekNumber:1, percentComplete:20, isLocked:false)
        var trekGamma = Trek(trekNumber:2, percentComplete:100, isLocked:false)
        var trekDelta = Trek(trekNumber:3, percentComplete:0, isLocked:true)
        var trekEpsilon = Trek(trekNumber:4, percentComplete:0, isLocked:true)
        var trekZeta = Trek(trekNumber:5, percentComplete:0, isLocked:true)
        var trekEta = Trek(trekNumber:6, percentComplete:0, isLocked:true)
        var trekTheta = Trek(trekNumber:7, percentComplete:0, isLocked:true)
        var trekIota = Trek(trekNumber:8, percentComplete:0, isLocked:true)
        var trekKappa = Trek(trekNumber:9, percentComplete:0, isLocked:true)
        var trekLamda = Trek(trekNumber:10, percentComplete:0, isLocked:true)
        var trekMu = Trek(trekNumber:11, percentComplete:0, isLocked:true)
        var trekNu = Trek(trekNumber:12, percentComplete:0, isLocked:true)
        var trekXi = Trek(trekNumber:13, percentComplete:0, isLocked:true)
        var trekOmicron = Trek(trekNumber:14, percentComplete:0, isLocked:true)
        var trekPi = Trek(trekNumber:15, percentComplete:0, isLocked:true)
        var trekRho = Trek(trekNumber:16, percentComplete:0, isLocked:true)
        var trekSigma = Trek(trekNumber:17, percentComplete:0, isLocked:true)
        var trekTau = Trek(trekNumber:18, percentComplete:0, isLocked:true)
        var trekUpsilon = Trek(trekNumber:19, percentComplete:0, isLocked:true)
        var trekPhi = Trek(trekNumber:20, percentComplete:0, isLocked:true)
        var trekChi = Trek(trekNumber:21, percentComplete:0, isLocked:true)
        var trekPsi = Trek(trekNumber:22, percentComplete:0, isLocked:true)
        var trekOmega = Trek(trekNumber:23, percentComplete:0, isLocked:true)
        
        self.trekList = [trekAlpha,trekBeta,trekGamma,trekDelta,trekEpsilon,trekZeta,trekEta,trekTheta,trekIota,trekKappa,trekLamda,trekMu,trekNu,trekXi,trekOmicron,trekPi,trekRho,trekSigma,trekTau,trekUpsilon,trekPhi,trekXi,trekPsi,trekOmega]
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
    
    //MARK: Size and position coordinates plist helper methods
    func sizePositionPlistElement(senderName: String, elementName: String) -> AnyObject {
        
        if let selectedView = imageCoordinatesDictionary[senderName] {
            
            if let element: AnyObject = selectedView[elementName] {
                
                return element
            }
        }
        
        return ""
    }
    
    func centerForImage(senderName: String, imageName: String) -> (x: CGFloat, y: CGFloat) {
        
        var coordinates: (CGFloat, CGFloat) = (0, 0)
        
        if let selectedView = imageCoordinatesDictionary[senderName] {
            
            if let selectedImageInView: AnyObject = selectedView[imageName + "Center"] {
                
                coordinates = (selectedImageInView["x"]! as CGFloat, selectedImageInView["y"]! as CGFloat)
            }
        }
        
        return coordinates
    }
    
    func frameForImage(senderName: String, imageName: String) -> (x: CGFloat, y: CGFloat, width: CGFloat, height: CGFloat) {
        
        var coordinates: (CGFloat, CGFloat, CGFloat, CGFloat) = (0, 0, 0, 0)
        
        if let selectedView = imageCoordinatesDictionary[senderName] {
            
            if let selectedImageInView: AnyObject = selectedView[imageName + "Rect"] {
                coordinates = (selectedImageInView["x"]! as CGFloat, selectedImageInView["y"]! as CGFloat, selectedImageInView["width"]! as CGFloat, selectedImageInView["height"]! as CGFloat)
            }
        }
        
        return coordinates
    }
}

//MARK: SharedAudioPlayer Singleton

class SharedAudioPlayer {
    
    private var mainLoopAudioPlayer:AVAudioPlayer!
    private let mainLoopFileName:String! = "MTB_1"
    private let mainLoopFileType:String! = "wav"
    
    class func Instance() -> SharedAudioPlayer! {
        
        struct Static {
            
            static var instance: SharedAudioPlayer? = nil
            static var onceToken: dispatch_once_t = 0
        }
        
        dispatch_once(&Static.onceToken) {
            
            Static.instance = self()
        }
        
        return Static.instance!
    }
    
    required init() {
        
        
        self.initMainLoop()
        
    }
    
    
    private func initMainLoop(){
        
        //initialize mainLoopAudioPlayer
        var soundFilePath:String! = NSBundle.mainBundle().pathForResource(self.mainLoopFileName, ofType: self.mainLoopFileType, inDirectory:nil)
        var soundFileURL:NSURL! = NSURL(fileURLWithPath: soundFilePath)
        self.mainLoopAudioPlayer = AVAudioPlayer(contentsOfURL: soundFileURL, error: nil)
        self.mainLoopAudioPlayer.numberOfLoops = -1 //infinite
        
    }
    
    func stopMainLoop() {
        
        self.mainLoopAudioPlayer.stop() //after this is called player must be re inititialized
        
    }
    
    func pauseMainLoop() {
        
        self.mainLoopAudioPlayer.pause()
        
    }
    
    
    
    func resumeMainLoop(){
        
        self.mainLoopAudioPlayer.play()
    }
    
    
    func restartMainLoop(){
        
        self.initMainLoop()
        self.resumeMainLoop()
        
    }
    
    
    func mainLoopIsPlaying()->Bool{
        
        return self.mainLoopAudioPlayer.playing
    }
    
    
}





