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
    
    var backgroundImage: UIImageView!
    var startButton: RingButton!
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.whiteColor()
        
        setupHomeStartButton()
    }
    
    func setupHomeStartButton() {
        
        var startButtonRect, spotrekLogoRect, unlockWorldLabelRect, takeOffLabelRect: CGRect!
        var startButtonCenter, spotrekLogoCenter, unlockWorldCenter: CGPoint!
        var unlockWorldLabelSize, takeOffLabelSize: CGFloat!
        
        if SharedEnvironment.Instance().isPad() {
        
            startButtonRect = CGRectMake(0, 0, 288, 288)
            startButtonCenter = CGPointMake(CGRectGetMidY(self.view.frame), 560)

            spotrekLogoRect = CGRectMake(0, 0, self.view.frame.size.height, 200)
            spotrekLogoCenter = CGPointMake(CGRectGetMidY(self.view.frame), 144)
            
            unlockWorldCenter = CGPointMake(734, 234)
            unlockWorldLabelRect = CGRectMake(0, 0, 240, 26)
            
            takeOffLabelRect = CGRectMake(0, 0, 108, 26)
            
            unlockWorldLabelSize = 24.0
            takeOffLabelSize = 22.0
            
        } else {
            
        }
        
        let imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/image1.jpg")
        println(imagePath)

        backgroundImage = UIImageView(image: UIImage(contentsOfFile: imagePath))
        backgroundImage.userInteractionEnabled = true
        backgroundImage.alpha = 1.0
        self.view.addSubview(backgroundImage)
        
        startButton = RingButton(frame: startButtonRect, color: UIColor.blueColor(), highlightColor: UIColor.blackColor())
        startButton.center = startButtonCenter
        startButton.keepsHighlightedState = true
        startButton.allowGestures = false
        startButton.alpha = 1.0
        startButton.exclusiveTouch = true
        startButton.delegate = self
        backgroundImage.addSubview(startButton)
    }
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true
        self.title = "Home"

    }

    override func didReceiveMemoryWarning() {
    
        super.didReceiveMemoryWarning()

    }
    
    //MARK: Touches
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
        if (event.touchesForView(self.view)?.count > 1 ) {


            
        } else {

                navigationDelegate = YBNavigationControllerDelegate()
                navigationDelegate.typeOfTransition = YBTransitionType.LeftToRight
                navigationDelegate.presentationDuration = 0.3
                navigationDelegate.dismissalDuration = 0.3
                navigationController?.delegate  = navigationDelegate
                let selectTrekView = selectTrekViewController(nibName: nil,bundle: nil)
                selectTrekView.modalPresentationStyle = UIModalPresentationStyle.Custom
                navigationController?.pushViewController(selectTrekView, animated: true)
            
        }
        
    }
    
    
    //MARK: RingButtonDelegate

    func RingButtonSingleTap(sender: AnyObject) {
        
    }
   
}
