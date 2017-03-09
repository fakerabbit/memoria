//
//  NotificationDelegate.swift
//  Memoria
//
//  Created by Mirko Justiniano on 3/9/17.
//  Copyright © 2017 MM. All rights reserved.
//

import Foundation
import UIKit
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {
    
    // MARK:- Foreground App
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // Play sound and show alert to the user
        completionHandler([.alert,.sound])
    }
    
    // MARK:- Action in delivered notification
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        UIApplication.shared.applicationIconBadgeNumber = 0
        let userInfo = response.notification.request.content.userInfo
        
        // Determine the user action
        switch response.actionIdentifier {
        case UNNotificationDismissActionIdentifier:
            print("Dismiss Action")
        case UNNotificationDefaultActionIdentifier:
            practice(with: userInfo["cardId"] as! String)
        case "Snooze":
            let newDate = Date(timeInterval: 60, since: Date())
            scheduleNotification(at: newDate, for: userInfo["cardId"] as! String)
        case "Practice":
            practice(with: userInfo["cardId"] as! String)
        default:
            practice(with: userInfo["cardId"] as! String)
        }
        completionHandler()
    }
    
    func scheduleNotification(at date: Date,for cardId: String) {
        
        DataMgr.sharedInstance.fetchCard(for: cardId) { card in
            
            if card != nil {
                DataMgr.sharedInstance.programCard(card: card!, difficulty: Difficulty.easy.rawValue)
            }
        }
    }
    
    func practice(with cardId: String) {
        
        DataMgr.sharedInstance.fetchCard(for: cardId) { card in
            
            let application = UIApplication.shared.delegate  as! AppDelegate
            if card != nil {
                application.nav.startTest(for: card!)
            }
        }
    }
}
