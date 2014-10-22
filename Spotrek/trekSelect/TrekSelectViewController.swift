//
//  TrekSelectViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class TrekSelectViewController: UIViewController, RingButtonActions {
    
    let singleton = SharedEnvironment.Instance()
    var navigationDelegate:NavigationControllerDelegate!
    var savedTransitionType: TransitionType!
    var savedDismissalDuration : NSTimeInterval!
    
    //UI components
    var trekScrollView: UIScrollView!
    
    override func loadView() {
        
        self.view = UIView(frame: singleton.appLandscapeFrame)
        self.view.backgroundColor=UIColor.lightGrayColor()
        
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Select Trek"
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as NavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration

        
        
        // build the view
        buildTrekSelectionView()
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func ringButtonSingleTap(sender: AnyObject){
        let button = sender as TrekButton
        SharedEnvironment.Instance().currentTrek = button.trek
        
        //open trek selection screen
        navigationDelegate.typeOfTransition = TransitionType.CrossDisolve
        navigationDelegate.presentationDuration = 0.5
        navigationDelegate.dismissalDuration = 0.5
        navigationController?.delegate  = navigationDelegate
        let trekStatus = TrekStatusViewController(nibName: nil,bundle: nil)
        trekStatus.modalPresentationStyle = UIModalPresentationStyle.Custom
        navigationController?.pushViewController(trekStatus, animated: true)
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
        self.trekScrollView = UIScrollView(frame: CGRectMake(0, 500, self.view.frame.size.width, 200))
        trekScrollView.backgroundColor = UIColor.blackColor().colorWithAlphaComponent(0.8)
        trekScrollView.scrollEnabled = true
        
        populateTrekScrollView()
        
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
            var trekButton = TrekButton(frame: CGRectMake(currentLeftValue, 20, 108, 108), trek:trek)
            trekButton.delegate = self
            
            self.trekScrollView.addSubview(trekButton)
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
        
        
            
        }
    }
   
}
