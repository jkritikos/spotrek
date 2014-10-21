//
//  QuestionButton.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 293/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class QuestionButton: UIView {

    var delegate: QuestionButtonActions!
    
    let trek: Trek!
    var background: UIView!
    var questionNumberLabel: UILabel!
    var questionNumber: QuestionNumber!
    var questionNumberLabelText: String! {
        
        switch questionNumber.toRaw() {
        case 1:
            return "A"
        case 2:
            return "B"
        case 3:
            return "C"
        case 4:
            return "D"
        default:
            break;
        }
            
        return ""
    }
    
    var questionLabel: LTMorphingLabel!
    var questionLabelText: String!


    init(frame: CGRect, trek: Trek, questionNumber: QuestionNumber, questionLabelText: String) {
        super.init(frame: frame)
        
        self.trek = trek
        self.questionNumber = questionNumber
        self.questionLabelText = questionLabelText
        
        initBackground()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func initBackground() {
        background = UIView(frame: frame)
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
        
        //Question Text
        questionLabel = LTMorphingLabel(frame: CGRectMake(90, 0, 320, 80))
        questionLabel.textAlignment = NSTextAlignment.Left
        questionLabel.textColor = UIColor.whiteColor()
        questionLabel.font = UIFont(name: "GillSans", size: 30)
        questionLabel.text = questionLabelText
        questionLabel.alpha = 1.0
        questionLabel.layer.zPosition = 100
        self.addSubview(questionLabel)
        
    }
    
    func playCorrectAnswerAnimation() {
        
        let tempText = questionLabel.text
        questionLabel.text = "Correct"
        
        delay(2.0) {
            self.questionLabel.text = tempText
        }
        
    }
    
    func changeBackgroundToColor(color: UIColor) {
        
        UIView.animateWithDuration(0.5, animations: {
            self.background.backgroundColor = color
            self.background.alpha = 1.0
            self.questionNumberLabel.textColor = UIColor.whiteColor()
        })
        
    }
    
    //MARK: Touches
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {

    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        delegate.questionButtonSingleTap(self)
    }
    
    override func touchesCancelled(touches: NSSet!, withEvent event: UIEvent!) {

    }
    
    override func touchesMoved(touches: NSSet, withEvent event: UIEvent) {

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
