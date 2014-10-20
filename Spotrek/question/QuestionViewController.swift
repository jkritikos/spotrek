//
//  QuestionViewController.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 293/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UINamedController {

    var name = "questionViewController"
    private let singleton = SharedEnvironment.Instance()
    private var navigationDelegate:NavigationControllerDelegate!
    private var savedTransitionType: TransitionType!
    private var savedDismissalDuration : NSTimeInterval!

    //UI Elements
    var backgroundImage: UIImageView!
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.blackColor()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.title = "Question"
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as NavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration
        
        initBackground()
    }
    
    func initBackground() {
        
        //Initializing background image
        var imagePath = singleton.resourcePath().stringByAppendingPathComponent("trek1Images/1.jpg")
        backgroundImage = UIImageView(image: UIImage(contentsOfFile: imagePath))
       // backgroundImage.userInteractionEnabled = true
        backgroundImage.alpha = 0.2
        self.view.addSubview(backgroundImage)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        
        if (event.touchesForView(self.view)?.count > 1    ) {
            
            //restore saved values
            navigationDelegate.dismissalDuration = savedDismissalDuration
            navigationDelegate.typeOfTransition = savedTransitionType
            navigationController?.popViewControllerAnimated(true)
            
            
        }else{
            
            
            
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue!, sender: AnyObject!) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
