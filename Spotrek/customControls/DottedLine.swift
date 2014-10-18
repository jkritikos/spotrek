//
//  DottedLine.swift
//
//  Created by Yannis Belessiotis on 10/18/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class DottedLine: UIView {

    private var dotColor:UIColor!
 
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
    
        var context:CGContextRef = UIGraphicsGetCurrentContext();
        CGContextSetLineWidth(context, self.frame.size.height/2);
        CGContextSetStrokeColorWithColor(context, dotColor.CGColor );
        var dashArray:[CGFloat] = [1.0,3.0] //paint one dot and then leave three empty
        CGContextSetLineDash(context, 0, dashArray, 2); //use context, start from the begining,use the pattern described in dashArray, number of elements in dashArray
        CGContextMoveToPoint(context,0, self.frame.size.height/2);
        CGContextAddLineToPoint(context, self.frame.size.width, self.frame.size.height/2)
        CGContextStrokePath(context);
        
    }
    
    init(frame: CGRect, strokeColor:UIColor) {
        
        super.init(frame: frame)
        self.dotColor = strokeColor
        self.backgroundColor = UIColor.clearColor()
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
    


