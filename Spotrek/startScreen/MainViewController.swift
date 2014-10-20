//
//  MainViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/3/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, UINamedController, RingButtonActions, HomeSideMenuActions {

    
    var name = "mainViewController"
    let singleton = SharedEnvironment.Instance()
    
    var navigationDelegate:NavigationControllerDelegate!
    var panGesture: UIPanGestureRecognizer!
    var sideMenu: HomeSideMenu!
    
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
    
        self.view = UIView(frame: singleton.appLandscapeFrame)
        self.view.backgroundColor=UIColor.blackColor()
        
    }
    
    func setupHomeElements() {
        
        var startButtonRect, unlockWorldLabelRect, takeOffLabelRect: CGRect!
        var startButtonCenter, spotrekLogoCenter: CGPoint!
        var unlockWorldLabelSize, takeOffLabelSize: CGFloat!
        
        if singleton.isPad() {
            
            var rectCoordinates = singleton.frameForImage(self.name, imageName: "startButton")
            startButtonRect = CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height)

            var centerCoordinates = singleton.centerForImage(self.name, imageName: "startButton")

            startButtonCenter = CGPointMake(CGRectGetMidX(self.view.frame), centerCoordinates.y)
            
            centerCoordinates = singleton.centerForImage(self.name, imageName: "spotrekLogo")

            spotrekLogoCenter = CGPointMake(CGRectGetMidX(self.view.frame), centerCoordinates.y)
            
            centerCoordinates = singleton.centerForImage(self.name, imageName: "unlockWorldLabel")
            unlockWorldLabelCenter = CGPointMake(centerCoordinates.x, centerCoordinates.y)
            
            rectCoordinates = singleton.frameForImage(self.name, imageName: "unlockWorldLabel")
            unlockWorldLabelRect = CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height)
            
            rectCoordinates = singleton.frameForImage(self.name, imageName: "takeOffLabel")
            takeOffLabelRect = CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height)
            
            unlockWorldLabelSize = singleton.plistElement(self.name, elementName: "unlockWorldLabelSize") as CGFloat
            takeOffLabelSize = singleton.plistElement(self.name, elementName: "takeOffLabelSize") as CGFloat
            
            centerCoordinates = singleton.centerForImage(self.name, imageName: "sideMenuButton")
            sideMenuButtonCenter = CGPointMake(centerCoordinates.x, centerCoordinates.y)
            
        } else {
            
        }
        
        //Side menu
        sideMenu = HomeSideMenu()
        sideMenu.center = CGPointMake(sideMenu.frame.size.width/2, sideMenu.frame.size.height/2)
        sideMenu.delegate = self
        sideMenu.layer.zPosition = -1
        sideMenu.alpha = 0.0
        self.view.addSubview(sideMenu)
        
        //Initializing colors
        let walkerColor = UIColor(hex: singleton.trekColors["Walker"]!)
        
        //Initializing background image
        var imagePath = singleton.resourcePath().stringByAppendingPathComponent("home/image1.jpg")
        backgroundImage = UIImageView(image: UIImage(contentsOfFile: imagePath))
        backgroundImage.userInteractionEnabled = true
        backgroundImage.alpha = 0.2
        self.view.addSubview(backgroundImage)
        
        //Initializing spotrek logo
        //Spotrek image
        imagePath = singleton.resourcePath().stringByAppendingPathComponent("home/spotrek_logo.png")
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
        imagePath = singleton.resourcePath().stringByAppendingPathComponent("home/saita.png")
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
        imagePath = singleton.resourcePath().stringByAppendingPathComponent("home/menu_lines.png")
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
  
        SharedAudioPlayer.Instance().resumeMainLoop()
        
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.backgroundImage.alpha = 1.0
            }, completion: {
                finished in
                
                self.sideMenu.alpha = 1.0
                self.backgroundImage.layer.zPosition = 0
                self.startButton.setNeedsDisplay()
                self.startButton.transform = CGAffineTransformMakeScale(0.4, 0.4)
                self.dart.transform = CGAffineTransformMakeScale(0.4, 0.4)
                self.takeOffLabel.transform = CGAffineTransformMakeScale(0.4, 0.4)
                
                spring(0.75, {
                    self.unlockWorldLabel.center = self.unlockWorldLabelCenter
                })
                                
                UIView.animateWithDuration(0.5, animations: {
                    
                    self.unlockWorldLabel.alpha = 1.0
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
        self.view.backgroundColor = UIColor.blackColor()
        self.title = "Home"
        
        setupHomeElements()

    }
    
    override func viewDidDisappear(animated: Bool) {
        dart.center = startButton.center
        dart.alpha = 0.0
        backgroundImage.addSubview(dart)
        unlockWorldLabel.center = CGPointMake(-unlockWorldLabel.frame.size.width/2, unlockWorldLabelCenter.y)
        unlockWorldLabel.alpha = 0.0
        
        let dartCenterYOffset = singleton.plistElement(self.name, elementName: "dartCenterYOffset") as CGFloat
        
        takeOffLabel.center = CGPointMake(dart.center.x, dart.center.y+dartCenterYOffset)
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
            
            if backgroundImage.frame.origin.x > sideMenu.frame.size.width/2 {
                
                UIView.animateWithDuration(0.3, animations: {
                    self.backgroundImage.center = CGPointMake(self.backgroundImage.frame.size.width/2 + self.sideMenu.frame.size.width, self.backgroundImage.center.y)
                    }, completion: { finished in
                        self.startButton.userInteractionEnabled = false
                        self.sideMenu.isPresent = true
                })
                
            } else {
                
                UIView.animateWithDuration(0.3, animations: {
                    self.backgroundImage.center = CGPointMake(self.backgroundImage.frame.size.width/2, self.backgroundImage.center.y)
                    }, completion: { finished in
                        self.startButton.userInteractionEnabled = true
                        self.sideMenu.isPresent = false
                })
                
            }
            
        } else if gesture.state == UIGestureRecognizerState.Changed {
            
            let translation = gesture.translationInView(self.view)
            
            if gesture.velocityInView(self.view).x > 0 {
                if backgroundImage.frame.origin.x < sideMenu.frame.size.width {
                    backgroundImage.center = CGPointMake(backgroundImage.center.x + translation.x, backgroundImage.center.y)
                }
            } else  if gesture.velocityInView(self.view).x < 0 {
                if backgroundImage.frame.origin.x > 0 {
                    backgroundImage.center = CGPointMake(backgroundImage.center.x + translation.x, backgroundImage.center.y)
                }
            }
            
            gesture.setTranslation(CGPointMake(0, 0), inView: self.view)
        }
    }
    
    //MARK: Touches
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
        if (event.touchesForView(self.view)?.count > 1 ) {

        } else {
            
        }
        
    }
    
    func sideMenuButtonPressed(sender: AnyObject) {
        handleSideMenu()
    }
    
    func handleSideMenu() {
        startButton.userInteractionEnabled = !startButton.userInteractionEnabled
        sideMenuButton.enabled = !sideMenuButton.enabled
        
        var factor: CGFloat = 1
        if sideMenu.isPresent {
            factor = -1
        }
        
        sideMenu.isPresent = !sideMenu.isPresent
        
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.backgroundImage.center = CGPointMake(self.backgroundImage.center.x + self.sideMenu.frame.size.width*factor, self.backgroundImage.center.y)
            self.spotrekLogo.center = CGPointMake(self.spotrekLogo.center.x - (self.sideMenu.frame.size.width/2)*factor, self.spotrekLogo.center.y)
            self.unlockWorldLabel.center = CGPointMake(self.unlockWorldLabel.center.x - (self.sideMenu.frame.size.width/2)*factor, self.unlockWorldLabel.center.y)
            self.startButton.center = CGPointMake(self.startButton.center.x - (self.sideMenu.frame.size.width/2)*factor, self.startButton.center.y)
            self.dart.center = CGPointMake(self.dart.center.x - (self.sideMenu.frame.size.width/2)*factor, self.dart.center.y)
            self.takeOffLabel.center = CGPointMake(self.takeOffLabel.center.x - (self.sideMenu.frame.size.width/2)*factor, self.takeOffLabel.center.y)
            
            }, completion: { finished in
                self.sideMenuButton.enabled = !self.sideMenuButton.enabled
        })

    }
    
    //MARK: RingButtonDelegate

    func ringButtonSingleTap(sender: AnyObject) {
        
        sideMenuButton.enabled = false
        
        UIView.animateWithDuration(0.75, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            
            self.startButton.alpha = 0.0
            self.takeOffLabel.alpha = 0.0
            
            }, completion: {
            
                finished in
                
                self.sideMenu.alpha = 0.0
                
                UIView.animateWithDuration(1.0, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: {
                    
                    self.dart.center = CGPointMake(self.backgroundImage.frame.size.width, self.backgroundImage.frame.size.height/3)
                    self.dart.transform = CGAffineTransformMakeScale(0.1, 0.1)
                    
                    }, completion: {
                        
                        finished in
                        
                        self.dart.removeFromSuperview()
                        
                        self.navigationDelegate = NavigationControllerDelegate()
                        self.navigationDelegate.typeOfTransition = TransitionType.LeftToRight
                        self.navigationDelegate.presentationDuration = 0.3
                        self.navigationDelegate.dismissalDuration = 0.3
                        self.navigationController?.delegate  = self.navigationDelegate
                        let selectTrekView = TrekSelectViewController(nibName: nil,bundle: nil)
                        selectTrekView.modalPresentationStyle = UIModalPresentationStyle.Custom
                        self.navigationController?.pushViewController(selectTrekView, animated: true)
                        
                })
        })
    }
    
    //MARK: SideMenuButton Delegate
    func homeSideMenuButtonWasPressed(buttonItem: UIButton) {
        
        //generic view transition setup
        self.navigationDelegate = NavigationControllerDelegate()
        self.navigationDelegate.typeOfTransition = TransitionType.CrossDisolve
        self.navigationDelegate.presentationDuration = 0.5
        self.navigationDelegate.dismissalDuration = 0.5
        self.navigationController?.delegate  = self.navigationDelegate
        
        switch buttonItem.tag {
            case HomeSideMenuButtonType.None.toRaw(): break
            
            //Profile summary
            case HomeSideMenuButtonType.Profile.toRaw():
                let profileSummaryView = ProfileSummaryViewController(nibName: nil,bundle: nil)
                profileSummaryView.modalPresentationStyle = UIModalPresentationStyle.Custom
                self.navigationController?.pushViewController(profileSummaryView, animated: true)
                break
            
            case HomeSideMenuButtonType.Gallery.toRaw(): break
            case HomeSideMenuButtonType.Settings.toRaw(): break
            case HomeSideMenuButtonType.Store.toRaw(): break
            case HomeSideMenuButtonType.Hints.toRaw(): break
            default:
                break
    
        }
    }
 
   
}
