//
//  ProfileLevelsViewController.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/22/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class ProfileLevelsViewController: UIViewController {
    
    //navigation components
    var navigationDelegate:NavigationControllerDelegate!
    var savedTransitionType: TransitionType!
    var savedDismissalDuration : NSTimeInterval!
    
    override func loadView() {
        var singleton = SharedEnvironment.Instance()
        var currentUser = singleton.currentUser
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.blackColor()
        
        //header view
        var headerView = ProfileSummaryHeaderView(frame: CGRectMake(0, 0, self.view.frame.width, 112))
        self.view.addSubview(headerView)
        
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as NavigationControllerDelegate
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
            
            
        } else{
            
            
            
        }
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */

}
