//
//  ProfileSummaryHeaderView.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/22/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class ProfileSummaryHeaderView: UIView, RingButtonActions {
    
    var nameLabel: UILabel!
    var locationLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = UIColor.blackColor()
        
        //add components
        buildView()
    }
    
    func buildView(){
        var singleton = SharedEnvironment.Instance()
        var currentUser = singleton.currentUser
        var trekLevelColor = singleton.trekColors[currentUser.currentLevel!]
        
        var userIcon = UIImageView(image: UIImage(named: "images/ipad/profile/profile_icon.png"))
        userIcon.center = CGPointMake(46,56)
        self.addSubview(userIcon)

        nameLabel = UILabel(frame: CGRectMake(96, 28, 250, 30))
        nameLabel.textColor = UIColor(hex:trekLevelColor!)
        nameLabel.textAlignment = NSTextAlignment.Left
        nameLabel.font = UIFont(name: "GillSans", size: 23.0)
        nameLabel.text = SharedEnvironment.Instance().currentUser.name
        
        locationLabel = UILabel(frame: CGRectMake(96, 55, 250, 30))
        locationLabel.textColor = UIColor.whiteColor()
        locationLabel.textAlignment = NSTextAlignment.Left
        locationLabel.font = UIFont(name: "GillSans", size: 19.0)
        locationLabel.text = SharedEnvironment.Instance().currentUser.currentLocation
        
        var buttonXValue:CGFloat = 600
        let buttonOffset:CGFloat = 46
        var tmpTrekButton:RingButton!
        for (levelName, colorHex) in singleton.trekColors {
            var trekColor = UIColor(hex: colorHex)
            
            tmpTrekButton = RingButton(frame: CGRectMake(buttonXValue, 38, 38, 38), color: trekColor, highlightColor: trekColor)
            tmpTrekButton.keepsHighlightedState = false
            tmpTrekButton.allowGestures = false
            tmpTrekButton.exclusiveTouch = true
            tmpTrekButton.delegate = self
            self.addSubview(tmpTrekButton)
            
            buttonXValue += buttonOffset
        }
        
        
        
        self.addSubview(nameLabel)
        self.addSubview(locationLabel)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func ringButtonSingleTap(sender: AnyObject){
        
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
