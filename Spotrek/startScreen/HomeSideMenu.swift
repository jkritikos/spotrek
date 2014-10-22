//
//  HomeSideMenu.swift
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
        
        //Gallery button
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/menu/gallery.png")
        let galleryButtonImage = UIImage(contentsOfFile: imagePath)
        galleryButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        galleryButton.frame = CGRectMake(0, 0, galleryButtonImage.size.width, galleryButtonImage.size.height)
        galleryButton.center = CGPointMake(self.frame.size.width/2, startY+dY)
        galleryButton.setImage(galleryButtonImage, forState: UIControlState.Normal)
        galleryButton.addTarget(self, action: "buttonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        galleryButton.exclusiveTouch = true
        galleryButton.tag = HomeSideMenuButtonType.Gallery.toRaw()
        self.addSubview(galleryButton)
        
        //Settings button
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/menu/settings.png")
        let settingsButtonImage = UIImage(contentsOfFile: imagePath)
        settingsButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        settingsButton.frame = CGRectMake(0, 0, settingsButtonImage.size.width, settingsButtonImage.size.height)
        settingsButton.center = CGPointMake(self.frame.size.width/2, startY+2*dY)
        settingsButton.setImage(settingsButtonImage, forState: UIControlState.Normal)
        settingsButton.addTarget(self, action: "buttonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        settingsButton.exclusiveTouch = true
        settingsButton.tag = HomeSideMenuButtonType.Settings.toRaw()
        self.addSubview(settingsButton)
        
        //Store button
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/menu/store.png")
        let storeButtonImage = UIImage(contentsOfFile: imagePath)
        storeButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        storeButton.frame = CGRectMake(0, 0, storeButtonImage.size.width, storeButtonImage.size.height)
        storeButton.center = CGPointMake(self.frame.size.width/2, startY+3*dY)
        storeButton.setImage(storeButtonImage, forState: UIControlState.Normal)
        storeButton.addTarget(self, action: "buttonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        storeButton.exclusiveTouch = true
        storeButton.tag = HomeSideMenuButtonType.Store.toRaw()
        self.addSubview(storeButton)
        
        //Hints button
        imagePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("home/menu/hints.png")
        let hintsButtonImage = UIImage(contentsOfFile: imagePath)
        hintsButton = UIButton.buttonWithType(UIButtonType.Custom) as UIButton
        hintsButton.frame = CGRectMake(0, 0, hintsButtonImage.size.width, hintsButtonImage.size.height)
        hintsButton.center = CGPointMake(self.frame.size.width/2, startY+4*dY)
        hintsButton.setImage(hintsButtonImage, forState: UIControlState.Normal)
        hintsButton.addTarget(self, action: "buttonWasPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        hintsButton.exclusiveTouch = true
        hintsButton.tag = HomeSideMenuButtonType.Hints.toRaw()
        self.addSubview(hintsButton)

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
