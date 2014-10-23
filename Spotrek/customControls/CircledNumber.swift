//
//  CircledNumber.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 296/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class CircledNumber: UIView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.clearColor()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        // Set the radius
        let strokeWidth = 2.0
        let radius = CGFloat((CGFloat(self.frame.size.width) - CGFloat(strokeWidth)) / 2)
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(2.0))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, UIColor.blackColor().CGColor)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), 2*CGFloat(M_PI), CGFloat(0), 0)
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
    }
    

}
