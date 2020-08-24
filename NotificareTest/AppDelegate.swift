//
//  AppDelegate.swift
//  NotificareTest
//
//  Created by Sébastien Kalb on 23/08/2020.
//  Copyright © 2020 Altissia International. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, NotificarePushLibDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        NotificarePushLib.shared().initialize(withKey: nil, andSecret: nil)
        NotificarePushLib.shared().delegate = self
        NotificarePushLib.shared().launch()
        NotificarePushLib.shared().didFinishLaunching(options: launchOptions)
        NotificarePushLib.shared().presentationOptions = .alert
        NotificarePushLib.shared().categoryOptions = .customDismissAction
        
        return true
    }
//
//    // MARK: UISceneSession Lifecycle
//
//    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
//        // Called when a new scene session is being created.
//        // Use this method to select a configuration to create the new scene with.
//        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
//    }
//
//    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
//        // Called when the user discards a scene session.
//        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
//        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
//    }

    func notificarePushLib(_ library: NotificarePushLib, onReady application: NotificareApplication) {
        print("🎉 notificarePushLib onReady 🎉")
        NotificarePushLib.shared().registerForNotifications()
    }

    func notificarePushLib(_ library: NotificarePushLib, didRegister device: NotificareDevice) {
        print("🎉 notificarePushLib didRegister 🎉")
    }

    func notificarePushLib(_ library: NotificarePushLib, didReceiveRemoteNotificationInForeground notification: NotificareNotification, withController controller: Any?) {
        print("🎉 notificarePushLib didReceiveRemoteNotificationInForeground: \(String(describing: notification.notificationTitle)) / \(String(describing: notification.notificationSubtitle)) / \(String(describing: notification.notificationMessage)) 🎉")
        //Here you probably don't want to interrupt the user and simply show that a notification has arrive with an in-app badge
    }

    func notificarePushLib(_ library: NotificarePushLib, didReceiveRemoteNotificationInBackground notification: NotificareNotification, withController controller: Any?) {
        print("🎉 notificarePushLib didReceiveRemoteNotificationInBackground: \(String(describing: notification.notificationTitle)) / \(String(describing: notification.notificationSubtitle)) / \(String(describing: notification.notificationMessage)) 🎉")
        //Notification arrive in background and user clicked on it from notfication center or lock screen, here you will want to present it to the user
    }

    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        print("🎉 UIApplication didRegisterForRemoteNotificationsWithDeviceToken 🎉")
        //If you want to register for remote notifications here it's safe to do it
        //You might want to consider calling this in response to a button in your on-boarding screen or some other place else
        NotificarePushLib.shared().didRegisterForRemoteNotifications(withDeviceToken: deviceToken)
    }

    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("🎉 UIApplication didFailToRegisterForRemoteNotificationsWithError: \(error.localizedDescription) 🎉")
    }

    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        print("🎉 UIApplication didReceiveRemoteNotification 🎉")
        NotificarePushLib.shared().didReceiveRemoteNotification(userInfo, completionHandler: {(_ response: Any?, _ error: Error?) -> Void in
            if error == nil {
                completionHandler(.newData)
            } else {
                completionHandler(.noData)
            }
        })
    }

    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], withResponseInfo responseInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print("🎉 UIApplication handleActionWithIdentifier withResponseInfo 🎉")
        NotificarePushLib.shared().handleAction(withIdentifier: identifier, forRemoteNotification: userInfo, withResponseInfo: responseInfo, completionHandler: {(_ response: Any?, _ error: Error?) -> Void in
            completionHandler()
        })
    }

    func application(_ application: UIApplication, handleActionWithIdentifier identifier: String?, forRemoteNotification userInfo: [AnyHashable : Any], completionHandler: @escaping () -> Void) {
        print("🎉 UIApplication handleActionWithIdentifier 🎉")
        NotificarePushLib.shared().handleAction(withIdentifier: identifier, forRemoteNotification: userInfo, withResponseInfo: nil, completionHandler: {(_ response: Any?, _ error: Error?) -> Void in
            completionHandler()
        })
    }
}

