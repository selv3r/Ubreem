//
//  AppDelegate.swift
//  Ubream-iOS
//
//  Created by Hassan Ashraf on 9/17/18.
//  Copyright © 2018 Intcore. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //Start Listening for Network
        NetworkManager.shared.startNetworkReachabilityObserver() // start Network lisner
        
        //Using IQKeyboardManager
        IQKeyboardManager.shared.enable = true
        
        // Override point for customization after application launch.
        let mainStoryboard = UIStoryboard(name: "Home", bundle: nil)
        let authStoryboard = UIStoryboard(name: "Authentication", bundle: nil)
        self.window = UIWindow(frame: UIScreen.main.bounds)
        var initialViewController: UIViewController
        //LanguageManager.shared.defaultLanguage = .en
        //LanguageManager.shared.setLanguage(language: .ar)
        if SavedUser.loadUser()?.apiToken != nil {
            if SavedUser.loadUser()?.activation == 1 || SavedUser.loadUser()?.activation == 2 {
                let homeVC = mainStoryboard.instantiateViewController(withIdentifier: "HomeTabBarVC") as! HomeTabBarVC
                initialViewController = homeVC
            } else {
                let loginVC = authStoryboard.instantiateInitialViewController()
                initialViewController = loginVC!
            }
        } else {
            let loginVC = authStoryboard.instantiateInitialViewController()
            initialViewController = loginVC!
        }
        self.window?.rootViewController = initialViewController
    
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

