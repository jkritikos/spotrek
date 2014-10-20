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
  
   //Side Buttons
    private var selectedButton:UIButton?
    private var btnInfo:UIButton!
    private var btnActions:UIButton!
    private var btnStats:UIButton!
    private var btnStore:UIButton!
    
    //side buttons image paths
    private var imageBasePath:String!
    private var infoImagePath:String!
    private var infoImagePathSelected:String!
    private var actionsImagePath:String!
    private var actionsImagePathSelected:String!
    private var statsImagePath:String!
    private var statsImagePathSelected:String!
    private var storeImagePath:String!
    private var storeImagePathSelected:String!
    
    
    
    
    
    //side buttons expansions
    private var leftRect:CGRect!
    private var rightRect:CGRect!
    
    private var infoContainerView:UIView!
    private var infoTableView:UITableView!
    private var infoDataArray:[String]!
    
    private var actionsContainerView:UIView!
    private var actionsTableView:UITableView!
    private var actionsDataArray:[String]!
    
    private var statsContainerView:UIView!
    private var statsTableView:UITableView!
    private var statsDataArray:[String]!
    
    private var storeContainerView:UIView!
    private var storeTableView:UITableView!
    private var storeDataArray:[String]!
    
    
    
    
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
        initDataArrays()
        initContainerViews()
    
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
    
    
        imageBasePath = singleton.resourcePath().stringByAppendingPathComponent("trekStatus/buttons")
       
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
        
        var buttonImage:UIImage!
        var buttonSelectedImage:UIImage!
       
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
        var sideButtonOffsetY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "sideButtonOffsetY").floatValue)
        
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
    
    func initDataArrays(){
    
        infoDataArray = ["THE MORE PLACES YOU UNLOCK,\nTHE MORE MILES YOU GET","THE MORE MILES YOU HAVE,\n THE MORE HINTS YOU CAN GET","SHARING PLACES\nGIVES YOU MORE MILES","YOU CAN LEARN MORE\nABOUT A PLACE ONCE\nYOU UNLOCK IT","USE YOUR HINTS WISELY\nALONG THIS TREK"]
        
        
        statsDataArray = ["YOU HAVE A TOTAL\nOF .... MILES","YOU HAVE EXPLORED\n ...% OF THIS TREK","YOU ARE CURRENTLY\nA .... "]
        actionsDataArray = ["REDEEM MILES TO GET\nEXTRA HINTS","INVITE FRIENDS SO THAT\nYOU BOTH WIN","VIEW YOUR GALLERY\nAND EXPLORE THE WORLD"]
        storeDataArray = ["storeLine1","storeLine2","storeLine3","storeLine4"]
    }
    
    
    func initSideViews(){
    
    
        leftView = UIView(frame: CGRectMake(0, 0, self.view.frame.size.width/2 ,self.view.frame.size.height))
        leftView.backgroundColor = currentTrek.color
        self.view.addSubview(leftView)
        
        rightView = UIView(frame: CGRectMake(self.view.frame.size.width/2,0, self.view.frame.size.width/2 ,self.view.frame.size.height))
        rightView.backgroundColor = currentTrek.color
        self.view.addSubview(rightView)
        
    
    
    }

    
     func initContainerViews(){
    
        var offsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "curtainOffset").floatValue)
        var sideButtonOffsetY:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "sideButtonOffsetY").floatValue)
        var rowHeight:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "commonTableRowHeight").floatValue)
        
        
        var leftX = offsetX
        var rightX:CGFloat! = 0.0
        var y = sideButtonOffsetY + btnInfo.frame.size.height/2
        var width = leftView.frame.size.width - offsetX
        var height = leftView.frame.size.height - 2*y

        self.leftRect = CGRectMake(leftX,y, width ,height)
        self.rightRect = CGRectMake(rightX, y, width ,height)

    
        infoContainerView = UIView(frame: CGRectMake(leftX, y, width, 0))
        infoContainerView.backgroundColor = UIColor.clearColor()
        infoTableView = UITableView(frame:CGRectMake(0, 0, width, 0),style:UITableViewStyle.Plain)
        infoContainerView.addSubview(infoTableView)
        infoTableView.delegate = self
        infoTableView.dataSource = self
        infoTableView.registerClass(UITableViewCell.classForCoder() , forCellReuseIdentifier: "Cell")
        infoTableView.backgroundColor = UIColor.clearColor()
        infoTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        infoTableView.rowHeight = rowHeight
        infoTableView.reloadData()
        
      
        leftView.addSubview(infoContainerView)
        
        statsContainerView =  UIView(frame: CGRectMake(leftX, y+height, width, 0))
        statsContainerView.backgroundColor = UIColor.clearColor()
        statsTableView = UITableView(frame:CGRectMake(0, 0, width, 0),style:UITableViewStyle.Plain)
        statsContainerView.addSubview(statsTableView)
        statsTableView.delegate = self
        statsTableView.dataSource = self
        statsTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        statsTableView.backgroundColor = UIColor.clearColor()
        statsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        statsTableView.rowHeight = rowHeight
        statsTableView.reloadData()
        leftView.addSubview(statsContainerView)
        
        actionsContainerView = UIView(frame:CGRectMake(rightX, y, width, 0))
        actionsContainerView.backgroundColor = UIColor.clearColor()
        actionsTableView = UITableView(frame:CGRectMake(0, 0, width, 0),style:UITableViewStyle.Plain)
        actionsContainerView.addSubview(actionsTableView)
        actionsTableView.delegate = self
        actionsTableView.dataSource = self
        actionsTableView.registerClass(ActionsTableViewCell.classForCoder(), forCellReuseIdentifier: "ActionsCell")
        actionsTableView.backgroundColor = UIColor.clearColor()
        actionsTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        actionsTableView.rowHeight = rowHeight
        actionsTableView.reloadData()
        
        rightView.addSubview(actionsContainerView)
        
        storeContainerView =  UIView(frame: CGRectMake(rightX, y+height, width, 0))
        storeContainerView.backgroundColor = UIColor.clearColor()
        storeTableView = UITableView(frame:CGRectMake(0, 0, width, 0),style:UITableViewStyle.Plain)
        storeContainerView.addSubview(storeTableView)
        storeTableView.delegate = self
        storeTableView.dataSource = self
        storeTableView.registerClass(UITableViewCell.classForCoder(), forCellReuseIdentifier: "Cell")
        storeTableView.backgroundColor = UIColor.clearColor()
        storeTableView.separatorStyle = UITableViewCellSeparatorStyle.None
        storeTableView.rowHeight = rowHeight
        storeTableView.reloadData()
        rightView.addSubview(storeContainerView)
        
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
    
    //MARK: Expand Shrink SideButton's Selection
    func sideButtonWasTapped(sender:UIButton){
    
        if selectedButton != nil {
            
            self.shrinkSelection()
        
        }
        
        
        if selectedButton == sender {
        
            sender.selected = false
            selectedButton = nil
        
        } else {
       
            selectedButton?.selected = false
            selectedButton = sender
            sender.selected = true
        }
        
        
        if selectedButton != nil {
            
            self.expandSelection()
        }
    }
    
    

    func shrinkSelection(){
    

        var viewToShrink:UIView!
        var targetFrame:CGRect!
        var tableToShrink:UITableView!


        if selectedButton == btnInfo {
        
            viewToShrink = infoContainerView
            tableToShrink = infoTableView
            targetFrame = CGRectMake(leftRect.origin.x, leftRect.origin.y, leftRect.size.width, 0)
        
        } else if selectedButton == btnStats {

            viewToShrink = statsContainerView
            tableToShrink = statsTableView
            targetFrame = CGRectMake(leftRect.origin.x, leftRect.origin.y + leftRect.size.height, leftRect.size.width, 0)

            
        
        } else if selectedButton == btnActions {
            viewToShrink = actionsContainerView
            tableToShrink = actionsTableView
            targetFrame = CGRectMake(rightRect.origin.x, rightRect.origin.y, rightRect.size.width, 0)

        }else if selectedButton == btnStore {
        
            viewToShrink = storeContainerView
            tableToShrink = storeTableView
            targetFrame = CGRectMake(rightRect.origin.x, rightRect.origin.y + rightRect.size.height, rightRect.size.width, 0)

        }
        
    
        spring(1.5, { () -> Void in

            viewToShrink.frame = targetFrame
            tableToShrink.frame = CGRectMake(0, 0, targetFrame.size.width, targetFrame.size.height)
            
        })

        
    }
    
    
    func expandSelection(){


        var viewToExpand:UIView!
        var targetFrame:CGRect!
        var tableToExpand:UITableView!
        
        if selectedButton == btnInfo {
            
            viewToExpand = infoContainerView
            tableToExpand = infoTableView
            targetFrame = leftRect
            
        } else if selectedButton == btnStats {
            
            viewToExpand = statsContainerView
            tableToExpand = statsTableView
            targetFrame = leftRect
            
            
            
        } else if selectedButton == btnActions {
            viewToExpand = actionsContainerView
            tableToExpand = actionsTableView
            targetFrame = rightRect
            
            
        }else if selectedButton == btnStore {
            
            viewToExpand = storeContainerView
            tableToExpand = storeTableView
            targetFrame = rightRect
            
        }
        
        
        spring(1.5, { () -> Void in
            
            viewToExpand.frame = targetFrame
            tableToExpand.frame = CGRectMake(0, 0, targetFrame.size.width, targetFrame.size.height)
        })
        
    
    }
    

    //TODO: Add code here to open main game screen
    func btnPlay(sender:UIButton){
       
        /*
        var alert:UIAlertView!
        alert = UIAlertView(title: "Oops!", message: "Not implemented yet?\n W H Y ????", delegate: nil, cancelButtonTitle: "I will Fix it ASAP")
        alert.show()
        */
        
        navigationDelegate.typeOfTransition = TransitionType.CrossDisolve
        navigationDelegate.presentationDuration = 0.5
        navigationDelegate.dismissalDuration = 0.5
        navigationController?.delegate  = navigationDelegate
        let question = QuestionViewController(nibName: nil,bundle: nil)
        question.modalPresentationStyle = UIModalPresentationStyle.Custom
        navigationController?.pushViewController(question, animated: true)
    }
    
    
    //MARK: TableView DataSource
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
     
        if tableView == infoTableView {
        
            return infoDataArray.count
        
        
        } else if tableView == statsTableView {
        
            return statsDataArray.count

        
        } else if tableView == actionsTableView {
        
        
            return actionsDataArray.count

        
        } else if tableView == storeTableView {
        
            return storeDataArray.count

        
        }
        
        
        
        return 0
    }
    
     func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        //TODO: make header height parametric
        if tableView == statsTableView? || tableView == storeTableView? {
        
           
            return 80

        }

        else {
        
        
            return 0
        }
        
    }
    
    // Row display. Implementers should *always* try to reuse cells by setting each cell's reuseIdentifier and querying for available reusable cells with dequeueReusableCellWithIdentifier:
    // Cell gets various attributes set automatically based on table (separators) and data source (accessory views, editing controls)
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        
        var cell:UITableViewCell!
        var cell1:ActionsTableViewCell!
        var cellIdentifier:String!="Cell"
        var currrentArray:[NSString]!
        
        
        if tableView == actionsTableView {

            cellIdentifier = "ActionsCell"
            cell1 = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as ActionsTableViewCell
      
        }else{
        

            cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as UITableViewCell
            cell.selectionStyle = UITableViewCellSelectionStyle.None
            cell.backgroundColor = UIColor.clearColor()
            cell.textLabel?.backgroundColor = UIColor.clearColor()
            cell.textLabel?.textColor = UIColor.whiteColor()
            cell.textLabel?.textAlignment = NSTextAlignment.Center
            cell.textLabel?.numberOfLines = 3
            cell.textLabel?.font = UIFont(name: "GillSans", size: 18.0)

            
        }
        

        if tableView == infoTableView {
        
            currrentArray = infoDataArray
            cell?.textLabel?.text = currrentArray[indexPath.row]
            return cell


        } else if tableView == statsTableView {
            
            currrentArray = statsDataArray
            cell?.textLabel?.text = currrentArray[indexPath.row]
            return cell

        
        } else if tableView == actionsTableView {
            
            currrentArray =  actionsDataArray
            cell1.mainLabel.text = currrentArray[indexPath.row]
            return cell1

        
        } else if tableView == storeTableView {

            currrentArray = storeDataArray
            cell?.textLabel?.text = currrentArray[indexPath.row]
            return cell

        
        }
        
        return cell
    }
    
    
    //MARK: TableViewDelegatge
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? // custom view for header. will be adjusted to default or specified header height
    {
    
        return UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 1))

    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath){
    
    
    
    }
    

       
}
