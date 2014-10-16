//
//  profileSummaryViewController.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/16/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class ProfileSummaryViewController: UIViewController {
    
    
    var navigationDelegate:YBNavigationControllerDelegate!
    var savedTransitionType: YBTransitionType!
    var savedDismissalDuration : NSTimeInterval!
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.lightGrayColor()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as YBNavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration
        
        // build the view
        
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
            
            
            
        }
    }
}