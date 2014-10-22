//
//  ActionsTableViewCell.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/20/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class ActionsTableViewCell: UITableViewCell,UINamedController {
    
    var rightImageView:UIImageView!
    var currentImage:UIImage?
    var rightImage:UIImage!
    var rightImagePressed:UIImage!
    var mainLabel:UILabel!
    var name = "ActionsTableViewCell"
    
    private let singleton = SharedEnvironment.Instance()

    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
        
    }
    
    override func setHighlighted(highlighted: Bool, animated: Bool) {
    
        if highlighted {
        
            rightImageView.image = rightImagePressed
        
        }else{
        
            rightImageView.image = rightImage
        
        
        }
        
    }


    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        var imageBasePath = SharedEnvironment.Instance().resourcePath().stringByAppendingPathComponent("trekStatus/buttons")
        var cellImagePath = imageBasePath.stringByAppendingPathComponent("selectA.png")
        var cellImagePathSelected = imageBasePath.stringByAppendingPathComponent("selectB.png")
        
     
        var rowHeight:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "cellHeight").floatValue)
        var labelOffsetX:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "labelOffsetX").floatValue)
        var fontSize:CGFloat! = CGFloat(singleton.plistElement(self.name, elementName: "fontSize").floatValue)
        
        
        //init mainLabel
        mainLabel = UILabel(frame: CGRectMake(labelOffsetX, 0, self.frame.size.width, rowHeight))
        self.selectionStyle = UITableViewCellSelectionStyle.None
        self.backgroundColor = UIColor.clearColor()
        mainLabel.backgroundColor = UIColor.clearColor()
        mainLabel.textColor = UIColor.whiteColor()
        mainLabel.textAlignment = NSTextAlignment.Left
        mainLabel.numberOfLines = 3
        mainLabel.font = UIFont(name: "GillSans", size: fontSize)
        self.addSubview(mainLabel)

        var dottedLine:DottedLine! = DottedLine(frame: CGRectMake(mainLabel.frame.origin.x,rowHeight-2,mainLabel.frame.size.width,2) , strokeColor: UIColor.whiteColor(), direction: Direction.Horizontal)
        self.addSubview(dottedLine)
        
        
        
        rightImage = UIImage(contentsOfFile: cellImagePath)
        rightImagePressed = UIImage(contentsOfFile: cellImagePathSelected)
        currentImage = rightImage
        
        rightImageView = UIImageView(image: rightImage)
        rightImageView.center = CGPointMake(mainLabel.frame.origin.x + mainLabel.frame.size.width - rightImageView.frame.size.width , rowHeight/2)
        
        self.addSubview(rightImageView)
        
       
        
        
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


}
