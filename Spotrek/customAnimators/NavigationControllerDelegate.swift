//
//  YBNavigationControllerDelegate.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class NavigationControllerDelegate:NSObject,UINavigationControllerDelegate{
    
    var animator:BasicAnimator!
    
    let left2RightAnimator:LeftToRightAnimator!
    let right2LeftAnimator:RightToLeftAnimator!
    let crossDisolveAnimator:CrossDisolveAnimator!
    
    var typeOfTransition:TransitionType
    var presentationDuration:NSTimeInterval!
    var dismissalDuration:NSTimeInterval!
    
    override init() {
   
        left2RightAnimator = LeftToRightAnimator()
        right2LeftAnimator = RightToLeftAnimator()
        crossDisolveAnimator =  CrossDisolveAnimator()
        typeOfTransition = TransitionType.RightToLeft
        animator = right2LeftAnimator
        presentationDuration=0.3
        dismissalDuration=0.3
    
    }
    

    //This function returns the Animator that will be used for the transition
    func navigationController(navigationController: UINavigationController!, animationControllerForOperation operation: UINavigationControllerOperation,
        fromViewController fromVC: UIViewController!, toViewController toVC: UIViewController!) -> UIViewControllerAnimatedTransitioning!{
        
        switch typeOfTransition {
        
        case .LeftToRight:
            
            animator = left2RightAnimator
            
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