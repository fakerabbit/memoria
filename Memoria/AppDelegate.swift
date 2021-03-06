//
//  AppDelegate.swift
//  Memoria
//
//  Created by Mirko Justiniano on 2/27/17.
//  Copyright © 2017 MM. All rights reserved.
//

import UIKit
import CoreData
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var nav:NavController!
    let notificationDelegate = NotificationDelegate()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Create window.
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.backgroundColor = UIColor.darkGray
        UIApplication.shared.applicationIconBadgeNumber = 0
        
        let center = UNUserNotificationCenter.current()
        center.delegate = notificationDelegate
        let options: UNAuthorizationOptions = [.alert, .sound, .badge];
        let practiceAction = UNNotificationAction(identifier: "Practice", title: "Practice", options: [])
        let snoozeAction = UNNotificationAction(identifier: "Snooze",
                                                title: "Snooze", options: [])
        let category = UNNotificationCategory(identifier: "UYLReminderCategory",
                                              actions: [practiceAction,snoozeAction],
                                              intentIdentifiers: [], options: [])
        center.setNotificationCategories([category])
        center.requestAuthorization(options: options) {
            (granted, error) in
            if !granted {
                print("Something went wrong")
                let action = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                let controller = UIAlertController(title: "Notifications permissions needed", message: "This app uses app notifications. Please allow notifications for this app in settings.", preferredStyle: .alert)
                controller.addAction(action)
                self.window?.rootViewController?.present(controller, animated: true, completion: nil)
            }
        }
        center.getNotificationSettings { (settings) in
            if settings.authorizationStatus != .authorized {
                // Notifications not allowed
                let action = UIAlertAction(title: "Ok", style: .destructive, handler: nil)
                let controller = UIAlertController(title: "Notifications permissions needed", message: "This app uses app notifications. Please allow notifications for this app in settings.", preferredStyle: .alert)
                controller.addAction(action)
                self.window?.rootViewController?.present(controller, animated: true, completion: nil)
            }
        }
        
        let vc = LearnVC()
        nav = NavController(rootViewController: vc)
        window?.rootViewController = nav
        
        if !window!.isKeyWindow {
            window!.makeKeyAndVisible()
        }
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
        // Saves changes in the application's managed object context before the application terminates.
        DataMgr.sharedInstance.saveContext()
    }
}

