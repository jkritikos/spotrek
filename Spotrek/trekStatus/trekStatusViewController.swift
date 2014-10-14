//
//  trekStatusViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class trekStatusViewController: UIViewController  {
    
    private var navigationDelegate:YBNavigationControllerDelegate!
    private var savedTransitionType: YBTransitionType!
    private var savedDismissalDuration : NSTimeInterval!
    
    
    private var currentTrek:Trek!
    private var lblStatus :UILabel!
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
        navigationDelegate = navigationController?.delegate as YBNavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration
        // Do any additional setup after loading the view.
        
        initTrekButton()
        
        initStatusLabel()
        
        initSideViews()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initTrekButton(){
    

        currentTrek = SharedEnvironment.Instance().currentTrek
//        currentTrek = Trek(trekNumber:5, percentComplete:0, isLocked:true)
//        currentTrek.isLocked = false
//        currentTrek.isCompleted = false
        
      
        let btnTrek = TrekButton(frame: CGRectMake(0, 0, 110, 110), trek: currentTrek)
        btnTrek.allowGestures=false
        btnTrek.userInteractionEnabled=false
        btnTrek.center = CGPointMake(self.view.frame.size.width/2, 90)
        
        self.view.addSubview(btnTrek)
    
    }
    
    
    func initStatusLabel(){
    
    
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
    
        var offsetX:CGFloat!
        offsetX = 136.0
        
        UIView.animateWithDuration( 0.3) { () -> Void in
            
            self.leftView.center = CGPointMake(self.leftView.center.x - offsetX, self.leftView.center.y)
            self.rightView.center = CGPointMake(self.rightView.center.x + offsetX, self.rightView.center.y)
        }
    
    }
    
    func closeCurtains(){
    
    
    
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if (event.touchesForView(self.view)?.count > 1 ) {

            //restore saved values
            navigationDelegate.dismissalDuration = savedDismissalDuration
            navigationDelegate.typeOfTransition = savedTransitionType
            navigationController?.popViewControllerAnimated(true)
            
        }
    
    
    }

    

       
}
