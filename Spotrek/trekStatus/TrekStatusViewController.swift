//
//  TrekStatusViewController.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/5/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class TrekStatusViewController: UIViewController,UINamedController, UITableViewDataSource,UITableViewDelegate{
    
    var name = "trekStatusViewController"
    private let singleton = SharedEnvironment.Instance()

    private var navigationDelegate:NavigationControllerDelegate!
    private var savedTransitionType: TransitionType!
    private var savedDismissalDuration : NSTimeInterval!
    
    
    private var currentTrek:Trek!
    private var btnPlay:UIButton!
    
    
    private var leftView:UIView!
    private var rightView:UIView!
  

    private var selectedButton:UIButton?
    
    private var btnInfo:UIButton!
    private var btnActions:UIButton!
    private var btnStats:UIButton!
    private var btnStore:UIButton!
    

    private var imageBasePath:String!

    private var infoImagePath:String!
    private var infoImagePathSelected:String!
    
    private var actionsImagePath:String!
    private var actionsImagePathSelected:String!
    
    private var statsImagePath:String!
    private var statsImagePathSelected:String!
    
    private var storeImagePath:String!
    private var storeImagePathSelected:String!
    
    
    private var infoTableView:UITableView!
    private var actionsTableView:UITableView!
    private var statsTableView:UITableView!
    private var storeTableView:UITableView!
    
    
    
    override func loadView() {
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor.blackColor()
        
    }
    

    override func viewDidLoad() {
    
        super.viewDidLoad()
        self.title = "Trek Status"
        self.view.multipleTouchEnabled = true
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as NavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration
        // Do any additional setup after loading the view.
        initTrekButton()
        initLine1()
        initStatusLabel()
        initLine2()
        initPlayButton()
        initSideViews()
        initPaths()
        initButtons()
    
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func initTrekButton(){
    

        currentTrek = SharedEnvironment.Instance().currentTrek

        var btnTrek:TrekButton!
        
        if singleton.isPad() {
            
            var rectCoordinates = singleton.frameForImage(self.name, imageName: "btnTrek")
            btnTrek = TrekButton(frame: CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height), trek: currentTrek)
            var centerCoordinates = singleton.centerForImage(self.name, imageName: "btnTrek")
            btnTrek.center = CGPointMake(CGRectGetMidX(self.view.frame), centerCoordinates.y)
        }

        btnTrek.allowGestures=false
        btnTrek.userInteractionEnabled=false
        self.view.addSubview(btnTrek)
    
    }
    
    
    func initLine1(){
    
        var height:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineHeight").floatValue)
        var centerY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineCenterY1").floatValue)
        var line1:DottedLine! = DottedLine(frame: CGRectMake(0, 0, self.view.frame.size.width,height), strokeColor: UIColor.lightGrayColor())
        line1.center = CGPointMake(self.view.frame.size.width/2,centerY)
        self.view.addSubview(line1)
    
    }
    
   
    func initStatusLabel(){

        var lblStatus :UILabel!
        
        var rectCoordinates = singleton.frameForImage(self.name, imageName: "lblStatus")
        lblStatus = UILabel(frame: CGRectMake(rectCoordinates.x, rectCoordinates.y, rectCoordinates.width, rectCoordinates.height))
        lblStatus.center = CGPointMake(CGRectGetMidX(self.view.frame), CGRectGetMidY(self.view.frame))
        var fontSize1:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "lblStatusFontSize1").floatValue)
        var fontSize2:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "lblStatusFontSize2").floatValue)
        var fontSize3:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "lblStatusFontSize3").floatValue)

        

        lblStatus.numberOfLines=3
        var placesToUnlock:Int! = (100 - currentTrek.percentComplete)
        var statusLine1:NSMutableAttributedString! = NSMutableAttributedString(string: String(placesToUnlock))
        
        var lblStatusFont1:UIFont! = UIFont(name: "HelveticaNeue-Bold", size:fontSize1)
        var range1:NSRange! = NSMakeRange(0, statusLine1.length)
        statusLine1.addAttribute(NSFontAttributeName, value: lblStatusFont1, range: range1)
        
        var statusLine2:NSMutableAttributedString! = NSMutableAttributedString(string:"\nPLACES")
        var lblStatusFont2:UIFont! = UIFont(name: "HelveticaNeue", size: fontSize2)
        var range2:NSRange! = NSMakeRange(0, statusLine2.length)
        statusLine2.addAttribute(NSFontAttributeName, value: lblStatusFont2, range: range2)
    
        var statusLine3:NSMutableAttributedString! = NSMutableAttributedString(string:"\nTO UNLOCK")
        var lblStatusFont3:UIFont! = UIFont(name: "HelveticaNeue", size: fontSize3)
        var range3:NSRange! = NSMakeRange(0, statusLine3.length)
        statusLine3.addAttribute(NSFontAttributeName, value: lblStatusFont3, range: range3)
        
        
        lblStatus.textAlignment=NSTextAlignment.Center
        lblStatus.textColor=UIColor.whiteColor()
        
        statusLine2.appendAttributedString(statusLine3)
        statusLine1.appendAttributedString(statusLine2)
        lblStatus.attributedText = statusLine1

        self.view.addSubview(lblStatus)
        
        
    
    }

    
    func initLine2(){
        
        var height:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineHeight").floatValue)
        var centerY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "dottedLineCenterY2").floatValue)
        var line2:DottedLine! = DottedLine(frame: CGRectMake(0, 0, self.view.frame.size.width,height), strokeColor: UIColor.lightGrayColor())
        line2.center = CGPointMake(self.view.frame.size.width/2,centerY)
        self.view.addSubview(line2)
        
    }


    func initPlayButton(){
    
    
        var btnPlay:UIButton!
        var rectCoordinates = singleton.frameForImage(self.name, imageName: "btnPlay")
        btnPlay = UIButton(frame: CGRectMake(0, 0, rectCoordinates.width, rectCoordinates.height))
        btnPlay.titleLabel?.numberOfLines=2
        btnPlay.titleLabel?.textAlignment=NSTextAlignment.Center
        var fontSize:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "btnPlayFontSize").floatValue)
        btnPlay.titleLabel?.font = UIFont(name: "GillSans", size: fontSize)
        btnPlay.setTitle("PLAY\nNOW", forState: UIControlState.Normal)
        btnPlay.setTitleColor(currentTrek.color, forState: UIControlState.Normal)
        btnPlay.setTitleColor(currentTrek.highlightColor, forState: UIControlState.Highlighted)
        UIControlState.Normal
        var centerCoordinates = singleton.centerForImage(self.name, imageName: "btnPlay")
        btnPlay.center = CGPointMake(CGRectGetMidX(self.view.frame), centerCoordinates.y)
        btnPlay.addTarget(self, action:"btnPlay:" , forControlEvents: UIControlEvents.TouchUpInside)
        self.view.addSubview(btnPlay)
    
    
    }
    
    
    
    func initPaths(){
    
    
        imageBasePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("trekStatus/buttons")
        infoImagePath = imageBasePath.stringByAppendingPathComponent("infoA.png")
        infoImagePathSelected = imageBasePath.stringByAppendingPathComponent("infoB.png")
        
        actionsImagePath = imageBasePath.stringByAppendingPathComponent("actionsA.png")
        actionsImagePathSelected  = imageBasePath.stringByAppendingPathComponent("actionsB.png")
        
        statsImagePath = imageBasePath.stringByAppendingPathComponent("statsA.png")
        statsImagePathSelected = imageBasePath.stringByAppendingPathComponent("statsB.png")
        
        storeImagePath = imageBasePath.stringByAppendingPathComponent("storeA.png")
        storeImagePathSelected = imageBasePath.stringByAppendingPathComponent("storeB.png")
        
    
    }
    
    
    func initButtons(){
        
    
        
    
     
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
        var sideButtonOffsetY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "sideButtonOffsetY").floatValue)
        
        
        var buttonImage:UIImage!
        var buttonSelectedImage:UIImage!
        
        buttonImage = UIImage(contentsOfFile: infoImagePath)
        buttonSelectedImage = UIImage(contentsOfFile: infoImagePathSelected)
        btnInfo = UIButton(frame: CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height))
        btnInfo.setImage(buttonImage, forState: UIControlState.Normal)
        btnInfo.setImage(buttonSelectedImage, forState: UIControlState.Selected)
        btnInfo.selected = false
        btnInfo.center = CGPointMake(leftView.frame.size.width/2 + offsetX/2 , sideButtonOffsetY)
        btnInfo.alpha = 0
        btnInfo.addTarget(self, action: "sideButtonWasTapped:", forControlEvents: UIControlEvents.TouchUpInside)
        
        self.leftView.addSubview(btnInfo)
        
        
        buttonImage = UIImage(contentsOfFile: statsImagePath)
        buttonSelectedImage = UIImage(contentsOfFile: statsImagePathSelected)
        btnStats = UIButton(frame: CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height))
        btnStats.setImage(buttonImage, forState: UIControlState.Normal)
        btnStats.setImage(buttonSelectedImage, forState: UIControlState.Selected)
        btnStats.selected = false
        btnStats.center = CGPointMake(leftView.frame.size.width/2 + offsetX/2 , self.view.frame.size.height - sideButtonOffsetY)
        btnStats.alpha = 0
        btnStats.addTarget(self, action: "sideButtonWasTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        self.leftView.addSubview(btnStats)

        
        
        
        
        buttonImage = UIImage(contentsOfFile: actionsImagePath)
        buttonSelectedImage = UIImage(contentsOfFile: actionsImagePathSelected)
        btnActions = UIButton(frame: CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height))
        btnActions.setImage(buttonImage, forState: UIControlState.Normal)
        btnActions.setImage(buttonSelectedImage, forState: UIControlState.Selected)
        btnActions.selected = false
        btnActions.center = CGPointMake(rightView.frame.size.width/2 - offsetX/2, sideButtonOffsetY)
        btnActions.alpha = 0
        btnActions.addTarget(self, action: "sideButtonWasTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        self.rightView.addSubview(btnActions)

        
        buttonImage = UIImage(contentsOfFile: storeImagePath)
        buttonSelectedImage = UIImage(contentsOfFile: storeImagePathSelected)
        btnStore = UIButton(frame: CGRectMake(0, 0, buttonImage.size.width, buttonImage.size.height))
        btnStore.setImage(buttonImage, forState: UIControlState.Normal)
        btnStore.setImage(buttonSelectedImage, forState: UIControlState.Selected)
        btnStore.selected = false
        btnStore.center = CGPointMake(rightView.frame.size.width/2 - offsetX/2, self.view.frame.size.height -  sideButtonOffsetY)
        btnStore.alpha = 0
        btnStore.addTarget(self, action: "sideButtonWasTapped:", forControlEvents: UIControlEvents.TouchUpInside)

        self.rightView.addSubview(btnStore)
        
        
    
    }
    
    func initSideViews(){
    
    
        leftView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width/2 ,self.view.frame.size.height))
        leftView.backgroundColor = currentTrek.color
        self.view.addSubview(leftView)
        
        rightView = UIView(frame: CGRectMake(self.view.frame.size.width/2,0, self.view.frame.size.width/2 ,self.view.frame.size.height))
        rightView.backgroundColor = currentTrek.color
        self.view.addSubview(rightView)
        
    
    
    }

    
    override func viewDidAppear(animated: Bool) {
    
        
        openCurtains()
        
    }

    
    func openCurtains(){
    
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
       
        UIView.animateWithDuration( 0.3) { () -> Void in
            
            self.leftView.center = CGPointMake(self.leftView.center.x - offsetX, self.leftView.center.y)
            self.rightView.center = CGPointMake(self.rightView.center.x + offsetX, self.rightView.center.y)
            self.btnInfo.alpha = 1.0
            self.btnActions.alpha = 1.0
            self.btnStats.alpha = 1.0
            self.btnStore.alpha = 1.0
        }
    
    }
    
    func closeCurtains(popOnCompletion:Bool){
        
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
      
        UIView.animateWithDuration(0.3, animations: { () -> Void in
            
            self.leftView.center = CGPointMake(self.leftView.center.x + offsetX, self.leftView.center.y)
            self.rightView.center = CGPointMake(self.rightView.center.x - offsetX, self.rightView.center.y)
            self.btnInfo.alpha = 0.0
            self.btnActions.alpha = 0.0
            self.btnStats.alpha = 0.0
            self.btnStore.alpha = 0.0

            }, completion: {(Bool) -> Void in
            
                    if popOnCompletion {
                    
                        //restore saved values
                        self.navigationDelegate.dismissalDuration = self.savedDismissalDuration
                        self.navigationDelegate.typeOfTransition = self.savedTransitionType
                        self.navigationController?.popViewControllerAnimated(true)
                    
                    }
        })
        
        
        
        
      
    
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if (event.touchesForView(self.view)?.count > 1 ) {

           self.closeCurtains(true)
        }
    
    
    }
    
    
    func sideButtonWasTapped(sender:UIButton){
    
    
        if selectedButton == sender {
        
            sender.selected = false
            selectedButton = nil
        
        } else {
       
            selectedButton?.selected = false
            selectedButton = sender
            sender.selected = true
        }
    
    
    }
    
    

    //TODO: Add code here to open main game screen
    func btnPlay(sender:UIButton){
        
        var alert:UIAlertView!
        alert = UIAlertView(title: "Oops!", message: "Not implemented yet?\n W H Y ????", delegate: nil, cancelButtonTitle: "I will Fix it ASAP")
        alert.show()
        
    }
    
    
    //MARK: TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
    
        return 0
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        
        
            return cell
    }
    
    
    //MARK: TableViewDelegatge
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? // custom view for header. will be adjusted to default or specified header height
    {
    
        return nil

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
    
    
    }
    

       
}
