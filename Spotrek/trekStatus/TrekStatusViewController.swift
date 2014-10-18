//
//  TrekStatusViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class TrekStatusViewController: UIViewController,UINamedController {
    
    var name = "trekStatusViewController"
    private let singleton = SharedEnvironment.Instance()

    private var navigationDelegate:NavigationControllerDelegate!
    private var savedTransitionType: TransitionType!
    private var savedDismissalDuration : NSTimeInterval!
    
    
    private var currentTrek:Trek!
    private var btnPlay:UIButton!
    
    
    private var leftView:UIView!
    private var rightView:UIView!
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.blackColor()
        
    }
    

    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.title = "Trek Status"
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as NavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration
        // Do any additional setup after loading the view.
        initTrekButton()
        initLine1()
        initStatusLabel()
        initLine2()
        initPlayButton()
        initSideViews()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initTrekButton(){
    

        currentTrek = SharedEnvironment.Instance().currentTrek

        var btnTrek:TrekButton!
        
        if singleton.isPad() {
            
            var rectCoordinates = singleton.frameForImage(self.name, imageName: "btnTrek")
            btnTrek = TrekButton(frame: CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height), trek: currentTrek)
            var centerCoordinates = singleton.centerForImage(self.name, imageName: "btnTrek")
            btnTrek.center = CGPointMake(CGRectGetMidX(self.view.frame), centerCoordinates.y)
        }

        btnTrek.allowGestures=false
        btnTrek.userInteractionEnabled=false
        self.view.addSubview(btnTrek)
    
    }
    
    
    func initLine1(){
    
        var height:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineHeight").floatValue)
        var centerY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineCenterY1").floatValue)
        var line1:DottedLine! = DottedLine(frame: CGRectMake(0, 0, self.view.frame.size.width,height), strokeColor: UIColor.lightGrayColor())
        line1.center = CGPointMake(self.view.frame.size.width/2,centerY)
        self.view.addSubview(line1)
    
    }
    
   
    func initStatusLabel(){

        var lblStatus :UILabel!
        
        var rectCoordinates = singleton.frameForImage(self.name, imageName: "lblStatus")
        lblStatus = UILabel(frame: CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height))
        lblStatus.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))
        var fontSize1:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "lblStatusFontSize1").floatValue)
        var fontSize2:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "lblStatusFontSize2").floatValue)
        var fontSize3:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "lblStatusFontSize3").floatValue)

        

        lblStatus.numberOfLines=3
        var placesToUnlock:Int! = (100 - currentTrek.percentComplete)
        var statusLine1:NSMutableAttributedString! = NSMutableAttributedString(string: String(placesToUnlock))
        
        var lblStatusFont1:UIFont! = UIFont(name: "HelveticaNeue-Bold", size:fontSize1)
        var range1:NSRange! = NSMakeRange(0, statusLine1.length)
        statusLine1.addAttribute(NSFontAttributeName, value: lblStatusFont1, range: range1)
        
        var statusLine2:NSMutableAttributedString! = NSMutableAttributedString(string:"\nPLACES")
        var lblStatusFont2:UIFont! = UIFont(name: "HelveticaNeue", size: fontSize2)
        var range2:NSRange! = NSMakeRange(0, statusLine2.length)
        statusLine2.addAttribute(NSFontAttributeName, value: lblStatusFont2, range: range2)
    
        var statusLine3:NSMutableAttributedString! = NSMutableAttributedString(string:"\nTO UNLOCK")
        var lblStatusFont3:UIFont! = UIFont(name: "HelveticaNeue", size: fontSize3)
        var range3:NSRange! = NSMakeRange(0, statusLine3.length)
        statusLine3.addAttribute(NSFontAttributeName, value: lblStatusFont3, range: range3)
        
        
        lblStatus.textAlignment=NSTextAlignment.Center
        lblStatus.textColor=UIColor.whiteColor()
        
        statusLine2.appendAttributedString(statusLine3)
        statusLine1.appendAttributedString(statusLine2)
        lblStatus.attributedText = statusLine1

        self.view.addSubview(lblStatus)
        
        
    
    }

    
    func initLine2(){
        
        var height:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineHeight").floatValue)
        var centerY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineCenterY2").floatValue)
        var line2:DottedLine! = DottedLine(frame: CGRectMake(0, 0, self.view.frame.size.width,height), strokeColor: UIColor.lightGrayColor())
        line2.center = CGPointMake(self.view.frame.size.width/2,centerY)
        self.view.addSubview(line2)
        
    }


    func initPlayButton(){
    
    
        var btnPlay:UIButton!
        var rectCoordinates = singleton.frameForImage(self.name, imageName: "btnPlay")
        btnPlay = UIButton(frame: CGRectMake(0, 0, rectCoordinates.width, rectCoordinates.height))
        btnPlay.titleLabel?.numberOfLines=2
        btnPlay.titleLabel?.textAlignment=NSTextAlignment.Center
        var fontSize:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "btnPlayFontSize").floatValue)
        btnPlay.titleLabel?.font = UIFont(name: "GillSans", size: fontSize)
        btnPlay.setTitle("PLAY\nNOW", forState: UIControlState.Normal)
        btnPlay.setTitleColor(currentTrek.color, forState: UIControlState.Normal)
        btnPlay.setTitleColor(currentTrek.highlightColor, forState: UIControlState.Highlighted)
        UIControlState.Normal
        var centerCoordinates = singleton.centerForImage(self.name, imageName: "btnPlay")
        btnPlay.center = CGPointMake(CGRectGetMidX(self.view.frame), centerCoordinates.y)
        btnPlay.addTarget(self, action:"btnPlay:" , forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnPlay)
    
    
    }
    
    func initSideViews(){
    
    
        leftView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width/2 ,self.view.frame.size.height))
        leftView.backgroundColor = currentTrek.color
        self.view.addSubview(leftView)
        
        
        rightView = UIView(frame: CGRectMake(self.view.frame.size.width/2,0, self.view.frame.size.width/2 ,self.view.frame.size.height))
        rightView.backgroundColor = currentTrek.color
        self.view.addSubview(rightView)
        
    
    
    }

    
    override func viewDidAppear(animated: Bool) {
    
        
        openCurtains()
        
    }

    
    func openCurtains(){
    
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
       
        UIView.animateWithDuration( 0.3) { () -> Void in
            
            self.leftView.center = CGPointMake(self.leftView.center.x - offsetX, self.leftView.center.y)
            self.rightView.center = CGPointMake(self.rightView.center.x + offsetX, self.rightView.center.y)
        }
    
    }
    
    func closeCurtains(popOnCompletion:Bool){
        
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
      
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.leftView.center = CGPointMake(self.leftView.center.x + offsetX, self.leftView.center.y)
            self.rightView.center = CGPointMake(self.rightView.center.x - offsetX, self.rightView.center.y)
            
            }, completion: {(Bool) -> Void in
            
                    if popOnCompletion {
                    
                        //restore saved values
                        self.navigationDelegate.dismissalDuration = self.savedDismissalDuration
                        self.navigationDelegate.typeOfTransition = self.savedTransitionType
                        self.navigationController?.popViewControllerAnimated(true)
                    
                    }
        })
        
        
        
        
      
    
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if (event.touchesForView(self.view)?.count > 1 ) {

           self.closeCurtains(true)
        }
    
    
    }

    
    //TODO: Add code here to open main game screen
    func btnPlay(sender:UIButton){
        
        var alert:UIAlertView!
        
        alert = UIAlertView(title: "Oops!", message: "Not implemented yet?\n W H Y ????", delegate: nil, cancelButtonTitle: "I will Fix it ASAP")
        alert.show()
        
    }
  

       
}
