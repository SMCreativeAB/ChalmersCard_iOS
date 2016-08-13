//
//  AppDelegate.swift
//  Chalmers Card
//
//  Created by Jesper Lindström on 2016-08-11.
//  Copyright © 2016 SHARPMIND. All rights reserved.
//

import UIKit
import UIColor_Hex_Swift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var cardRepository = CardRepository()
    var shouldUpdate = false
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        window!.tintColor = Config.tintColor
        
        return true
    }
    
    func application(application: UIApplication, performActionForShortcutItem shortcutItem: UIApplicationShortcutItem, completionHandler: (Bool) -> Void) {
        if shortcutItem.type == "se.sharpmind.Chalmers-Card.refill" && cardRepository.exists() {
            self.window?.rootViewController?.performSegueWithIdentifier("refillSegue", sender: self)
        }
    }

    func applicationWillResignActive(application: UIApplication) {
        
    }

    func applicationDidEnterBackground(application: UIApplication) {
        shouldUpdate = true
    }

    func applicationWillEnterForeground(application: UIApplication) {
        
    }

    func applicationDidBecomeActive(application: UIApplication) {
        
    }

    func applicationWillTerminate(application: UIApplication) {
        
    }

    class func getShared() -> AppDelegate {
        return UIApplication.sharedApplication().delegate as! AppDelegate
    }
}

