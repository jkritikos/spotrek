//
//  ProfileSummaryTableViewCell.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/16/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

class ProfileSummaryTableViewCell: UITableViewCell {

    //UI components
    var optionLabel:UILabel!
    var optionIcon:UIImageView!
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        optionLabel = UILabel(frame: CGRectMake(150,30,500,130))
        optionLabel.numberOfLines = 0
        optionLabel.textColor = UIColor.whiteColor()
        self.addSubview(optionLabel)
        
        optionIcon = UIImageView(image: UIImage(named: "images/ipad/profile/profile_level.png"))
        optionIcon.center = CGPointMake(60,90)
        self.addSubview(optionIcon)
        
        var arrowImage = UIImageView(image: UIImage(named: "images/ipad/profile/arrow_right.png"))
        arrowImage.center = CGPointMake(760,102)
        self.addSubview(arrowImage)
        
        self.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.0)
    }

    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setIcon(name:String){
        self.optionIcon.image = UIImage(named: name)
    }
    
    
}
