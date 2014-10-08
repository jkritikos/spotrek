//
//  selectTrekViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class selectTrekViewController: UIViewController {
    
    
    var navigationDelegate:YBNavigationControllerDelegate!
    
    var savedTransitionType: YBTransitionType!
    var savedDismissalDuration : NSTimeInterval!
    
    //UI components
    var trekScrollView: UIScrollView!
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.lightGrayColor()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Trek"
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as YBNavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration

        
        
        // build the view
        buildTrekSelectionView()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func buildTrekSelectionView(){
        //top label
        let topLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 70))
        topLabel.text = "START UNLOCKING THE WORLD"
        topLabel.font = UIFont(name: "GillSans", size: 22.0)
        topLabel.textAlignment = NSTextAlignment.Center
        topLabel.textColor = UIColor.whiteColor()
        topLabel.backgroundColor = UIColor.blackColor()
        
        //bg image
        let backgroundImageView = UIImageView(image: UIImage(named: "images/ipad/trekSelection/image1.jpg"))
        
        //scrollview
        self.trekScrollView = UIScrollView(frame: CGRectMake(0, 500, self.view.frame.size.width, 220))
        trekScrollView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        trekScrollView.scrollEnabled = true
        
        populateTrekScrollView()
        
        //pws kanw add elements sto scrollview? subviews? me incrementing CGRectMake?
        //pws kane detect poio element patithike mesa sto scrollview?
        //pws apofeugoume ta karfwta strings? .plist?
        //gesture recognizer UITapGestureRecognizer, HitTest
        
        //present
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(topLabel)
        self.view.addSubview(trekScrollView)
    }
    
    override func viewDidLayoutSubviews(){
        super.viewDidLayoutSubviews()
        self.trekScrollView.contentSize = CGSize(width:self.trekScrollView.frame.width * 4, height:self.trekScrollView.frame.height)
    }
    
    //populates the scrollview
    func populateTrekScrollView(){
        let leftOffset:CGFloat = 170
        var currentLeftValue:CGFloat = 20
        var trekList = SharedEnvironment.Instance().trekList
        
        for trek in trekList {
            //trek label
            var trekLabel = UILabel(frame: CGRectMake(currentLeftValue, 160, 114, 40))
            trekLabel.text = trek.name
            trekLabel.font = UIFont(name: "GillSans", size: 24.0)
            trekLabel.textAlignment = NSTextAlignment.Center
            trekLabel.textColor = UIColor.whiteColor()
            
//            //trek button
            if(trek.isLocked){
                var trekButton = UIImageView(image: UIImage(named: "images/ipad/trekSelection/locked.png"))
                trekButton.frame = CGRectMake(currentLeftValue, 20, 108, 108)
                self.trekScrollView.addSubview(trekButton)
            } else {
                var frame = CGRectMake(currentLeftValue, 20, 116, 116)
                var trekButton = RingButton(frame: frame, color: UIColor.blueColor(), highlightColor: UIColor.blueColor())
                self.trekScrollView.addSubview(trekButton)
            }
            
            
            self.trekScrollView.addSubview(trekLabel)
            
            currentLeftValue += leftOffset
        }
        
        
    }

    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        if (event.touchesForView(self.view)?.count > 1 ) {
        
            //restore saved values
            navigationDelegate.dismissalDuration = savedDismissalDuration
            navigationDelegate.typeOfTransition = savedTransitionType
            navigationController?.popViewControllerAnimated(true)
            
            
        }else{
        
        
            navigationDelegate = YBNavigationControllerDelegate()
            navigationDelegate.typeOfTransition = YBTransitionType.RightToLeft
            navigationDelegate.presentationDuration = 4
            navigationDelegate.dismissalDuration = 0.9
            navigationController?.delegate  = navigationDelegate
            let trekStatus = trekStatusViewController(nibName: nil,bundle: nil)
            trekStatus.modalPresentationStyle = UIModalPresentationStyle.Custom
            navigationController?.pushViewController(trekStatus, animated: true)
        }
    }
   
}
