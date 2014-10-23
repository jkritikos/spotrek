//
//  profileSummaryViewController.swift
//  Spotrek
//
//  Created by Jason Kritikos on 10/16/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import Foundation
import UIKit

class ProfileSummaryViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    //navigation components
    var navigationDelegate:NavigationControllerDelegate!
    var savedTransitionType: TransitionType!
    var savedDismissalDuration : NSTimeInterval!
    
    //UI components
    var optionsTableView: UITableView!
    let profileCellIdentifier = "profileSummaryCell"
    
    //label styling
    let regularFont = [NSFontAttributeName:UIFont(name: "GillSans", size: 22.0)]
    let bigFont = [NSFontAttributeName:UIFont(name: "GillSans-Bold", size: 48.0)]
    
    
    override func loadView() {
        var singleton = SharedEnvironment.Instance()
        var currentUser = singleton.currentUser
        var backgroundColor = singleton.trekColors[currentUser.currentLevel!]
        
        self.view = UIView(frame:UIScreen.mainScreen().bounds)
        self.view.backgroundColor=UIColor(hex:backgroundColor!)
        
        //header view
        var headerView = ProfileSummaryHeaderView(frame: CGRectMake(0, 0, self.view.frame.width, 112))
        self.view.addSubview(headerView)
        
        optionsTableView = UITableView(frame: CGRectMake(100, 120, 800, 640))
        optionsTableView.backgroundColor = UIColor.clearColor().colorWithAlphaComponent(0.0)
        optionsTableView.rowHeight = 160
        self.view.addSubview(optionsTableView)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.multipleTouchEnabled = true
        
        self.optionsTableView.registerClass(ProfileSummaryTableViewCell.self, forCellReuseIdentifier: profileCellIdentifier)
        
        //Keep transitionType and duration in order to use them during dismissal
        navigationDelegate = navigationController?.delegate as NavigationControllerDelegate
        savedTransitionType = navigationDelegate.typeOfTransition
        savedDismissalDuration = navigationDelegate.dismissalDuration
        
        self.optionsTableView.dataSource = self
        self.optionsTableView.delegate = self
        
        // build the view
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func touchesBegan(touches: NSSet, withEvent event: UIEvent) {
        
        if (event.touchesForView(self.view)?.count > 1 ) {
            
            //restore saved values
            navigationDelegate.dismissalDuration = savedDismissalDuration
            navigationDelegate.typeOfTransition = savedTransitionType
            navigationController?.popViewControllerAnimated(true)
            
            
        } else{
            
            
            
        }
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier(profileCellIdentifier, forIndexPath:indexPath) as ProfileSummaryTableViewCell
        cell.selectionStyle = UITableViewCellSelectionStyle.None
        
        /*
        
        switch indexPath.row {
        case 0:
            cell.setIcon("images/ipad/profile/profile_level.png")
            
        
            var attributedString = NSMutableAttributedString(string:"")
            var string1 = NSMutableAttributedString(string: "YOU ARE CURRENTLY A\n", attributes:regularFont)
            var string2 = NSMutableAttributedString(string:"WALKER", attributes:bigFont)
            attributedString.appendAttributedString(string1)
            attributedString.appendAttributedString(string2)
            cell.optionLabel.attributedText = attributedString
            
            break
        case 1:
            cell.setIcon("images/ipad/profile/profile_stats.png")
            
            var attributedString = NSMutableAttributedString(string:"")
            var string1 = NSMutableAttributedString(string: "YOU HAVE A TOTAL OF\n", attributes:regularFont)
            var string2 = NSMutableAttributedString(string:"2345", attributes:bigFont)
            var string3 = NSMutableAttributedString(string:" MILES & ", attributes:regularFont)
            var string4 = NSMutableAttributedString(string:"7", attributes:bigFont)
            var string5 = NSMutableAttributedString(string:" HINTS", attributes:regularFont)
            attributedString.appendAttributedString(string1)
            attributedString.appendAttributedString(string2)
            attributedString.appendAttributedString(string3)
            attributedString.appendAttributedString(string4)
            attributedString.appendAttributedString(string5)
            cell.optionLabel.attributedText = attributedString
            
            break
        case 2:
            cell.setIcon("images/ipad/profile/profile_gallery.png")
            
            var attributedString = NSMutableAttributedString(string:"")
            var string1 = NSMutableAttributedString(string: "YOUR GALLERY INCLUDES\n", attributes:regularFont)
            var string2 = NSMutableAttributedString(string:"42", attributes:bigFont)
            var string3 = NSMutableAttributedString(string:" AMAZING ", attributes:regularFont)
            var string4 = NSMutableAttributedString(string:"PLACES", attributes:bigFont)
            attributedString.appendAttributedString(string1)
            attributedString.appendAttributedString(string2)
            attributedString.appendAttributedString(string3)
            attributedString.appendAttributedString(string4)
            cell.optionLabel.attributedText = attributedString
            
            break
        case 3:
            cell.setIcon("images/ipad/profile/profile_unlock.png")
            
            var attributedString = NSMutableAttributedString(string:"")
            var string1 = NSMutableAttributedString(string: "YOU HAVE UNLOCKED\n", attributes:regularFont)
            var string2 = NSMutableAttributedString(string:"5%", attributes:bigFont)
            var string3 = NSMutableAttributedString(string:" OF ", attributes:regularFont)
            var string4 = NSMutableAttributedString(string:"SPOTREK", attributes:bigFont)
            attributedString.appendAttributedString(string1)
            attributedString.appendAttributedString(string2)
            attributedString.appendAttributedString(string3)
            attributedString.appendAttributedString(string4)
            cell.optionLabel.attributedText = attributedString
            
            break
        default:
            break
        }
        */
        //cell.optionLabel = UILabel(frame: CGRectMake(50, 30, 100, 20))
        
        //cell.textLabel.text = "Baking Soda"
        //cell.detailTextLabel.text = "1/2 cup"
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        println("clicked on profile table row \(indexPath.row)")
    }
}