//
//  MathHelpers.swift
//  Milliseconds
//
//  Created by Markos Hatzitaskos on 256/9/14.
//  Copyright (c) 2014 Markos Hatzitaskos. All rights reserved.
//

import Foundation
import UIKit

class MathHelpers {
    class func degreesToRadians(number: CGFloat) -> CGFloat {
        
        return number/180*CGFloat(M_PI)
    }
    
    class func CGPointAdd(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x + point2.x, y: point1.y + point2.y);
    }
    
    class func CGPointSubtract(point1: CGPoint, point2: CGPoint) -> CGPoint {
        return CGPoint(x: point1.x - point2.x, y: point1.y - point2.y);
    }
    
    class func CGPointDistance(point1: CGPoint, point2: CGPoint) -> CGFloat {
        let dx = point1.x - point2.x;
        let dy = point1.y - point2.y;
        return sqrt(dx*dx + dy*dy);
    }

}

