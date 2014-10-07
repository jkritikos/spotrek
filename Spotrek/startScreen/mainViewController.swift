//
//  mainViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/3/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class mainViewController: UIViewController {

    
    var navigationDelegate:YBNavigationControllerDelegate!
    
    
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.blueColor()
        
    }
    
    
    override func viewDidLoad() {
      
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true
        self.title = "Home"

    }

    override func didReceiveMemoryWarning() {
    
        super.didReceiveMemoryWarning()

    }
    
    
    
    
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
      
        if (event.touchesForView(self.view)?.count > 1 ) {


            
        }else{

                navigationDelegate = YBNavigationControllerDelegate()
                navigationDelegate.typeOfTransition = YBTransitionType.RightToLeft
                navigationDelegate.presentationDuration = 0.3
                navigationDelegate.dismissalDuration = 0.3
                navigationController?.delegate  = navigationDelegate
                let selectTrekView = selectTrekViewController(nibName: nil,bundle: nil)
                selectTrekView.modalPresentationStyle = UIModalPresentationStyle.Custom
                navigationController?.pushViewController(selectTrekView, animated: true)
            
        }
        
    }
   
}
