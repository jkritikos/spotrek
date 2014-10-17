//
//  YBCrossDisolveAnimator.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation

import Foundation
import UIKit

class CrossDisolveAnimator: BasicAnimator {
    
    
    
    override func performPresentAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        toViewController.view.frame = CGRectMake(0, inView.frame.origin.y, toViewController.view.frame.size.width, toViewController.view.frame.size.height)
        
        toViewController.view.alpha = 0
        fromViewController.view.alpha = 1
        
        inView.insertSubview(toViewController.view, belowSubview: fromViewController.view)
        
        //define animation to be performed
        var presentAnimationBlock:()->Void=({
            
            self.fromViewController.view.alpha = 0.0
            self.toViewController.view.alpha = 1.0
            
        })
        
        
        //define actions for completion
        var completionBlock:(value:Bool)->Void = ({(value:Bool) in
            
            transitionContext.completeTransition(true)
            
        })
        
        //run the animation
        UIView.animateWithDuration(presentationDuration, presentAnimationBlock, completionBlock)
        
    }
    
    
    
    override  func performDismissAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        
        toViewController.view.frame = CGRectMake(0 ,0, toViewController.view.frame.size.width, toViewController.view.frame.size.height)
        inView.insertSubview(toViewController.view, belowSubview:fromViewController.view)
        
        
        //define animation to be performed
        var dismissAnimationBlock:()->Void=({
            
       
            self.fromViewController.view.alpha = 0.0
            self.toViewController.view.alpha = 1.0
            
            
        })
        
        //define actions for completion
        var completionBlock:(value:Bool)->Void = ({(value:Bool) in
            
            transitionContext.completeTransition(true)
            
        })
        
        
        //run the animation
        UIView.animateWithDuration(dismissalDuration, dismissAnimationBlock, completionBlock)
        
        
    }
    
    
    

    
    
    
}