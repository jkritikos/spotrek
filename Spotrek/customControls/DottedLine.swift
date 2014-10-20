//
//  DottedLine.swift
//
//  Created by Yannis Belessiotis on 10/18/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class DottedLine: UIView {

    private var dotColor:UIColor!
    private var direction: Direction!
 
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
    
        var context:CGContextRef = UIGraphicsGetCurrentContext();
     
        var lineWidth:CGFloat!
        CGContextSetStrokeColorWithColor(context, dotColor.CGColor );
        
        var dashArray:[CGFloat]!
        
        if direction == Direction.Horizontal {
 
            lineWidth  = self.frame.size.height/2
            CGContextSetLineWidth(context, lineWidth );
            dashArray = [1.0,lineWidth*2]
            CGContextSetLineDash(context, 0, dashArray, 2); //use context, start from the begining,use the pattern described in dashArray, number of elements in dashArray
            CGContextMoveToPoint(context,0, self.frame.size.height/2);
            CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height/2)
        
        } else if direction ==  Direction.Vertical {
        
            lineWidth  = self.frame.size.width/2
            CGContextSetLineWidth(context, lineWidth );
            dashArray = [1.0,lineWidth*2]
            CGContextSetLineDash(context, 0, dashArray, 2); //use context, start from the begining,use the pattern described in dashArray, number of elements in dashArray
            CGContextMoveToPoint(context,self.frame.size.width/2, 0);
            CGContextAddLineToPoint(context, self.frame.size.width/2, self.frame.size.height)
        
        }
     
        CGContextSetLineCap(context, kCGLineCapRound)
        CGContextStrokePath(context);
        
    }
    
    init(frame: CGRect, strokeColor:UIColor, direction: Direction) {
        
        super.init(frame: frame)
        
        self.dotColor = strokeColor
        self.backgroundColor = UIColor.clearColor()
        self.direction = direction
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    


