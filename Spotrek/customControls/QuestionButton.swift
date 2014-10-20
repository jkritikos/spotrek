//
//  QuestionButton.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 293/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class QuestionButton: UIView {

    let trek: Trek!
    
    init(frame: CGRect, trek: Trek) {
        super.init(frame: frame)
        
        self.trek = trek
        
        initBackground()
    }
    
    func initBackground() {
        let background = UIView(frame: frame)
        background.backgroundColor = UIColor.blackColor()
        background.alpha = 0.5
        self.addSubview(background)
        
        //var dottedLine:DottedLine! = DottedLine(frame: CGRectMake(0, rowHeight-2,mainLabel.frame.size.width,2) , strokeColor: UIColor.whiteColor(), direction: Direction.Horizontal)
        //self.addSubview(dottedLine)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /*
    // Only override drawRect: if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func drawRect(rect: CGRect)
    {
        // Drawing code
    }
    */
    

}
