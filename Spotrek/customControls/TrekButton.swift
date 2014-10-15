//
//  TrekButton.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/9/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class TrekButton: RingButton {

    var trek:Trek!
    private var nameLabel:UILabel!
    private var completionLabel:UILabel!
    private var trekImage:UIImage!
    
   
    override init(frame: CGRect) {
      
        super.init(frame: frame)

    }
    
    init(frame:CGRect, trek:Trek ){
        
        
        var color1: UIColor!
        var color2: UIColor!
        
        if trek.isLocked {
            
            color1 = UIColor.clearColor()
            color2 = UIColor.clearColor()
            
        
        }else{
            
            color1 = trek.color
            color2 = trek.highlightColor
        }
        
        super.init(frame: frame, color: color1, highlightColor: color2)
        self.trek = trek
        
        
        initNameLabel()
        initCompletionLabel()
        initImages()

    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    func initNameLabel(){
    
        nameLabel = UILabel(frame: CGRectMake(0, 0, 134, 32))
        nameLabel.center = CGPointMake(self.frame.size.width/2, 142)
        nameLabel.font = UIFont(name: "GillSans", size:28.0)
        nameLabel.textColor = UIColor.whiteColor()
        nameLabel.textAlignment = NSTextAlignment.Center
        self.addSubview(nameLabel)
        nameLabel.text = self.trek.name
    
    
    }
    
    func initCompletionLabel(){
    
        if trek.isLocked || trek.isCompleted {
           
            
           
            return
        
       
        }else{
        
            completionLabel = UILabel(frame: CGRectMake(0, 0, self.frame.size.width, 30))
            completionLabel.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
            completionLabel.textAlignment = NSTextAlignment.Center
            completionLabel.textColor = UIColor.whiteColor()
            
            self .addSubview(completionLabel)
            
            var str:String!
            
            if trek.percentComplete == 0 {
                
                str = "TREK"
                completionLabel.font = UIFont(name: "GillSans", size: 20.0)
            
            }
            
            else{
                
                str = NSString(format: "%i%%", trek.percentComplete )
                completionLabel.font = UIFont(name: "GillSans-Bold", size: 20.0)
            }
            
            completionLabel.text = str
        
        }
        
        
    
    
    }
    
    func initImages(){
    
        if trek.isLocked {
        
                let imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("trekSelection/locked.png")
                let bgImage = UIImage(contentsOfFile: imagePath)
                let bgImageView = UIImageView(image: bgImage)
                self.addSubview(bgImageView)

                self.userInteractionEnabled = false

            return
        }
        
        if self.trek.isCompleted {
            let imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("trekSelection/tick.png")
            let tickImage = UIImage(contentsOfFile: imagePath)
            let tickImageView = UIImageView(image:tickImage)
            tickImageView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
            self.addSubview(tickImageView)
            //TODO: add completed image as background image
        }
        
    }
    
}


