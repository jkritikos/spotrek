//
//  Hint5050Button.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 296/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class Hint5050Button: UIView {

    var paintColor: UIColor!
    
    init(frame: CGRect, color: UIColor) {
        super.init(frame: frame)
        
        paintColor = color
        self.backgroundColor = UIColor.clearColor()
        
        let circledNumber = CircledNumber(frame: CGRectMake(0, 0, 26, 26))
        circledNumber.center = CGPointMake(53, 16)
        self.addSubview(circledNumber)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect) {
        // Drawing code
        var startAngle: Float = 0.0
        var endAngle: Float = Float(M_PI)
        
        // Drawing code
        // Set the radius
        let strokeWidth = 2.0
        let radius = CGFloat((CGFloat(self.frame.size.width) - CGFloat(strokeWidth)) / 2)
        
        // Get the context
        var context = UIGraphicsGetCurrentContext()
        
        // Find the middle of the circle
        let center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2)
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, paintColor.CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(strokeWidth))
        
        // Set the fill color (if you are filling the circle)
        CGContextSetFillColorWithColor(context, paintColor.CGColor)
        
        // Rotate the angles so that the inputted angles are intuitive like the clock face: the top is 0 (or 2π), the right is π/2, the bottom is π and the left is 3π/2.
        // In essence, this appears like a unit circle rotated π/2 anti clockwise.
        startAngle = startAngle - Float(M_PI_2)
        endAngle = endAngle - Float(M_PI_2)
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(radius)*0.8, CGFloat(startAngle), CGFloat(endAngle), 0)
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathFillStroke) // or kCGPathFillStroke to fill and stroke the circle
        
        // Set the stroke color
        CGContextSetStrokeColorWithColor(context, UIColor.whiteColor().CGColor)
        
        // Set the line width
        CGContextSetLineWidth(context, CGFloat(2.0))
        
        // Draw the arc around the circle
        CGContextAddArc(context, center.x, center.y, CGFloat(radius), 2*CGFloat(M_PI), CGFloat(0), 0)
        
        // Draw the arc
        CGContextDrawPath(context, kCGPathStroke) // or kCGPathFillStroke to fill and stroke the circle
    }
    

}
