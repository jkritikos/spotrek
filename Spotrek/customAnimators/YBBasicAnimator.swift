//
//  YBBasicAnimator.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

//This is the basic animator class 
//All custom animators will extend this class and override the methods performPresentAnimation and performDismissAnimation accordingly


import Foundation
import UIKit

class YBBasicAnimator:NSObject, UIViewControllerAnimatedTransitioning {
    
    var presentationDuration: NSTimeInterval!
    var dismissalDuration: NSTimeInterval!
    var isPresenting:Bool = true
    var inView:UIView!
    var toViewController:UIViewController!
    var fromViewController:UIViewController!
    
    func transitionDuration(transitionContext: UIViewControllerContextTransitioning) -> NSTimeInterval {
        
        if isPresenting {return presentationDuration} else {return dismissalDuration}
    }
    
    override init() {
        
        presentationDuration=0.3
        dismissalDuration=0.3
    }
    
    
    
    func animateTransition(transitionContext: UIViewControllerContextTransitioning) {
        
        inView = transitionContext.containerView()
        fromViewController = transitionContext.viewControllerForKey(UITransitionContextFromViewControllerKey)
        toViewController = transitionContext.viewControllerForKey(UITransitionContextToViewControllerKey)
        
        if isPresenting {
            
            performPresentAnimation(transitionContext)
        }
        else{
            
            performDismissAnimation(transitionContext)
        }
        
        
    }
    
    
    func performPresentAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        //override this function accordingly to implement the required animation
        
    }
    
    
    func performDismissAnimation(transitionContext:UIViewControllerContextTransitioning){
        
        //override this function accordingly to implement the required animation
        
    }
    
    
    
}
