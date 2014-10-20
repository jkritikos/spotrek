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
    var questionNumberLabel: UILabel!
    var questionNumberLabelText: String!

    init(frame: CGRect, trek: Trek, questionNumberLabelText: String) {
        super.init(frame: frame)
        
        self.trek = trek
        self.questionNumberLabelText = questionNumberLabelText
        
        initBackground()
    }
    
    func initBackground() {
        let background = UIView(frame: frame)
        background.backgroundColor = UIColor.blackColor()
        background.alpha = 0.5
        self.addSubview(background)
        
        var dottedLine:DottedLine! = DottedLine(frame: CGRectMake(0, 0, 4, 55), strokeColor: UIColor.whiteColor(), direction: Direction.Vertical)
        dottedLine.center = CGPointMake(70, self.frame.size.height/2)
        self.addSubview(dottedLine)
        
        //Question Number
        questionNumberLabel = UILabel(frame: CGRectMake(0, 0, 70, 80))
        questionNumberLabel.textAlignment = NSTextAlignment.Center
        questionNumberLabel.textColor = trek.color
        questionNumberLabel.font = UIFont(name: "GillSans-Bold", size: 50)
        questionNumberLabel.text = questionNumberLabelText
        questionNumberLabel.alpha = 1.0
        questionNumberLabel.layer.zPosition = 100
        self.addSubview(questionNumberLabel)
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
