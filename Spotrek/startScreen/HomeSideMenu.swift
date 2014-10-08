//
//  homeSideMenu.swift
//  Spotrek
//
//  Created by Markos Hatzitaskos on 281/10/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

enum HomeSideMenuButtonType: Int {
    case None = 0, Profile, Gallery, Settings, Store, Hints
}

class HomeSideMenu: UIView {
    
    var delegate: HomeSideMenuActions!
    
    var isPresent: Bool = false
    var pressedButtonType: HomeSideMenuButtonType!

    var profileButton: UIButton!
    var galleryButton: UIButton!
    var settingsButton: UIButton!
    var storeButton: UIButton!
    var hintsButton: UIButton!
    var startY: CGFloat!
    var dY: CGFloat!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override init() {
        isPresent = false
        
        var myFrame: CGRect!
        
        if SharedEnvironment.Instance().isPad() {
            myFrame = CGRectMake(0, 0, 240, 768)
            startY = 130
            dY = 140
        } else {
            
        }
        
        super.init(frame: myFrame)
        self.backgroundColor = UIColor.blackColor()
        pressedButtonType = HomeSideMenuButtonType.None
        addButtons()
    }
    
    func addButtons() {
        
        //Profile button
        var imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/menu/profile.png")
        let profileButtonImage = UIImage(contentsOfFile: imagePath)
        profileButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        profileButton.frame = CGRectMake(0, 0, profileButtonImage.size.width, profileButtonImage.size.height)
        profileButton.center = CGPointMake(self.frame.size.width/2, startY)
        profileButton.setImage(profileButtonImage, forState: UIControlState.Normal)
        profileButton.addTarget(self, action: "buttonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        profileButton.exclusiveTouch = true
        profileButton.tag = HomeSideMenuButtonType.Profile.toRaw()
        self.addSubview(profileButton)
    }
    
    func buttonWasPressed(sender: UIButton) {
        delegate.homeSideMenuButtonWasPressed(sender)
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
