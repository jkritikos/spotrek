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
