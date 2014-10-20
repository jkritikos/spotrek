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
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String!) {
        
        super.init(style: UITableViewCellStyle.Default, reuseIdentifier: reuseIdentifier)
        
        optionLabel = UILabel(frame: CGRectMake(0,0,30,30))
        optionLabel.text = "test"
        self.addSubview(optionLabel)
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

}
