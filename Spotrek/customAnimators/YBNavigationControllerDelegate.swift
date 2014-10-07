//
//  YBNavigationControllerDelegate.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class YBNavigationControllerDelegate:NSObject,UINavigationControllerDelegate{
    
    var animator:YBBasicAnimator!
    let right2LeftAnimator:YBRightToLeftAnimator!
    let crossDisolveAnimator:YBCrossDisolveAnimator!
    var typeOfTransition:YBTransitionType
    var presentationDuration:NSTimeInterval!
    var dismissalDuration:NSTimeInterval!
    
    override init() {
   
        right2LeftAnimator = YBRightToLeftAnimator()
        crossDisolveAnimator =  YBCrossDisolveAnimator()
        typeOfTransition = YBTransitionType.RightToLeft
        animator = right2LeftAnimator
        presentationDuration=0.3
        dismissalDuration=0.3
    
    }
    

    //This function returns the Animator that will be used for the transition
    func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!{
        
        switch typeOfTransition {
            
        case .RightToLeft:
            
            animator = right2LeftAnimator
        
        case .CrossDisolve:
            
            animator = crossDisolveAnimator
            
        default:
            
            animator = right2LeftAnimator
            
        }
        
        switch operation {
            
        case .Push:
            
                animator.isPresenting=true
            
        case .Pop:
            
                animator.isPresenting=false
            
        default:
            
                animator.isPresenting=false
            
        }
        
            animator.presentationDuration = presentationDuration
            animator.dismissalDuration = dismissalDuration
        
        return animator
        
    }


    
    func navigationController(navigationController: UINavigationController, willShowViewController viewController: UIViewController, animated: Bool){
    
    
    }
    
    
}