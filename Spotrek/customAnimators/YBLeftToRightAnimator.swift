//
//  YBLeftToRightAnimator.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 280/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class YBLeftToRightAnimator: YBBasicAnimator {
    
    
    
    override func performPresentAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        
        //move target view to the right end of the screen
        toViewController.view.frame = CGRectMake(-inView.frame.size.width, inView.frame.origin.y, toViewController.view.frame.size.width, toViewController.view.frame.size.height)
        
        
        //add target view to container view
        inView.addSubview(toViewController.view)
        
        
        
        //define animation to be performed
        var presentAnimationBlock:()->Void=({
            
            //move target view to start of the screen
            self.toViewController.view.frame = CGRectMake(0,0, self.toViewController.view.frame.size.width, self.toViewController.view.frame.size.height)
            
        })
        
        
        //define actions for completion
        var completionBlock:(value:Bool)->Void = ({(value:Bool) in
            
            transitionContext.completeTransition(true)
            
        })
        
        //run the animation
        UIView.animateWithDuration(presentationDuration, presentAnimationBlock, completionBlock)
        
    }
    
    
    
    override  func performDismissAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        //position target view in place
        toViewController.view.frame = CGRectMake(0, 0, toViewController.view.frame.size.width, toViewController.view.frame.size.height)
        inView.insertSubview(toViewController.view, belowSubview:fromViewController.view)
        
        
        //define animation to be performed
        var dismissAnimationBlock:()->Void=({
            
            //move fromview out of the screen
            self.fromViewController.view.frame = CGRectMake(-self.fromViewController.view.frame.size.width,0, self.fromViewController.view.frame.size.width, self.fromViewController.view.frame.size.height)
            
        })
        
        //define actions for completion
        var completionBlock:(value:Bool)->Void = ({(value:Bool) in
            
            transitionContext.completeTransition(true)
            
        })
        
        //run the animation
        UIView.animateWithDuration(dismissalDuration, dismissAnimationBlock, completionBlock)
        
        
    }
    
    
    
    
}


