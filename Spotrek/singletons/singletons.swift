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
    
    var appLandscapeFrame : CGRect {
        
        if self.iOS7 {
            return CGRectMake (0,0,UIScreen.mainScreen().bounds.size.height,UIScreen.mainScreen().bounds.size.width)
        }
            
        return UIScreen.mainScreen().bounds
    }
    
    //the currently selected trek
    var currentTrek:Trek!
    //our user
    var currentUser:User!
    //available questions
    var currentQuestionList: [Question] {
        return [Question(id: 1, milesWorth: 10, answerA: "To spiti mou", answerB: "To spiti sou", answerC: "H kai kapou allou", answerD: "H kai oxi", correctAnswer: 1)]
    }
        
    let trekColors = [1:"#39bbea", 2:"#fe9364", 3:"#9cc863", 4:"#e188bb", 5:"#23c0a4", 6:"#a792e3", 7:"#e55c66", 8:"#5793d2"]
    let trekLevels = [1:"Walker", 2:"Sailor", 3:"Pilot", 4:"Traveler", 5:"Voyager", 6:"Explorer", 7:"Captain", 8:"Spotreker"]
    
    var trekNames = [1:"ALPHA",2:"BETA",3:"GAMMA",4:"DELTA",5:"EPSILON",6:"ZETA",7:"ETA",8:"THETA",9:"IOTA",10:"KAPPA",11:"LAMBDA",12:"MU",13:"NU",14:"XI",15:"OMICRON",16:"PI",17:"RHO",18:"SIGMA",19:"TAU",20:"UPSILON",21:"PHI",22:"CHI",23:"PSI",24:"OMEGA"]
    
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
    
    let iOS7 = floor(NSFoundationVersionNumber) <= floor(NSFoundationVersionNumber_iOS_7_1)
    let iOS8 = floor(NSFoundationVersionNumber) > floor(NSFoundationVersionNumber_iOS_7_1)
    
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
      
        var trekAlpha = Trek(trekNumber:1, percentComplete:0, isLocked:false)
        var trekBeta = Trek(trekNumber:2, percentComplete:20, isLocked:false)
        var trekGamma = Trek(trekNumber:3, percentComplete:100, isLocked:false)
        var trekDelta = Trek(trekNumber:4, percentComplete:0, isLocked:true)
        var trekEpsilon = Trek(trekNumber:5, percentComplete:0, isLocked:true)
        var trekZeta = Trek(trekNumber:6, percentComplete:0, isLocked:true)
        var trekEta = Trek(trekNumber:7, percentComplete:0, isLocked:true)
        var trekTheta = Trek(trekNumber:8, percentComplete:0, isLocked:true)
        var trekIota = Trek(trekNumber:9, percentComplete:0, isLocked:true)
        var trekKappa = Trek(trekNumber:10, percentComplete:0, isLocked:true)
        var trekLamda = Trek(trekNumber:11, percentComplete:0, isLocked:true)
        var trekMu = Trek(trekNumber:12, percentComplete:0, isLocked:true)
        var trekNu = Trek(trekNumber:13, percentComplete:0, isLocked:true)
        var trekXi = Trek(trekNumber:14, percentComplete:0, isLocked:true)
        var trekOmicron = Trek(trekNumber:15, percentComplete:0, isLocked:true)
        var trekPi = Trek(trekNumber:16, percentComplete:0, isLocked:true)
        var trekRho = Trek(trekNumber:17, percentComplete:0, isLocked:true)
        var trekSigma = Trek(trekNumber:18, percentComplete:0, isLocked:true)
        var trekTau = Trek(trekNumber:19, percentComplete:0, isLocked:true)
        var trekUpsilon = Trek(trekNumber:20, percentComplete:0, isLocked:true)
        var trekPhi = Trek(trekNumber:21, percentComplete:0, isLocked:true)
        var trekChi = Trek(trekNumber:22, percentComplete:0, isLocked:true)
        var trekPsi = Trek(trekNumber:23, percentComplete:0, isLocked:true)
        var trekOmega = Trek(trekNumber:24, percentComplete:0, isLocked:true)
        
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
    func plistElement(senderName: String, elementName: String) -> AnyObject {
        
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





