//
//  AppDelegate.swift
//  SmitivApp
//
//  Created by Suresh on 08/08/18.
//  Copyright © 2018 SmitivApp. All rights reserved.
//

import UIKit
import PXGoogleDirections
import GoogleMaps

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var directionsAPI: PXGoogleDirections!

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
       
        
    
        UISegmentedControl.appearance().setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: "Avenir Next", size: 15.0)!], for: UIControlState())
        // TODO: For you fellow developer: replace `getGoogleAPI{Client|Server}Key()` in the line below with a string containing your own Google Maps API key!
        directionsAPI = PXGoogleDirections(apiKey:"AIzaSyCWLm5KB-FZqSUaYqdNCF8_SDb0ZcWGjnI") // A valid server-side API key is required here
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
        
        let date = Date()
        
        UserDefaults.standard.set(Date(), forKey:"background")
        
        UserDefaults.standard.set(date, forKey: "SecondsBackground")
        
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

