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
        initQuestionButtons()
    }
    
    func initBackground() {
        
        //Initializing background image
        var imagePath = singleton.resourcePath().stringByAppendingPathComponent("trek1Images/1.jpg")
        backgroundImage = UIImageView(image: UIImage(contentsOfFile: imagePath))
       // backgroundImage.userInteractionEnabled = true
        backgroundImage.alpha = 0.2
        self.view.addSubview(backgroundImage)
    }
    
    func initQuestionButtons() {
        
        let questionButton1 = QuestionButton(frame: CGRectMake(0, 0, 410, 77), trek: singleton.currentTrek, questionNumberLabelText: "A")
        questionButton1.center = CGPointMake(CGRectGetMaxX(self.view.frame)-questionButton1.frame.width/2, 420)
        self.view.addSubview(questionButton1)
        
        let questionButton2 = QuestionButton(frame: CGRectMake(0, 0, 410, 77), trek: singleton.currentTrek, questionNumberLabelText: "B")
        questionButton2.center = CGPointMake(CGRectGetMaxX(self.view.frame)-questionButton2.frame.width/2, 505)
        self.view.addSubview(questionButton2)
        
        let questionButton3 = QuestionButton(frame: CGRectMake(0, 0, 410, 77), trek: singleton.currentTrek, questionNumberLabelText: "C")
        questionButton3.center = CGPointMake(CGRectGetMaxX(self.view.frame)-questionButton3.frame.width/2, 590)
        self.view.addSubview(questionButton3)
        
        let questionButton4 = QuestionButton(frame: CGRectMake(0, 0, 410, 77), trek: singleton.currentTrek, questionNumberLabelText: "D")
        questionButton4.center = CGPointMake(CGRectGetMaxX(self.view.frame)-questionButton4.frame.width/2, 675)
        self.view.addSubview(questionButton4)

    }
    
    override func viewDidAppear(animated: Bool) {
        UIView.animateWithDuration(0.5, delay: 0.0, options: UIViewAnimationOptions.CurveEaseOut, animations: {
            self.backgroundImage.alpha = 1.0
            }, completion: {
                finished in
        })
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
