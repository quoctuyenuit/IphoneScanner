//
//  AppDelegate.swift
//  IMEIScanner
//
//  Created by Anh Tuan on 8/4/19.
//  Copyright © 2019 Nguyễn Quốc Tuyến. All rights reserved.
//

import UIKit
import Firebase
import UserNotifications

enum Identifiers {
    static let viewAction = "VIEW_IDENTIFIER"
    static let newsCategory = "NEWS_CATEGORY"
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    static var rootVC: UIViewController?

    var orientationLock = UIInterfaceOrientationMask.portrait
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
//        window?.rootViewController = IMEIScannerRouter.createIMEIScannerView()
        self.showMainViewController()
//        Preferences.shared.setCurrentLocale(Languages.vi)
//        self.registerForPushNotifications()
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

    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    
//    func registerForPushNotifications() {
//        UNUserNotificationCenter.current() // 1
//            .requestAuthorization(options: [.alert, .sound, .badge])
//            { [weak self] granted, error in
//                print("Permission granted: \(granted)") // 3
//
//                guard granted else { return }
//                // 1
//                let viewAction = UNNotificationAction(
//                    identifier: Identifiers.viewAction, title: "View",
//                    options: [.foreground])
//
//                // 2
//                let newsCategory = UNNotificationCategory(
//                    identifier: Identifiers.newsCategory, actions: [viewAction],
//                    intentIdentifiers: [], options: [])
//                // 3
//                UNUserNotificationCenter.current()
//                    .setNotificationCategories([newsCategory])
//
//                self?.getNotificationSettings()
//        }
//    }
    
//    func getNotificationSettings() {
//        UNUserNotificationCenter.current().getNotificationSettings { settings in
//            print("Notification settings: \(settings)")
//            guard settings.authorizationStatus == .authorized else { return }
//            DispatchQueue.main.async {
//                UIApplication.shared.registerForRemoteNotifications()
//            }
//        }
//    }
    
//    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
//        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
//        let token = tokenParts.joined()
//        print("Device Token: \(token)")
//    }
//
//    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
//        print("Failed to register: \(error)")
//    }

}

extension AppDelegate {
    public func showMainViewController() {
        let tabviewController = TabBarViewController()
        let navigationController = UINavigationController(rootViewController: tabviewController)
        AppDelegate.rootVC = tabviewController
        self.window?.rootViewController = navigationController
    }
}
