//
//  AppDelegate.swift
//  MusicVideo
//
//  Created by Jim Hubbard on 8/5/16.
//  Copyright © 2016 Jim Hubbard. All rights reserved.
//

import UIKit
var reachability: Reachability?

var reachabilityStatus = " "



@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    var internetCheck: Reachability?

    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)), name: kReachabilityChangedNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(AppDelegate.reachabilityChanged(_:)), name: kReachabilityChangedNotification, object: nil)
        
        
        internetCheck = Reachability.reachabilityForInternetConnection()
        //Start wathing for changes in internet connectivity
        internetCheck?.startNotifier()
        
        
        //Check internet status at start-up
        statusChangedWithReachability(internetCheck!)
        
        
        // Override point for customization after application launch.
        return true
    }

    
    func reachabilityChanged(notification: NSNotification) {
        reachability = notification.object as? Reachability
        statusChangedWithReachability(reachability!)
        
    }
    
    func statusChangedWithReachability(currentReachabilityStatus:Reachability) {
        
        let networkStatus: NetworkStatus = currentReachabilityStatus.currentReachabilityStatus()
        
        switch networkStatus.rawValue {
        case NotReachable.rawValue: reachabilityStatus = NOACCESS
        case ReachableViaWiFi.rawValue: reachabilityStatus = WIFI
        case ReachableViaWWAN.rawValue: reachabilityStatus = WWAN
        default:return
        }
        
        //Post a notification here
        NSNotificationCenter.defaultCenter().postNotificationName("ReachStatusChanged",object:nil)
        
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
        
        NSNotificationCenter.defaultCenter().removeObserver(self, name: kReachabilityChangedNotification, object: nil)
        
        
        
    }


}

