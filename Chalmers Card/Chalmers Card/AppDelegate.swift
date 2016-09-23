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
    var cardRepository: CardRepository?
    var shouldUpdate = false
    
    override init() {
        super.init()
        
        let api: CardDataProtocol
        let storage: StorageProtocol
        
        if ProcessInfo.processInfo.arguments.contains("USE_FAKE_DATA") {
            api = MockCardDataService()
            storage = MockStorageService()
            print("Fake data")
        } else {
            api = CardAPIService()
            storage = KeychainService()
            print("Real data")
        }
        
        cardRepository = CardRepository(keychain: storage, api: api)
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        window!.tintColor = Config.tintColor
        
        return true
    }
    
    func application(_ application: UIApplication, performActionFor shortcutItem: UIApplicationShortcutItem, completionHandler: @escaping (Bool) -> Void) {
        if shortcutItem.type == "se.sharpmind.Chalmers-Card.refill" && cardRepository!.exists() {
            self.window?.rootViewController?.performSegue(withIdentifier: "refillSegue", sender: self)
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        shouldUpdate = true
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }

    func applicationWillTerminate(_ application: UIApplication) {
        
    }

    class func getShared() -> AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
}

