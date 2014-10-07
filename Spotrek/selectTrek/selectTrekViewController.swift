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

        
        
        // Do any additional setup after loading the view.
        buildTrekSelectionView()
    }
    
    func buildTrekSelectionView(){
        //top label
        let topLabel = UILabel(frame: CGRectMake(0, 0, self.view.frame.size.width, 70))
        topLabel.text = "START UNLOCKING THE WORLD"
        topLabel.textAlignment = NSTextAlignment.Center
        topLabel.textColor = UIColor.whiteColor()
        topLabel.backgroundColor = UIColor.blackColor()
        
        //bg image
        let backgroundImageView = UIImageView(image: UIImage(named: "images/ipad/trekSelection/image1.jpg"))
        
        //scrollview
        self.trekScrollView = UIScrollView(frame: CGRectMake(0, 600, self.view.frame.size.width, 140))
        trekScrollView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        
        //pws kanw add elements sto scrollview? subviews? me incrementing CGRectMake?
        //pws kane detect poio element patithike mesa sto scrollview?
        //pws apofeugoume ta karfwta strings? .plist?
        //gesture recognizer UITapGestureRecognizer, HitTest
        
        //present
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(topLabel)
        self.view.addSubview(trekScrollView)
    }
    
    //populates the scrollview 
    func populateTrekScrollView(){
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
