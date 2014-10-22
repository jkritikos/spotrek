//
//  AppDelegate.swift
//  Spotrek
//
//  Created by Yannis Belessiotis on 10/3/14.
//  Copyright (c) 2014 Boomar. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
    
        //instantiate a window and make it applications window
        self.window = UIWindow(frame: UIScreen.mainScreen().bounds)
        
        //initialize the Viewcontroller that will be the main screen
        let mainScreen = MainViewController(nibName: nil, bundle: nil);
        
        //initialize a navigation controller using previously instantiated viewController
        let rootVc = UINavigationController(rootViewController: mainScreen)

        //hide navigation bar
        rootVc.navigationBarHidden = true
        
        //set previously instantiated navigationController as  window's rootViewController
        self.window!.rootViewController = rootVc
        
        //make window as key window and set it visible as well
        self.window!.makeKeyAndVisible()
        
        var singleton = SharedEnvironment.Instance()
        singleton.updateState()
        
        //create our user
        var user = User(userId: 1, token: "token", userName: "Christina Sigala", miles: 123, level: 1)
        user.currentLocation = "Unknown location"
        singleton.currentUser = user
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

