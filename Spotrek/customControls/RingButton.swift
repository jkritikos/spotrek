//
//  RingButton.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 280/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class RingButton: UIView {
    
    var delegate: RingButtonActions!
    
    var paintColor, highlightColor, currentColor: UIColor!
    var ringSize: CGFloat!
    var touchIsActive: Bool!
    var keepsHighlightedState: Bool!
    var allowGestures: Bool!
    var innerCircle: Bool!
    
    override init(frame: CGRect) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clearColor()
        paintColor = UIColor.grayColor()
        highlightColor = UIColor.lightGrayColor()
        ringSize = self.frame.size.height/20
        currentColor = paintColor
        touchIsActive = false
        keepsHighlightedState = false
        allowGestures = false
        self.innerCircle = true
    }
    
    init(frame: CGRect, color: UIColor, highlightColor: UIColor) {
        super.init(frame: frame)

        self.backgroundColor = UIColor.clearColor()
        paintColor = color
        self.highlightColor = highlightColor
        ringSize = self.frame.size.height/20
        currentColor = paintColor
        touchIsActive = false
        keepsHighlightedState = false
        allowGestures = false
        self.innerCircle = true
    }
    
    init(frame: CGRect, color: UIColor, highlightColor: UIColor, innerCircle: Bool) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
        paintColor = color
        self.highlightColor = highlightColor
        ringSize = self.frame.size.height/20
        currentColor = paintColor
        touchIsActive = false
        keepsHighlightedState = false
        allowGestures = false
        self.innerCircle = innerCircle
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
        let context = UIGraphicsGetCurrentContext();
        
        //set the line width equal to the size of the ring we want to draw
        CGContextSetLineWidth(context, ringSize);
        
        //set the stroke Color
        CGContextSetStrokeColorWithColor(context,
            currentColor.CGColor);
        
        //Draw the ring
        let rectangle = CGRectMake(ringSize/2, ringSize/2, self.frame.size.width-ringSize , self.frame.size.height-ringSize);
        CGContextAddEllipseInRect(context, rectangle);
        CGContextStrokePath(context);
        
        
        if innerCircle! {
            //draw the inner circle
            let factor: CGFloat = 2.3; //the disrance between outer ring and inner circle compared to ring size
            let innerRectangle = CGRectMake(factor*ringSize, factor*ringSize, self.frame.size.width-2*factor*ringSize, self.frame.size.height-2*factor*ringSize);
            CGContextAddEllipseInRect(context, innerRectangle);
            
            //set the fill color
            CGContextSetFillColorWithColor(context, currentColor.CGColor);
            
            CGContextFillPath(context);
        }
    }
    
    override func gestureRecognizerShouldBegin(gestureRecognizer: UIGestureRecognizer) -> Bool {
        return allowGestures
    }

    //MARK: Touches
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        touchIsActive = true
        currentColor = highlightColor
        self.alpha = 0.7
        self.setNeedsDisplay()
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        if touchIsActive! {
            currentColor = paintColor
        
            if !keepsHighlightedState {
                self.alpha = 1.0
                self.setNeedsDisplay()
            }
            
                delegate.ringButtonSingleTap(self)
        }
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {
        touchIsActive = false
        currentColor = paintColor
        self.alpha = 1.0
        self.setNeedsDisplay()
    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {
        
        let touch = touches.anyObject() as UITouch
        let location = touch.locationInView(self)
        let distance = MathHelpers.CGPointDistance(location, point2: CGPointMake(self.frame.size.width/2, self.frame.size.height/2))
        
        if distance > self.frame.size.height/2 {
            self.touchesCancelled(touches, withEvent: event)
        }
    }
}
