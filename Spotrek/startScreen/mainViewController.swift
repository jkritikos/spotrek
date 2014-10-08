//
//  mainViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/3/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class mainViewController: UIViewController, RingButtonActions {

    
    var navigationDelegate:YBNavigationControllerDelegate!
    var panGesture: UIPanGestureRecognizer!
    
    //UI Elements
    var backgroundImage: UIImageView!
    var spotrekLogo: UIImageView!
    var unlockWorldLabel: UILabel!
    var unlockWorldLabelCenter: CGPoint!
    var startButton: RingButton!
    var dart: UIImageView!
    var takeOffLabel: UILabel!
    var sideMenuButton: UIButton!
    var sideMenuButtonCenter: CGPoint!
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.whiteColor()
        
        setupHomeElements()
    }
    
    func setupHomeElements() {
        
        var startButtonRect, unlockWorldLabelRect, takeOffLabelRect: CGRect!
        var startButtonCenter, spotrekLogoCenter: CGPoint!
        var unlockWorldLabelSize, takeOffLabelSize: CGFloat!
        
        if SharedEnvironment.Instance().isPad() {
        
            startButtonRect = CGRectMake(0, 0, 288, 288)
            startButtonCenter = CGPointMake(CGRectGetMidX(self.view.frame), 560)

            spotrekLogoCenter = CGPointMake(CGRectGetMidX(self.view.frame), 144)
            
            unlockWorldLabelCenter = CGPointMake(734, 234)
            unlockWorldLabelRect = CGRectMake(0, 0, 240, 26)
            
            takeOffLabelRect = CGRectMake(0, 0, 108, 26)
            
            unlockWorldLabelSize = 24.0
            takeOffLabelSize = 22.0
            
            sideMenuButtonCenter = CGPointMake(44, 34)
            
        } else {
            
        }
        
        //Initializing colors
        let walkerColor = UIColor(hex: SharedEnvironment.Instance().trekColors["Walker"]!)
        
        //Initializing background image
        var imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/image1.jpg")
        backgroundImage = UIImageView(image: UIImage(contentsOfFile: imagePath))
        backgroundImage.userInteractionEnabled = true
        backgroundImage.alpha = 0.2
        self.view.addSubview(backgroundImage)
        
        //Initializing spotrek logo
        //Spotrek image
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/spotrek_logo.png")
        spotrekLogo = UIImageView(image: UIImage(contentsOfFile: imagePath))
        spotrekLogo.center = spotrekLogoCenter
        backgroundImage.addSubview(spotrekLogo)
        
        //Spotrek unlock world label
        unlockWorldLabel = UILabel(frame: unlockWorldLabelRect)
        unlockWorldLabel.textAlignment = NSTextAlignment.Center
        unlockWorldLabel.textColor = walkerColor
        unlockWorldLabel.font = UIFont(name: "GillSans", size: unlockWorldLabelSize)
        unlockWorldLabel.text = "UNLOCK THE WORLD"
        unlockWorldLabel.center = CGPointMake(-unlockWorldLabelRect.size.width/2, unlockWorldLabelCenter.y)
        unlockWorldLabel.alpha = 0.0
        backgroundImage.addSubview(unlockWorldLabel)
        
        //Initializing startButton
        //Button background
        
        startButton = RingButton(frame: startButtonRect, color: walkerColor, highlightColor: UIColor.blackColor())
        startButton.center = startButtonCenter
        startButton.keepsHighlightedState = true
        startButton.allowGestures = false
        startButton.alpha = 0.0
        startButton.exclusiveTouch = true
        startButton.delegate = self
        backgroundImage.addSubview(startButton)
        
        //Button image
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/saita.png")
        dart = UIImageView(image: UIImage(contentsOfFile: imagePath))
        dart.center = startButton.center
        dart.alpha = 0.0
        backgroundImage.addSubview(dart)
        
        //Take off label
        takeOffLabel = UILabel(frame: takeOffLabelRect)
        takeOffLabel.textAlignment = NSTextAlignment.Center
        takeOffLabel.textColor = UIColor.whiteColor()
        takeOffLabel.font = UIFont(name: "GillSans", size: takeOffLabelSize)
        takeOffLabel.text = "TAKE OFF"
        takeOffLabel.center = CGPointMake(dart.center.x, dart.center.y+60)
        takeOffLabel.alpha = 0.0
        backgroundImage.addSubview(takeOffLabel)
        
        //Side menu button
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/menu_lines.png")
        let sideMenuButtonImage = UIImage(contentsOfFile: imagePath)
        sideMenuButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        sideMenuButton.frame = CGRectMake(0, 0, sideMenuButtonImage.size.width, sideMenuButtonImage.size.height)
        sideMenuButton.setImage(sideMenuButtonImage, forState: UIControlState.Normal)
        sideMenuButton.center = sideMenuButtonCenter
        sideMenuButton.enabled = true
        sideMenuButton.exclusiveTouch = true
        sideMenuButton.addTarget(self, action: "sideMenuButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        sideMenuButton.alpha = 0.0
        backgroundImage.addSubview(sideMenuButton)
        
        addGestures()
    }
    
    
    override func viewDidAppear(animated: Bool) {
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.backgroundImage.alpha = 1.0
            }, completion: {
                finished in
                
                self.backgroundImage.layer.zPosition = 0
                self.startButton.setNeedsDisplay()
                self.startButton.transform = CGAffineTransformMakeScale(0.4, 0.4)
                self.dart.transform = CGAffineTransformMakeScale(0.4, 0.4)
                self.takeOffLabel.transform = CGAffineTransformMakeScale(0.4, 0.4)
                
                UIView.animateWithDuration(0.5, animations: {
                    
                    self.unlockWorldLabel.alpha = 1.0
                    self.unlockWorldLabel.center = self.unlockWorldLabelCenter
                    self.startButton.alpha = 1.0
                    self.dart.alpha = 1.0
                    self.takeOffLabel.alpha = 1.0
                    self.startButton.transform = CGAffineTransformIdentity
                    self.dart.transform = CGAffineTransformIdentity
                    self.takeOffLabel.transform = CGAffineTransformIdentity
                    self.sideMenuButton.alpha = 1.0
                    
                    }, completion: {
                        finished in
                        
                        self.sideMenuButton.enabled = true
                })
        })
    }
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true
        self.title = "Home"

    }
    
    override func viewDidDisappear(animated: Bool) {
        dart.center = startButton.center
        dart.alpha = 0.0
        backgroundImage.addSubview(dart)
        unlockWorldLabel.center = CGPointMake(-unlockWorldLabel.frame.size.width/2, unlockWorldLabelCenter.y)
        unlockWorldLabel.alpha = 0.0
        takeOffLabel.center = CGPointMake(dart.center.x, dart.center.y+60)
        takeOffLabel.alpha = 0.0
        sideMenuButton.alpha = 0.0
    }

    override func didReceiveMemoryWarning() {
    
        super.didReceiveMemoryWarning()

    }
    
    //MARK: Gestures
    
    func addGestures() {
        panGesture = UIPanGestureRecognizer(target: self, action: "handlePan:")
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 1
        self.view.addGestureRecognizer(panGesture)
    }
    
    func handlePan(gesture: UIPanGestureRecognizer) {
        
        if gesture.state == UIGestureRecognizerState.Began {
            
        } else if gesture.state == UIGestureRecognizerState.Ended {
            
        }
    }
    
    //MARK: Touches
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
        if (event.touchesForView(self.view)?.count > 1 ) {

        } else {
            
        }
        
    }
    
    func sideMenuButtonPressed(sender: AnyObject) {
        
    }
    
    //MARK: RingButtonDelegate

    func ringButtonSingleTap(sender: AnyObject) {
        
        sideMenuButton.enabled = false
        
        UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.startButton.alpha = 0.0
            self.takeOffLabel.alpha = 0.0
            
            }, completion: {
            
                finished in
                
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    
                    self.dart.center = CGPointMake(self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height/3)
                    self.dart.transform = CGAffineTransformMakeScale(0.1, 0.1)
                    
                    }, completion: {
                        
                        finished in
                        
                        self.dart.removeFromSuperview()
                        
                        self.navigationDelegate = YBNavigationControllerDelegate()
                        self.navigationDelegate.typeOfTransition = YBTransitionType.LeftToRight
                        self.navigationDelegate.presentationDuration = 0.3
                        self.navigationDelegate.dismissalDuration = 0.3
                        self.navigationController?.delegate  = self.navigationDelegate
                        let selectTrekView = selectTrekViewController(nibName: nil,bundle: nil)
                        selectTrekView.modalPresentationStyle = UIModalPresentationStyle.Custom
                        self.navigationController?.pushViewController(selectTrekView, animated: true)
                        
                })
        })
    }
   
}
